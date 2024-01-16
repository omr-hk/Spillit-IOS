//
//  ThreadsViewModel.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 14/01/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
@MainActor
class ThreadsViewModel: ObservableObject{
    static let shared = ThreadsViewModel()
    @Published var state: (LoadingState, String) = (.loading,"")
    @Published var lastSnapshot: QueryDocumentSnapshot? = nil
    @Published var notes: [NoteModel] = []
    @Published var userNotes: [NoteModel] = []
    
    let db = Firestore.firestore()
    func createNote(title: String, content: String, uid: String)async {
        state = (.loading,"")
        do{
            try await db.collection("Notes").addDocument(data: [
                "title" : title,
                "content" : content,
                "uid" : uid,
                "likes" : [],
                "time" : FieldValue.serverTimestamp()
            ])
            state = (.loaded,"Added Note")
        }catch{
            state = (.error,"\(error.localizedDescription)")
        }
    }
    
    func initialFetch() async {
        state = (.loading,"")
        let ref = db.collection("Notes").order(by: "time", descending: true).limit(to: 5)
        do{
            let querySnapshot = try await ref.getDocuments()
            self.lastSnapshot = querySnapshot.documents.last
            notes = querySnapshot.documents.map{(document) -> NoteModel in
                return NoteModel(id: document.documentID, title: document.data()["title"] as! String, content: document.data()["content"] as! String, uid: document.data()["uid"] as! String, likes: document.data()["likes"] as! [String])
            }
            state = (.loaded,"Notes loaded")
        }catch{
            state = (.error,"\(error.localizedDescription)")
        }
    }
    
    func nextFetch() async{
        if let snapshot = lastSnapshot{
            let ref = db.collection("Notes").order(by: "time",descending: true).start(afterDocument: snapshot).limit(to: 5)
            do{
                let querySnapshot = try await ref.getDocuments()
                self.lastSnapshot = querySnapshot.documents.last
                notes.append(contentsOf: querySnapshot.documents.map{(document) -> NoteModel in
                    return NoteModel(id: document.documentID, title: document.data()["title"] as! String, content: document.data()["content"] as! String, uid: document.data()["uid"] as! String, likes: document.data()["likes"] as! [String])
                })
                state = (.loaded," New Notes loaded")
            }catch{
                state = (.error,"\(error.localizedDescription)")
            }
        }
    }
    
    func fetchUsersPosts(uid: String) async {
        let ref = db.collection("Notes").whereField("uid", isEqualTo: uid).order(by: "time", descending: true)
        do{
            let querySnapshot = try await ref.getDocuments()
            userNotes = querySnapshot.documents.map{(document) -> NoteModel in
                return NoteModel(id: document.documentID, title: document.data()["title"] as! String, content: document.data()["content"] as! String, uid: document.data()["uid"] as! String, likes: document.data()["likes"] as! [String])
            }
            
            state = (.loaded,"User Notes loaded")
        }catch{
            state = (.error,"\(error.localizedDescription)")
        }
    }
    
    func likePost(id: String, uid: String) async{
        let ref = db.collection("Notes").document(id)
        do{
            try await ref.updateData([
                "likes" : FieldValue.arrayUnion([uid])
            ])
        }catch{
            
        }
    }
    
    func unlikePost(id: String, uid: String) async{
        let ref = db.collection("Notes").document(id)
        do{
            try await ref.updateData([
                "likes" : FieldValue.arrayRemove([uid])
            ])
        }catch{
            
        }
    }
    
    
}

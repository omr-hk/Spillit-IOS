//
//  UserViewModel.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 14/01/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

@MainActor
class UserViewModel: ObservableObject{
    static let shared = UserViewModel()
    @Published var state: (LoadingState, String) = (.loading,"")
    @Published var user: UserModel? = nil
    let db = Firestore.firestore()
    let cvm: ColorsViewModel = .shared
    func getUser(currentUID: String) async{
        let userdf = db.collection("UserData")
        do{
            let document = try await userdf.document(currentUID).getDocument()
            if document.exists{
                user = UserModel(displayName: document.data()!["displayName"] as! String, colorPreference: cvm.getEnum(value: document.data()!["colorPreference"] as! String), uid: currentUID)
                state = (.loaded,"")
            }
            else{
                try await userdf.document(currentUID).setData([
                    "displayName" : "",
                    "colorPreference" : "beige"
                ])
                user = .init(displayName: "", colorPreference: .beige, uid: currentUID)
                state = (.loaded,"")
            }
            
        } catch{
            state = (.error,"\(error.localizedDescription)")
        }
    }
    
    func addDisplayName(name: String, uid: String) async {
        let ref = db.collection("UserData").whereField("displayName", isEqualTo: name)
        do{
            let querySnapshot = try await ref.getDocuments()
            if querySnapshot.isEmpty{
                try await db.collection("UserData").document(uid).updateData([
                    "displayName" : name
                ])
                state = (.loaded,"Updated Display Name")
                if user != nil{
                    user?.displayName = name
                }
            }
            else{
                state = (.error,"exists")
            }
        }catch{
            state = (.error,"\(error.localizedDescription)")
        }
    }
    
    func getDisplayName(uid: String) async{
        let ref = db.collection("UserData").document(uid)
        do{
            let document = try await ref.getDocument()
            if document.exists{
                state = (.loaded,document.data()!["displayName"] as! String)
            }
        }catch{
            state = (.error,"\(error.localizedDescription)")
        }
    }
    
    func changeColorPreference(color: String) async {
        let ref = db.collection("UserData").document(user!.uid)
        do{
            try await ref.updateData([
                "colorPreference" : color
            ])
        }catch{
            
        }
    }
    
    func deleteAccountData() async -> Bool{
        let ref = db.collection("Notes").whereField("uid", isEqualTo: user!.uid)
        do{
            try await db.collection("UserData").document(user!.uid).delete()
            let querySnapshot = try await ref.getDocuments()
            if !querySnapshot.isEmpty{
                for document in querySnapshot.documents{
                   try await db.collection("Notes").document(document.documentID).delete()
                }
            }
            return true
        }catch{
            return false
        }
    }
    

}

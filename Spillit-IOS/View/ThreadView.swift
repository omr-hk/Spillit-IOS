//
//  ThreadView.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 12/01/24.
//

import SwiftUI

struct ThreadView: View {
    let CVM: ColorsViewModel = .shared
    @State var note: NoteModel
    @ObservedObject var uvm: UserViewModel = .shared
    @ObservedObject var tvm: ThreadsViewModel = .shared
    @State var dname: String = "Unavailable"
    var body: some View {
        VStack{
            Text(note.title)
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
                .multilineTextAlignment(.center)
            Text(note.content)
                .multilineTextAlignment(.center)
                .padding()
            HStack{
                if note.uid == uvm.user!.uid{
                    Image(systemName: "heart")
                        .font(.title3)
                }
                else{
                    if note.likes.contains(uvm.user!.uid){
                        Image(systemName: "heart.fill")
                            .font(.title3)
                            .onTapGesture {
                                note.likes.removeAll { like in
                                    like == uvm.user!.uid
                                }
                                Task{
                                    await tvm.unlikePost(id:note.id,uid:uvm.user!.uid)
                                }
                            }
                    }
                    else{
                        Image(systemName: "heart")
                            .font(.title3)
                            .onTapGesture {
                                note.likes.append(uvm.user!.uid)
                                Task{
                                    await tvm.likePost(id:note.id,uid:uvm.user!.uid)
                                }
                            }
                    }
                }
                Text("\(note.likes.count)")
                Spacer()
                if note.uid == uvm.user!.uid{
                    Image(systemName: "xmark.bin.circle.fill")
                        .font(.title3)
                        .foregroundStyle(.red)
                        .onTapGesture {
                            Task{
                                let r: Bool = await tvm.deleteNote(id: note.id)
                                if r{
                                    tvm.notes.removeAll(where: { element in
                                        element.id == note.id
                                    })
                                }
                            }
                        }
                    Spacer()
                }
                Text(dname)
                    .onAppear{
                        Task{
                            await uvm.getDisplayName(uid:note.uid)
                            if uvm.state.0 == .loaded{
                                dname = uvm.state.1
                            }
                        }
                    }
            }
            .font(.caption)
            .padding()
        }
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(CVM.getColors(value: uvm.user!.colorPreference)["thread"] ?? Color(red: 235/255, green: 217/255, blue: 180/255))
        .cornerRadius(15)
    }
}

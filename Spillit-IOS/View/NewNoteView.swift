//
//  NewNoteView.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 14/01/24.
//

import SwiftUI

struct NewNoteView: View {
    let CVM: ColorsViewModel = .shared
    @State var title = ""
    @State var content = ""
    @ObservedObject var tvm: ThreadsViewModel = .shared
    @ObservedObject var uvm: UserViewModel = .shared
    @FocusState.Binding var istFocused: Bool
    var body: some View {
        VStack{
            Spacer()
            ScrollView(.horizontal){
                HStack{
                    VStack{
                        TextField("Title", text: $title)
                            .focused($istFocused)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.9,height: 55)
                            .background(CVM.getColors(value: uvm.user!.colorPreference)["thread"] ?? Color(red: 235/255, green: 217/255, blue: 180/255))
                            .cornerRadius(15)
                        
                        Text("swipe right for content")
                            .font(.caption)
                            .foregroundStyle(.black)
                            .fontWeight(.light)
                            .padding()
                    }
                    
                    VStack{
                        if !istFocused{
                            HStack{
                                Text("Content")
                                    .font(.title3)
                                    .fontWeight(.light)
                                Spacer()
                            }
                            .padding()
                        }
                        TextEditor(text: $content)
                            .focused($istFocused)
                            .padding()
                            .scrollContentBackground(.hidden)
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: 300)
                            .background(CVM.getColors(value: uvm.user!.colorPreference)["thread"] ?? Color(red: 235/255, green: 217/255, blue: 180/255))
                            .cornerRadius(15)
                    }
                }
            }
            Spacer()
            
            Button(action: {
                if !title.isEmpty && !content.isEmpty{
                    Task{
                        istFocused = false
                        await tvm.createNote(title:title,content:content,uid:uvm.user!.uid)
                        switch tvm.state.0{
                        case .loading:
                            print("loading")
                        case .loaded:
                            title = ""
                            content=""
                        case .error:
                            print(tvm.state.1)
                        }
                        
                    }
                }
            }, label: {
                Text("Post")
                    .foregroundStyle(Color(.black))
                    .fontWeight(.light)
                    .padding()
                    .frame(width: 100)
                    .background(CVM.getColors(value: uvm.user!.colorPreference)["thread"] ?? Color(red: 235/255, green: 217/255, blue: 180/255))
                    .cornerRadius(20)
                    .padding()
            })
            
            Spacer()
            
            
        }
    }
}

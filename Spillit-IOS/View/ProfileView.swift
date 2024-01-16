//
//  ProfileView.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 14/01/24.
//

import SwiftUI

struct ProfileView: View {
    let CVM: ColorsViewModel = .shared
    @State var isPresented: Bool = false
    @State var newDisplayName: String = ""
    @State var showError: Bool = false
    @State var errorMessage:String = ""
    @ObservedObject var uvm: UserViewModel = .shared
    @ObservedObject var tvm: ThreadsViewModel = .shared
    @FocusState private var isFocused: Bool
    var body: some View {
        VStack{
            Text("Display Name")
                .padding()
                .fontWeight(.light)
            Text(uvm.user!.displayName.isEmpty ? "Set up display name to add posts" : uvm.user!.displayName)
                .fontWeight(uvm.user!.displayName.isEmpty ? .light : .semibold)
                .foregroundStyle(uvm.user!.displayName.isEmpty ? .red : .black)
                .multilineTextAlignment(.center)
                .padding()
            Button(action: {
                isPresented.toggle()
            }, label: {
                Image(systemName: "pencil")
                    .padding()
                    .foregroundStyle(.black)
            })
        }
        .font(.title2)
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(CVM.getColors(value: uvm.user!.colorPreference)["thread"] ?? Color(red: 235/255, green: 217/255, blue: 180/255))
        .cornerRadius(15)
        .sheet(isPresented: $isPresented) {
            ZStack{
                VStack{
                    Text("Display Name")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                    TextField("Type here", text: $newDisplayName)
                        .focused(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=$isFocused@*/FocusState<Bool>().projectedValue/*@END_MENU_TOKEN@*/)
                        .padding()
                        .frame(height: 55)
                        .background(Color(red: 245/255, green: 246/255, blue: 247/255,opacity:0.5))
                        .cornerRadius(15)
                        .padding()
                    
                    if showError{
                        Text(errorMessage)
                            .padding()
                            .foregroundStyle(.red)
                            .fontWeight(.light)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        Task{
                            if !newDisplayName.isEmpty{
                                await uvm.addDisplayName(name: newDisplayName, uid: uvm.user!.uid)
                                switch uvm.state.0{
                                case .error:
                                    if uvm.state.1 == "exists"{
                                        errorMessage = "Display Name already exists"
                                        showError = true
                                    }
                                    else{
                                        errorMessage = uvm.state.1
                                        showError = true
                                    }
                                case .loaded:
                                    errorMessage = ""
                                    showError = false
                                    isPresented.toggle()
                                    uvm.user!.displayName = newDisplayName
                                    
                                case .loading:
                                    print("loading")
                                }
                            }
                        }
                    }) {
                        Text("Update")
                            .padding()
                            .foregroundStyle(.black)
                            .frame(width: 300)
                            .background(Color(red: 245/255, green: 246/255, blue: 247/255,opacity:0.5))
                            .cornerRadius(15)
                    }
                    
                    Button(action: {
                        isPresented.toggle()
                        showError = false
                        errorMessage = ""
                    }) {
                        Text("Dismiss")
                            .padding()
                            .foregroundStyle(.black)
                            .frame(width: 300)
                            .background(Color(red: 245/255, green: 246/255, blue: 247/255,opacity:0.5))
                            .cornerRadius(15)
                    }
                }
                .padding()
            }
            .presentationDetents([.height(500)])
            .presentationBackground(CVM.getColors(value: uvm.user!.colorPreference)["thread"] ?? Color(red: 235/255, green: 217/255, blue: 180/255))
            .onTapGesture {
                isFocused = false
            }
        }
        
        ScrollView(showsIndicators:false){
            if tvm.userNotes.isEmpty{
                EmptyThreadsView()
            }
            else{
                ForEach(tvm.userNotes, id: \.self){ note in
                    ThreadView(note: note)
                }
            }
        }
        .onAppear{
            Task{
                await tvm.fetchUsersPosts(uid:uvm.user!.uid)
            }
        }
    }
}


//
//  CanvasView.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 12/01/24.
//

import SwiftUI

struct CanvasView: View {
    let CVM: ColorsViewModel = .shared
    @State var page: PageLocation = .loading
    @ObservedObject var uvm: UserViewModel = .shared
    @ObservedObject var tvm: ThreadsViewModel = .shared
    @AppStorage("uid") var uid = ""
    @State var house = "house.fill"
    @State var new = "plus.circle"
    @State var profile = "person"
    @State var settings = "gearshape"
    @FocusState var istFocused: Bool
    @Binding var appState: AppState
    var body: some View {
        switch uvm.state.0{
        case .loading:
            LoadingView()
                .onAppear{
                    Task{
                        await uvm.getUser(currentUID:uid)
                    }
                }
        case .loaded:
            if uvm.user != nil{
                ZStack{
                    VStack{
                        VStack{
                            //Starts from here
                            switch page {
                            case .home:
                                ThreadsView(page: $page)
                                    .onAppear{
                                        page = .home
                                        house = "house.fill"
                                        new = "plus.circle"
                                        profile = "person"
                                        settings = "gearshape"
                                    }
                            case .new:
                                NewNoteView(istFocused: $istFocused)
                                    .onAppear{
                                        if uvm.user!.displayName.isEmpty{
                                            page = .profile
                                        }
                                        house = "house"
                                        new = "plus.circle.fill"
                                        profile = "person"
                                        settings = "gearshape"
                                    }
                            case .profile:
                                ProfileView()
                                    .onAppear{
                                        house = "house"
                                        new = "plus.circle"
                                        profile = "person.fill"
                                        settings = "gearshape"
                                    }
                            case .error:
                                ErrorView()
                            case .loading:
                                LoadingThreadsView()
                                    .onAppear{
                                        Task{
                                            await tvm.initialFetch()
                                            switch tvm.state.0{
                                            case .loading:
                                                print("loading")
                                            case .loaded:
                                                print(tvm.state.1)
                                                page = .home
                                            case .error:
                                                print(tvm.state.1)
                                                page = .error
                                            }
                                            
                                        }
                                    }
                            case .settings:
                                SettingsView(appState: $appState)
                                    .onAppear{
                                        house = "house"
                                        new = "plus.circle"
                                        profile = "person"
                                        settings = "gearshape.fill"
                                        page = .settings
                                    }
                            }

                            //Ends here
                        }
                        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .onTapGesture {
                            istFocused = false
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 80){
                            Image(systemName: house)
                                .onTapGesture {
                                    Task{
                                        await tvm.initialFetch()
                                    }
                                    page = .home
                                }
                            Image(systemName: new)
                                .onTapGesture {
                                    page = .new
                                }
                            Image(systemName: profile)
                                .onTapGesture {
                                    page = .profile
                                }
                            Image(systemName: settings)
                                .onTapGesture {
                                    page = .settings
                                }
                        }
                        .padding()
                        .frame(height: 70)
                        .background(CVM.getColors(value: uvm.user!.colorPreference)["thread"] ?? Color(red: 235/255, green: 217/255, blue: 180/255))
                        .cornerRadius(15)
                        .ignoresSafeArea(.keyboard)
                    }
                    .padding()
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
                .background(CVM.getColors(value: uvm.user!.colorPreference)["background"] ?? Color(red: 192/255, green: 150/255, blue: 94/255),ignoresSafeAreaEdges: .all)
            }
            else{
                LoadingView()
                    .onAppear{
                        Task{
                            await uvm.getUser(currentUID:uid)
                        }
                    }
            }

        case .error:
            ErrorView()
        }
    }
}












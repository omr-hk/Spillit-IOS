//
//  SettingsView.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 14/01/24.
//

import SwiftUI

struct SettingsView: View {
    let CVM: ColorsViewModel = .shared
    @ObservedObject var uvm: UserViewModel = .shared
    @ObservedObject var avm: AuthenticationViewModel = .init()
    @AppStorage("uid") var uid = ""
    @Binding var appState: AppState
    @State var isPresented: Bool = false
    var body: some View {
        VStack{
            Spacer()
            Grid{
                Text("Colors")
                    .font(.title)
                    .fontWeight(.light)
                GridRow{
                    ColorTile(color: .beige)
                    ColorTile(color: .blue)
                    ColorTile(color: .green)
                }
                GridRow{
                    ColorTile(color: .orange)
                    ColorTile(color: .pink)
                    ColorTile(color: .purple)
                }
            }
            
            Spacer()
            
            VStack{
                Button(action: {
                    Task{
                        await avm.signOut()
                        if avm.state.0 == .success{
                            uid = ""
                            withAnimation {
                                appState = .loading
                            }
                            print("User signed out successfully")
                        }
                        else{
                            print(avm.state.1)
                        }
                    }
                }, label: {
                    Text("Logout")
                        .foregroundStyle(.black)
                        .fontWeight(.light)
                        .font(.title3)
                        .padding()
                        .frame(width: 300,height: 55)
                        .background(CVM.getColors(value: uvm.user!.colorPreference)["thread"])
                        .cornerRadius(15)
                })
                
                Button(action: {
                    isPresented.toggle()
                }, label: {
                    Text("Delete Account")
                        .foregroundStyle(.red)
                        .fontWeight(.semibold)
                        .font(.title3)
                        .padding()
                        .frame(width: 300,height: 55)
                        .background(CVM.getColors(value: uvm.user!.colorPreference)["thread"])
                        .cornerRadius(15)
                })
                .sheet(isPresented: $isPresented){
                    VStack{
                        Text("Delete Account")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding()
                        Text("By clicking the Delete below button, your posts and all your data will be deleted along with your account")
                            .padding()
                            .fontWeight(.light)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                        
                        Button(action: {
                            isPresented.toggle()
                        }) {
                            Text("Dismiss")
                                .padding()
                                .foregroundStyle(.black)
                                .frame(width: 300)
                                .background(Color(red: 245/255, green: 246/255, blue: 247/255,opacity:0.5))
                                .cornerRadius(15)
                        }
                        
                        Button(action: {
                            Task{
                                let result: Bool = await uvm.deleteAccountData()
                                if result{
                                    await avm.deletAccount()
                                    if avm.state.0 == .success{
                                        isPresented.toggle()
                                        uid = ""
                                        withAnimation {
                                            appState = .loading
                                        }
                                    }
                                }
                                
                            }
                        }) {
                            Text("Delete")
                                .padding()
                                .foregroundStyle(.red)
                                .frame(width: 300)
                                .background(Color(red: 245/255, green: 246/255, blue: 247/255,opacity:0.5))
                                .cornerRadius(15)
                        }
                    }
                    .presentationDetents([.height(500)])
                    .presentationBackground(CVM.getColors(value: uvm.user!.colorPreference)["thread"] ?? Color(red: 235/255, green: 217/255, blue: 180/255))
                }
            }
            .padding()
        }
    }
}



struct ColorTile: View {
    let color: ColorsEnum
    let cvm: ColorsViewModel = .shared
    @ObservedObject var uvm: UserViewModel = .shared
    var body: some View {
        Button(action: {
            Task{
                withAnimation {
                    uvm.user!.colorPreference = color
                }
                await uvm.changeColorPreference(color:cvm.getString(value: color))
            }
        }, label: {
            VStack{
            }
            .frame(width: 80, height:80)
            .background(cvm.getColors(value: color)["background"]!)
            .cornerRadius(15)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.black, lineWidth: 1.5)
            )
        })
    }
}

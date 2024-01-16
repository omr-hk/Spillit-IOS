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
                            appState = .loading
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
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Delete Account")
                        .foregroundStyle(.red)
                        .fontWeight(.semibold)
                        .font(.title3)
                        .padding()
                        .frame(width: 300,height: 55)
                        .background(CVM.getColors(value: uvm.user!.colorPreference)["thread"])
                        .cornerRadius(15)
                })
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
                uvm.user!.colorPreference = color
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

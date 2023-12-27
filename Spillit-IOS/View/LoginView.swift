//
//  LoginView.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 27/12/23.
//

import SwiftUI
import AuthenticationServices
import CryptoKit


struct LoginView: View {
    var body: some View {
        ZStack{
            VStack{
                Text("Spillit")
                    .font(.system(size: 80))
                    .foregroundStyle(Color(red: 44/255, green: 92/255, blue: 102/255))
                    .fontWeight(.heavy)
                Button {
                    
                } label: {
                    SignInWithAppleButtonViewRepresentable(type: .default, style: .white)
                        .frame(height: 55)
                        .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
                }

                

                
            }
            .padding()
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
        .background(Color(.black),ignoresSafeAreaEdges: .all)
    }
}

#Preview {
    LoginView()
}

struct SignInWithAppleButtonViewRepresentable: UIViewRepresentable{
    let type:ASAuthorizationAppleIDButton.ButtonType
    let style: ASAuthorizationAppleIDButton.Style
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: type, style: style)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
}

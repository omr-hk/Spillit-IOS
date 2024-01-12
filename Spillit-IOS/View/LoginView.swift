//
//  LoginView.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 27/12/23.
//

import SwiftUI
import AuthenticationServices
import CryptoKit
import GoogleSignInSwift


struct LoginView: View {
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Text("Spillit")
                    .font(Font.custom("Pacifico-Regular", size: 80))
                    .foregroundStyle(Color(.black))
                Spacer()
                Spacer()
                Button {
                    
                } label: {
                    SignInWithAppleButtonViewRepresentable(type: .default, style: .white)
                        .frame(height: 55)
                        .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
                }
                
                Button(action: {
                    
                }, label: {
                    HStack{
                        Image(uiImage: UIImage(named: "google")!)
                            .foregroundColor(.white)
                        Text("Sign in with Google")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundStyle(Color(.white))
                    }
                    .frame(maxWidth: .infinity,maxHeight: 55)
                    .background(Color(red: 77/255, green: 138/255, blue: 236/255))
                    .cornerRadius(7)
                    
                })
                
                Spacer()

                
            }
            .padding()
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
        .background(Color(red: 192/255, green: 150/255, blue: 94/255),ignoresSafeAreaEdges: .all)
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

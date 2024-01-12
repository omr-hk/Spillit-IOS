//
//  AuthenticationViewModel.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 06/01/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

@MainActor
final class AuthenticationViewModel:ObservableObject{
    func signInWithGoogle() async throws{
        guard let tvc = Utilities.shared.topViewController() else {
            // return some error here
            return
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: tvc)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else{
            //return an error
            return
        }
        
        let accessToken = gidSignInResult.user.accessToken.tokenString
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        
            
    }
}

//
//  AuthenticationViewModel.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 06/01/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

enum AuthState{
    case success
    case failure
    case loading
}

@MainActor
final class AuthenticationViewModel:ObservableObject{
    @Published var state: (AuthState, String) = (.loading, "")
    func signInWithGoogle() async throws{
        guard let tvc = Utilities.shared.topViewController() else {
            state = (.failure,"Could not load app")
            return
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: tvc)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else{
            state = (.failure,"Could not sign in user")
            return
        }
        
        let accessToken = gidSignInResult.user.accessToken.tokenString
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        let result = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        state = (.success,result.uid)
        
            
    }
    
    func signOut() async{
        state = await AuthenticationManager.shared.signOut()
    }
    
    func deletAccount() async{
        state = await AuthenticationManager.shared.deleteAccount()
    }
}

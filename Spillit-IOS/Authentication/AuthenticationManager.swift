//
//  AuthenticationManager.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 06/01/24.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

struct AuthDataResultModel{
    let uid: String
    let name: String?
    
    init(user: User) {
        self.uid = user.uid
        self.name = user.displayName
    }
}

struct GoogleSignInResultModel{
    let idToken: String
    let accessToken: String
}

final class AuthenticationManager{
    static let shared = AuthenticationManager()
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel{
        let authResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authResult.user)
    }
    
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel{
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
}

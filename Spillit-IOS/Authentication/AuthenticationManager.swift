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
    
    func signOut() async -> (AuthState, String){
        let auth = Auth.auth()
        do{
            try auth.signOut()
            return (.success,"Logged out user")
        }catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            return (.failure,"\(signOutError)")
          }
    }
    
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel{
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    func checkUser() async -> (Bool, String){
        if Auth.auth().currentUser != nil{
            return (true, Auth.auth().currentUser!.uid)
        }
        else{
            return (false, "No user found")
        }
    }
    
    func deleteAccount() async -> (AuthState, String){
        do{
            try await Auth.auth().currentUser?.delete()
        }catch{
            return (.failure,"\(error.localizedDescription)")
        }
        
        return (.success,"Deleted user")
    }
}

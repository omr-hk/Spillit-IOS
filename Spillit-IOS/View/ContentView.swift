//
//  ContentView.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 27/12/23.
//

import SwiftUI

struct ContentView: View {
    @State var appState: AppState = .loading
    @AppStorage("uid") var uid: String = ""
    let v: Int = 50
    let am: AuthenticationManager = .shared
    var body: some View {
        switch appState {
        case .loading:
            LoadingView()
                .onAppear{
                    Task{
                        let result:(Bool, String) = await am.checkUser()
                        if result.0{
                            uid = result.1
                            withAnimation {
                                appState = .homepage
                            }
                        }
                        else{
                            withAnimation {
                                appState = .login
                            }
                        }
                    }
                }
        case .login:
            LoginView(appState: $appState)
        case .homepage:
            CanvasView(appState: $appState)
        case .error:
            ErrorView(content: "Error at loading")
        }
    }
}

#Preview {
    ContentView()
}

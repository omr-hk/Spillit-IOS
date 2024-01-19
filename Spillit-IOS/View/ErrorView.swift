//
//  ErrorView.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 14/01/24.
//

import SwiftUI

struct ErrorView: View {
    let content: String
    var body: some View {
        ZStack{
            VStack{
                Image(systemName: "x.square")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .padding()
                    .padding()
                Text("An error has occured")
                    .font(Font.custom("Pacifico-Regular", size: 30))
                    .foregroundStyle(.white)
                
                Text(content)
                    .foregroundStyle(.red)
                    .padding()
                    .multilineTextAlignment(.center)
                    .frame(width: 350)
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
        .background(Color(.black),ignoresSafeAreaEdges: .all)
    }
}

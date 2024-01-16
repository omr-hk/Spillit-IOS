//
//  EmptyThreadsView.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 13/01/24.
//

import SwiftUI

struct EmptyThreadsView: View {
    let CVM: ColorsViewModel = .shared
    @ObservedObject var uvm: UserViewModel = .shared
    var body: some View {
        VStack{
            Text("No posts yet")
                .font(Font.custom("Pacifico-Regular", size: 30))
                .fontWeight(.semibold)
                .padding()
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(CVM.getColors(value: uvm.user!.colorPreference)["thread"] ?? Color(red: 235/255, green: 217/255, blue: 180/255))
        .cornerRadius(15)
    }
}


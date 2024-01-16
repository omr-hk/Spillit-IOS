//
//  LoadingThreadsView.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 13/01/24.
//

import SwiftUI

struct LoadingThreadsView: View {
    let CVM: ColorsViewModel = .shared
    @ObservedObject var uvm: UserViewModel = .shared
    let captionText = "..."
    @State var caption = ""
    var body: some View {
        VStack{
            Text("loading")
                .font(Font.custom("Pacifico-Regular", size: 40))
                .fontWeight(.semibold)
                .padding()
                .multilineTextAlignment(.center)
            Text("."+caption)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .onAppear{
                    typeWriter()
                }
        }
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(CVM.getColors(value: uvm.user!.colorPreference)["thread"] ?? Color(red: 235/255, green: 217/255, blue: 180/255))
        .cornerRadius(15)
    }
    
    func typeWriter(at position: Int = 0)  {
        if position == 0 {
            caption = ""
        }
        if position < captionText.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                caption.append(captionText[String.Index(utf16Offset: position, in: caption)])
                 typeWriter(at: position + 1)
            }
        }
        else{
             typeWriter(at: 0)
        }
    }
}

//
//  LoadingView.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 12/01/24.
//

import SwiftUI

struct LoadingView: View {
    @State var caption:String = ""
    let captionText: String = "....."
    var body: some View {
        ZStack{
            VStack{
                Text("loading")
                    .font(Font.custom("Pacifico-Regular", size: 60))
                    .foregroundStyle(Color(.white))
                Text("."+caption)
                    .foregroundStyle(Color(.white))
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
        .background(Color(.black), ignoresSafeAreaEdges: .all)
        .onAppear{
              typeWriter()
        }
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

#Preview {
    LoadingView()
}

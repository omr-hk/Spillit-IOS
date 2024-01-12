//
//  CanvasView.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 12/01/24.
//

import SwiftUI

struct CanvasView: View {
    @State var color: ColorsEnum = .beige
    let CVM: ColorsViewModel = .shared
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    ThreadView(color: color)
                }
                .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                HStack(spacing: 80){
                    Image(systemName: "house.fill")
                    Image(systemName: "plus.circle")
                    Image(systemName: "person.fill")
                    Image(systemName: "gearshape.fill")
                }
                .padding()
                .frame(height: 70)
                .background(CVM.getColors(value: color)["thread"] ?? Color(red: 235/255, green: 217/255, blue: 180/255))
                .cornerRadius(15)
            }
            .padding()
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
        .background(CVM.getColors(value: color)["background"] ?? Color(red: 192/255, green: 150/255, blue: 94/255),ignoresSafeAreaEdges: .all)
    }
}

#Preview {
    CanvasView()
}

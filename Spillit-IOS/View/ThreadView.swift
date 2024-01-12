//
//  ThreadView.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 12/01/24.
//

import SwiftUI

struct ThreadView: View {
    let CVM: ColorsViewModel = .shared
    let color: ColorsEnum
    var body: some View {
        VStack{
            Text("Aliquam volutpat pharetra ex v")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
                .multilineTextAlignment(.center)
            Text("Aliquam volutpat pharetra ex vel pharetra. Sed eget nunc at eros lacinia facilisis. Etiam consectetur quam at semper condimentum. Suspendisse potenti. Sed dolor tortor, volutpat sit amet leo a, tristique semper dui. Donec eget suscipit augue, in finibus velit. Curabitur ac dui pulvinar, pellentesque purus et, ultricies leo. Aliquam venenatis, mauris posuere rutrum iaculis, quam tortor porta eros, luctus fringilla dolor sapien ac purus. Aliquam luctus nec nunc at congue.")
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(CVM.getColors(value: color)["thread"] ?? Color(red: 235/255, green: 217/255, blue: 180/255))
        .cornerRadius(15)
    }
}

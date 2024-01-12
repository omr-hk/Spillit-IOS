//
//  ColorsViewModel.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 12/01/24.
//

import Foundation
import SwiftUI

class ColorsViewModel{
    static let shared = ColorsViewModel()
    func getColors(value: ColorsEnum) -> [String : Color]{
        switch value {
        case .beige:
            return [
                "background" : Color(red: 192/255, green: 150/255, blue: 94/255),
                "thread" : Color(red: 235/255, green: 217/255, blue: 180/255)
            ]
        case .green:
            return [
                "background" : Color(red: 136/255, green: 171/255, blue: 142/255),
                "thread" : Color(red: 175/255, green: 200/255, blue: 173/255)
            ]
        case .blue:
            return [
                "background" : Color(red: 180/255, green: 212/255, blue: 255/255),
                "thread" : Color(red: 238/255, green: 245/255, blue: 255/255)
            ]
        case .pink:
            return [
                "background" : Color(red: 253/255, green: 206/255, blue: 223/255),
                "thread" : Color(red: 248/255, green: 232/255, blue: 238/255)
            ]
        case .orange:
            return [
                "background" : Color(red: 253/255, green: 217/255, blue: 152/255),
                "thread" : Color(red: 255/255, green: 236/255, blue: 199/255)
            ]
        }
    }
}

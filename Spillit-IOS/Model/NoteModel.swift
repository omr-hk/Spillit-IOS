//
//  NoteModel.swift
//  Spillit-IOS
//
//  Created by Omar Hassan on 15/01/24.
//

import Foundation

struct NoteModel: Hashable{
    let id: String
    let title: String
    let content: String
    let uid: String
    var likes: [String]
}

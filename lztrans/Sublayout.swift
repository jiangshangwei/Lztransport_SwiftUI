//
//  Sublayout.swift
//  lztrans
//
//  Created by jsw_cool on 2023/8/16.
//

import Foundation

struct Sublayout:Codable {
    var subLayoutSort:String
    var subLayoutStyle:String
    var subLayoutTitle:String
    var subLayoutType:String
    var hideContent:[LLContent]
    var content:[LLContent]
}

struct LLContent:Codable {
    var contentTime:String
    var image:String
    var link:String
    var name:String
    var provider:String
    var shareable:String
    var shareableThumbnail:String
    var sort:Int
}

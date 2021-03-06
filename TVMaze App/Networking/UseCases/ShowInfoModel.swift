//
//  ShowModel.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import Foundation

struct BaseShowInfoModel: Decodable {
    var score: Double?
    var show: ShowInfoModel
}

struct ShowInfoModel: Decodable {
    var id: Int
    var name: String
    var summary: String?
    var image: ImageSizes?
}

struct ImageSizes: Decodable {
    var medium: String?
    var original: String?
}

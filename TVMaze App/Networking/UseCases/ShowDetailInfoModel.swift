//
//  ShowDetailInfoModel.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import Foundation

struct ShowDetailInfoModel: Decodable {
    var name: String
    var id: Int
    var summary: String
    var schedule: Schedule
    var genres: [String]
    var image: ImageSizes?
    var _embedded: BaseEpisodes
    
}

struct BaseEpisodes: Decodable {
    var episodes: [ShowEpisode]
}

struct Schedule: Decodable {
    var time: String
    var days: [String]
}

struct ShowEpisode: Decodable {
    var id: Int
    var name: String
    var season: Int
    var number: Int
    var image: ImageSizes?
    var summary: String?
}



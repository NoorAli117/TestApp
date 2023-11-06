//
//  MoviesModel.swift
//  TestApp
//
//  Created by Noor on 06/11/2023.
//

import Foundation

struct MovieList: Codable {
    var movies: [Movie]
}

struct Movie: Codable {
    var title: String
    var director: String
    var year: Int
    var image: String
}

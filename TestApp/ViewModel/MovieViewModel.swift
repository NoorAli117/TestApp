//
//  MovieViewModel.swift
//  TestApp
//
//  Created by Noor on 06/11/2023.
//

import Foundation
import SwiftUI

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    
    init() {
        // Parse the JSON data and populate the 'movies' array
        if let jsonData = jsonDataFromString {
            do {
                let movieList = try JSONDecoder().decode(MovieList.self, from: jsonData)
                movies = movieList.movies
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
    
    
    private var jsonDataFromString = """
    {
      "movies": [
        {
          "title": "Movie 1",
          "director": "Director 1",
          "year": 2020,
          "image": "https://www.kasandbox.org/programming-images/avatars/spunky-sam.png"
        },
        {
          "title": "Movie 2",
          "director": "Director 2",
          "year": 2019,
          "image": "https://www.kasandbox.org/programming-images/avatars/spunky-sam-green.png"
        },
        {
          "title": "Movie 3",
          "director": "Director 3",
          "year": 2018,
          "image": "https://www.kasandbox.org/programming-images/avatars/purple-pi.png"
        },
        {
          "title": "Movie 4",
          "director": "Director 4",
          "year": 2017,
          "image": "https://www.kasandbox.org/programming-images/avatars/purple-pi-teal.png"
        },
        {
          "title": "Movie 5",
          "director": "Director 5",
          "year": 2016,
          "image": "https://www.kasandbox.org/programming-images/avatars/purple-pi-pink.png"
        },
        {
          "title": "Movie 6",
          "director": "Director 6",
          "year": 2015,
          "image": "https://www.kasandbox.org/programming-images/avatars/primosaur-ultimate.png"
        },
        {
          "title": "Movie 7",
          "director": "Director 7",
          "year": 2014,
          "image": "https://www.kasandbox.org/programming-images/avatars/primosaur-tree.png"
        },
        {
          "title": "Movie 8",
          "director": "Director 8",
          "year": 2013,
          "image": "https://www.kasandbox.org/programming-images/avatars/primosaur-sapling.png"
        },
        {
          "title": "Movie 9",
          "director": "Director 9",
          "year": 2012,
          "image": "https://www.kasandbox.org/programming-images/avatars/orange-juice-squid.png"
        },
        {
          "title": "Movie 10",
          "director": "Director 10",
          "year": 2011,
          "image": "https://www.kasandbox.org/programming-images/avatars/old-spice-man.png"
        },
        {
          "title": "Movie 11",
          "director": "Director 11",
          "year": 2010,
          "image": "https://www.kasandbox.org/programming-images/avatars/old-spice-man-blue.png"
        },
        {
          "title": "Movie 12",
          "director": "Director 12",
          "year": 2009,
          "image": "https://www.kasandbox.org/programming-images/avatars/mr-pants.png"
        },
        {
          "title": "Movie 13",
          "director": "Director 13",
          "year": 2008,
          "image": "https://www.kasandbox.org/programming-images/avatars/mr-pants-purple.png"
        },
        {
          "title": "Movie 14",
          "director": "Director 14",
          "year": 2007,
          "image": "https://www.kasandbox.org/programming-images/avatars/mr-pants-green.png"
        },
        {
          "title": "Movie 15",
          "director": "Director 15",
          "year": 2006,
          "image": "https://www.kasandbox.org/programming-images/avatars/marcimus.png"
        },
        {
          "title": "Movie 16",
          "director": "Director 16",
          "year": 2005,
          "image": "https://www.kasandbox.org/programming-images/avatars/marcimus-red.png"
        },
        {
          "title": "Movie 17",
          "director": "Director 17",
          "year": 2004,
          "image": "https://www.kasandbox.org/programming-images/avatars/marcimus-purple.png"
        },
        {
          "title": "Movie 18",
          "director": "Director 18",
          "year": 2003,
          "image": "https://www.kasandbox.org/programming-images/avatars/marcimus-orange.png"
        },
        {
          "title": "Movie 19",
          "director": "Director 19",
          "year": 2002,
          "image": "https://www.kasandbox.org/programming-images/avatars/duskpin-ultimate.png"
        },
        {
          "title": "Movie 20",
          "director": "Director 20",
          "year": 2001,
          "image": "https://www.kasandbox.org/programming-images/avatars/duskpin-tree.png"
        }
      ]
    }

""".data(using: .utf8)
}

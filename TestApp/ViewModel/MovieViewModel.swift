//
//  MovieViewModel.swift
//  TestApp
//
//  Created by Noor on 06/11/2023.
//

import Foundation
import SwiftUI
import Combine



class MovieViewModel: ObservableObject {
    @Published var movies: [Movies] = []
    @Published var movieDetail: Movie?
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(){
        fetchPopularMovies()
    }

    func fetchPopularMovies() {
        // Define the URL for the API request
        let apiKey = "3df5973bb3bd6389fe5617a80a85c129"
        let baseURL = "https://api.themoviedb.org/3/movie/popular"
        guard var urlComponents = URLComponents(string: baseURL) else {
            return
        }

        urlComponents.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]

        guard let url = urlComponents.url else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MoviesList.self, decoder: JSONDecoder())
            .map(\.results)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] movies in
                self?.movies = movies
            })
            .store(in: &cancellables)
    }
    
    
    func fetchMovieDetail(movieID: Int) {
        // Define the URL for the API request
        let apiKey = "3df5973bb3bd6389fe5617a80a85c129"
        let baseURL = "https://api.themoviedb.org/3/movie/\(movieID)"
        
        guard var urlComponents = URLComponents(string: baseURL) else {
            print("Invalid URL")
            return
        }
        
        urlComponents.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        guard let url = urlComponents.url else {
            print("Invalid URL")
            return
        }
        
        // Create a URLSession data task to make the GET request
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let movieDetail = try decoder.decode(Movie.self, from: data)
                    DispatchQueue.main.async { [weak self] in
                        self?.movieDetail = movieDetail
                        print("movieDetail: \(movieDetail)")
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                print("No data received")
            }
        }
        
        task.resume()
    }
}

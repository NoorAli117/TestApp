//
//  ContentView.swift
//  TestApp
//
//  Created by Noor on 06/11/2023.
//

import URLImage
import SwiftUI

struct ContentView: View {
    
    @ObservedObject var movieViewModel = MovieViewModel()
    @State var viewedMovieInfo: Movies?
    
    // State variable to hold the search query
        @State private var searchText = ""
        
        var filteredMovies: [Movies] {
            if searchText.isEmpty {
                return movieViewModel.movies
            } else {
                return movieViewModel.movies.filter { movie in
                    return movie.title?.range(of: searchText, options: .caseInsensitive) != nil
                }
            }
        }
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                if isInternetAvailable() {
                    SearchBar(text: $searchText)
                    
                    // Movie List
                    List(filteredMovies, id: \.title) { movie in
                        NavigationLink(destination: MovieCard(movie: movie)) {
                            HStack {
                                URLImage(URL(string: movie.posterPath!)!) { proxy in
                                    proxy.image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50) // Adjust the size as needed
                                }
                                Text(movie.title!)
                            }
                            .onTapGesture {
                                // Store the last viewed information when it's available
                                UserDefaults.standard.set(movie.title, forKey: "lastViewedInfo")
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }else {
                    if let lastViewedInfo = UserDefaults.standard.string(forKey: "lastViewedInfo") {
                        Text("Last Viewed Movie")
                        Text("\(lastViewedInfo)")
                    } else {
                        Text("No internet connection, and no last viewed information available.")
                    }
                }
            }
            .navigationTitle("Movie List")
        }
    }
}

extension View {
    func add(searchBar text: Binding<String>) -> some View {
        overlay(SearchBar(text: text).frame(width: 250, height: 30).padding(), alignment: .top)
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MovieCard: View {
    @ObservedObject var movieViewModel = MovieViewModel()
    var movie: Movies
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 10) {
                // Movie Poster Image
    //            URLImage(URL(string: (movieViewModel.movieDetail?.posterPath)!)!) { proxy in
    //                proxy.image
    //                    .resizable()
    //                    .aspectRatio(contentMode: .fit)
    //                    .frame(width: 120, height: 180) // Adjust the size as needed
    //                    .cornerRadius(10) // Round the corners for a card-like appearance
    //            }
                
                // Movie Title
                VStack(alignment: .leading, spacing: 10){
                    Text("Title: \(movieViewModel.movieDetail?.title ?? "N/A")")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    // Original Title
                    Text("Original Title: \(movieViewModel.movieDetail?.originalTitle ?? "N/A")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Overview
                    Text("Overview: \(movieViewModel.movieDetail?.overview ?? "N/A")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Original Language
                    Text("Original Language: \(movieViewModel.movieDetail?.originalLanguage ?? "N/A")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Spoken Languages
                    if let spokenLanguages = movieViewModel.movieDetail?.spokenLanguages {
                        ForEach(spokenLanguages, id: \.iso639_1) { language in
                            Text("Spoken Language: \(language.name ?? "N/A")")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    } else {
                        Text("Spoken Languages: N/A")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    // Adult
                    Text("Adult: \(movieViewModel.movieDetail?.adult ?? false ? "YES" : "NO")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                VStack(alignment: .leading, spacing: 10){
                    // Release Date
                    Text("Release Date: \(movieViewModel.movieDetail?.releaseDate ?? "N/A")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Vote Count
                    Text("Vote Count: \(movieViewModel.movieDetail?.voteCount ?? 0)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Vote Average
                    Text("Vote Average: \(movieViewModel.movieDetail?.voteAverage ?? 0)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Genres
                    if let genres = movieViewModel.movieDetail?.genres {
                        let genreNames = genres.map { $0.name ?? "N/A" }.joined(separator: ", ")
                        Text("Genres: \(genreNames)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    } else {
                        Text("Genres: N/A")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    // Belongs to Collection
                    Text("Belongs to Collection: \(movieViewModel.movieDetail?.belongsToCollection ?? "N/A")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    
                }
                
                VStack(alignment: .leading, spacing: 10){
                    // Homepage
                    Text("Homepage: \(movieViewModel.movieDetail?.homepage ?? "N/A")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // IMDb ID
                    Text("IMDb ID: \(movieViewModel.movieDetail?.imdbID ?? "N/A")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Runtime
                    Text("Runtime: \(movieViewModel.movieDetail?.runtime ?? 0) minutes")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Status
                    Text("Status: \(movieViewModel.movieDetail?.status ?? "N/A")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Tagline
                    Text("Tagline: \(movieViewModel.movieDetail?.tagline ?? "N/A")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Video
                    Text("Video: \(movieViewModel.movieDetail?.video ?? false ? "YES" : "NO")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                VStack(alignment: .leading, spacing: 10){
                    
                    // Budget
                    Text("Budget: \(movieViewModel.movieDetail?.budget ?? 0)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Revenue
                    Text("Revenue: \(movieViewModel.movieDetail?.revenue ?? 0)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Popularity
                    Text("Popularity: \(String(format: "%.2f", movieViewModel.movieDetail?.popularity ?? 0.0))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Production Companies
                    if let productionCompanies = movieViewModel.movieDetail?.productionCompanies {
                        let companyNames = productionCompanies.map { $0.name ?? "N/A" }.joined(separator: ", ")
                        Text("Production Companies: \(companyNames)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    } else {
                        Text("Production Companies: N/A")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    // Production Countries
                    if let productionCountries = movieViewModel.movieDetail?.productionCountries {
                        let countryNames = productionCountries.map { $0.name ?? "N/A" }.joined(separator: ", ")
                        Text("Production Countries: \(countryNames)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    } else {
                        Text("Production Countries: N/A")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(10)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .padding(10)
            .onAppear{
                movieViewModel.fetchMovieDetail(movieID: movie.id!)
            }
        }
    }
}

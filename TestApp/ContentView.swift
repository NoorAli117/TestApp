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
    var body: some View {
        NavigationView {
            List(movieViewModel.movies, id: \.title) { movie in
                NavigationLink(destination: MovieCard(movie: movie)) {
                    HStack {
                        URLImage(URL(string: movie.image)!) { proxy in
                            proxy.image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50) // Adjust the size as needed
                        }
                        Text(movie.title)
                    }
                }
            }
            .navigationTitle("Movie List")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MovieCard: View{
    var movie: Movie
    
    var body: some View {
        VStack {
            URLImage(URL(string: movie.image)!) { proxy in
                proxy.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120) // Adjust the size as needed
            }
            Text("Title: \(movie.title)")
            Text("Director: \(movie.director)")
            Text("Year: \(movie.year)")
        }
        .navigationTitle("Movie Details")
    }
}

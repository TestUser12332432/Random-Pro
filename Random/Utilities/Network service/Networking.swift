//
//  Networking.swift
//  Random Pro
//
//  Created by Vitalii Sosin on 28.02.2021.
//  Copyright © 2021 Sosin.bet. All rights reserved.
//

import SwiftUI

class Networking {
    private let urlStringVideocdn: String = "https://videocdn.tv/api/"
    private let tokenVideocdn: String = "?api_token=VGstdXXDwaGDIM4Ec8ofDLcZnAaTsU0X"
    
    private let urlStringKinopoisk: String = "https://kinopoiskapiunofficial.tech/api/v2.1/films/"
    private let tokenKinopoisk: String = "f835989c-b489-4624-9209-6d93bfead535"
    
    private let urlStringKinopoiskBestFilms: String = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS"
    private let urlStringKinopoiskPopularFilms: String = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS"

    static let share = Networking()
    
    private init() {}
    
    func getMovies(year: Int, limit: Int, completion: @escaping (Films) -> Void) {
        
        var request = URLRequest(url: URL(string: urlStringVideocdn + "movies" + tokenVideocdn + "&year=\(year)&limit=\(limit)")!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let films = try JSONDecoder().decode(Films.self, from: data)
                DispatchQueue.main.async {
                    completion(films)
                }
            } catch {
                print("error: ", error)
            }
        }.resume()
    }
    
    func getInfoKinopoisk(films: [Datum], state: Binding<AppState.AppData>) {
        for film in films {
            guard let kinopoiskID = film.kinopoiskID else { return }
            guard let url = URL(string: "\(urlStringKinopoisk)\(String(describing: kinopoiskID))") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("\(tokenKinopoisk)", forHTTPHeaderField: "X-API-KEY")
            let session = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: request as URLRequest) { (data, response, error) in
                do {
                    let filmsInfo = try JSONDecoder().decode(FilmsInfo.self, from: data!)
                    DispatchQueue.main.async {
                        state.film.filmsTemp.wrappedValue.append(filmsInfo)
                    }
                } catch {
                    print("Decoding error:", error)
                }
            }.resume()
        }
    }
    
    func getInfoKinopoiskBestFilms(page: Int, completion: @escaping (WelcomeBestFilm) -> Void) {
        
        guard let url = URL(string: "\(urlStringKinopoiskBestFilms)" + "&page=\(page)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("\(tokenKinopoisk)", forHTTPHeaderField: "X-API-KEY")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request as URLRequest) { (data, response, error) in
            do {
                let bestFilms = try JSONDecoder().decode(WelcomeBestFilm.self, from: data!)
                DispatchQueue.main.async {
                    completion(bestFilms)
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
    
    func getInfoKinopoiskPopularFilms(page: Int, completion: @escaping (WelcomeBestFilm) -> Void) {
        
        guard let url = URL(string: "\(urlStringKinopoiskPopularFilms)" + "&page=\(page)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("\(tokenKinopoisk)", forHTTPHeaderField: "X-API-KEY")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request as URLRequest) { (data, response, error) in
            do {
                let bestFilms = try JSONDecoder().decode(WelcomeBestFilm.self, from: data!)
                DispatchQueue.main.async {
                    completion(bestFilms)
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
}
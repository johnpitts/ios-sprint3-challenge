//
//  PokemonController.swift
//  ios-sprint3-challenge
//
//  Created by John Pitts on 5/24/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import Foundation

class PokemonController {
    
    func searchForPokemon(with searchTerm: String, completion: @escaping () -> Void) {
        
        let searchURL = baseURL.appendingPathComponent(searchTerm)
        
        let urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        
        guard let formattedURL = urlComponents?.url else {
            completion()
            return
        }
        
        var request = URLRequest(url: formattedURL)
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error searching for people: \(error)")
                completion()
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion()
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                
                self.pokemon = pokemon
                
                completion()
                
            } catch let decodingError {
                NSLog("Error decoding Pokemon-character from data: \(decodingError)")
                completion()
            }
        }
        print("resume reached")
        dataTask.resume()
    }
    
    func savePokemonToArray(with pokemon: Pokemon) {
        
        pokemons.append(pokemon)
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    var pokemons: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    var pokemon: Pokemon?   //try commenting this out bc you already create pokemon above in line 44
}

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
        
        let searchURL = baseURL.appendingPathComponent(searchTerm) // trying this, I didn't append last time bc I thought the searchQueryItem took care of it
        
        let urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        
        // line below is redundant
        //let searchQueryItem = URLQueryItem(name: "pokemon", value: searchTerm) // was pokemon, try "search"
        
        // redundant
        //urlComponents?.queryItems = [searchQueryItem]
        
        print(urlComponents?.url)
        
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
                
                
                //give me an instance of Pokemon.self type from data, try =if data is there
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                
                self.pokemon = pokemon
                // either DispatchQueue.main now to put into table view or do that in the tableview where this is called
                // i think ity's safe inside the completion thread, so it will come out later ok?
                
                completion()
                
            } catch let decodingError {
                NSLog("Error decoding Pokemon-character from data: \(decodingError)")
                completion()
            }
        }
        print("resume reached")
        //        let dataString = String(data: data, encoding: .utf8)  well this thing didn't work
        //        print(dataString)
        
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
    
    var pokemon: Pokemon?
}

//
//  Pokemon.swift
//  ios-sprint3-challenge
//
//  Created by John Pitts on 5/24/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

struct Pokemon: Codable {
    let abilities: [AbilityNonsense]
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [TypeNonsense]
    
    struct AbilityNonsense: Codable {
        let ability: Ability
    }
    
        struct Ability: Codable {
            let name: String   // i guess i can only use "name" once in CodingKey
            //let url: String  here as an example, we don't need it for this project
        
            //            enum AbilityCodingKeys: String, CodingKey {
            //                case  abilityName = "name"
        }
    
    struct Sprites: Codable {
        let front_default: String
        
        //        enum SpritesCodingKeys: String, CodingKey {
        //
        //            case  frontDefault = "front_default"
        //        }
    }
    
    struct TypeNonsense: Codable {
        let type: TypeP
    }
    
        struct TypeP: Codable {
            let name: String
        
            enum TypePCodingKeys: String, CodingKey {
                case  typeName = "name"
            }
        }
} // Pokemon model ends

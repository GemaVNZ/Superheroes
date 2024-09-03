//
//  Superhero.swift
//  Superheroes
//
//  Created by Mañanas on 2/9/24.
//

import Foundation
import UIKit

struct SuperheroResponse: Codable {
    let response: String
    let results: [Superhero]
    let error: String?
}

struct Superhero: Codable {
    let id: String
    let name: String
    let powerstats: Stats
    let biography:Biography
    let work: Work
    var image: Image
}

struct Image: Codable {
    let url: String
}

struct Work: Codable  {
    
    let occupation : String?
    let base : String?
}

struct Biography: Codable {
    let publisher: String
}

struct Stats: Codable {
    let intelligence: String?
    let strength: String?
    let speed: String?
    let durability: String?
    let power: String?
    let combat: String?
}


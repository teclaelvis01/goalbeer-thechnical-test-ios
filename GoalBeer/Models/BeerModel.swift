//
//  BeerModel.swift
//  GoalBeer
//
//  Created by Elvis Reyes on 14/5/22.
//

import Foundation

struct ResponseBeerModel: Codable{
    var data : [BeerModel]
    
    enum CodingKeys: String, CodingKey{
        case data
    }
    
}

struct BeerModel: Codable, Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let firstBrewed: String
    let imageUrl: String?
    let brewersTips: String
    let contributedBy: String
    let tagline: String
    let foodPairing: [String]
    
    var  url: URL {
        URL(string: imageUrl ?? "https://images.punkapi.com/v2/192.png")!
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case firstBrewed = "first_brewed"
        case imageUrl = "image_url"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
        case tagline
        case foodPairing = "food_pairing"
    }
    
    init() {
        self.name = "Bramling X"
        self.description = "Good old Bramling Cross is elegant, refined, assured, (boring) and understated. Understated that is unless you hop the living daylights out of a beer with it. This is Bramling Cross re-invented and re-imagined, and shows just what can be done with English hops if you use enough of them. Poor Bramling Cross normally gets lost in a woeful stream of conformist brown ales made by sleepy cask ale brewers. But not anymore. This beer shows that British hops do have some soul, and is a fruity riot of blackberries, pears, and plums. Reminds me of the bramble, apple and ginger jam my grandmother used to make."
        self.firstBrewed = "01/2011"
        self.brewersTips = "brewersTips"
        self.imageUrl = "https://images.punkapi.com/v2/keg.png"
        self.contributedBy = "Sam Mason <samjbmason>"
        self.tagline = "tagline"
        self.foodPairing = [
            "Warm blackberry pie",
            "Vinegar doused fish and chips",
            "Aromatic korma curry with lemon and garlic naan"
        ]
        
    }
    
    
}


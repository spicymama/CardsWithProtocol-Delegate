//
//  Card.swift
//  CardGame
//
//  Created by Gavin Woffinden on 4/22/21.
//

import UIKit

class Card {
    let name: String
    let photo: UIImage?
    let uuid: String
    let faction: String
    
    init(name: String, photo: UIImage?, uuid: String = UUID().uuidString, faction: String){
        
        self.name = name
        self.photo = photo
        self.uuid = uuid
        self.faction = faction
        
    }
    
    
}
extension Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool{
    return lhs.uuid == rhs.uuid
    }
}

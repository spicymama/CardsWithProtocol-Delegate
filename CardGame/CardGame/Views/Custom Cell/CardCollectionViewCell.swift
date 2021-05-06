//
//  CardCollectionViewCell.swift
//  CardGame
//
//  Created by Gavin Woffinden on 4/22/21.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var cardImageView: UIImageView!
    
    //MARK: - Properties
    var card: Card? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let card = card else {return}
        cardImageView.contentMode = .scaleAspectFit
        cardImageView.image = card.photo
    }
}

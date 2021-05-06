//
//  CardCollectionViewController.swift
//  CardGame
//
//  Created by Gavin Woffinden on 4/22/21.
//

import UIKit

class CardCollectionViewController: UICollectionViewController {
    //MARK: - Properties
    var displayedCards: [Card] = []
    var targetedCard: Card?
    var selectedFaction = "hearts"

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleCards(faction: selectedFaction)
    }
    
    //MARK: - Helper Methods
    func shuffleCards(faction: String) {
        if faction == "hearts" {
            let shuffleHeartsGroup = CardController.hearts.shuffled()
            let heartsGroup = shuffleHeartsGroup.prefix(3)
            displayedCards = Array(heartsGroup)
            targetedCard = CardController.clubs.randomElement()
        } else {
            let shuffleClubsGroup = CardController.clubs.shuffled()
            let clubsGroup = shuffleClubsGroup.prefix(3)
            displayedCards = Array(clubsGroup)
            targetedCard = CardController.hearts.randomElement()
        }
        updateViews()
    }
    
    func updateViews() {
        guard let card = targetedCard else { return }
        displayedCards.append(card)
        displayedCards.shuffle()
        self.title = "Find \(card.name)"
        collectionView.reloadData()
    }
    func presentAlert(card: Card) {
        let success = card == targetedCard
        
        let alertController = UIAlertController(title: success ? "You Nailed It!" : "This is Not That Hard", message: nil, preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Done", style: .cancel)
        let shuffleAction = UIAlertAction(title: "Shuffle", style: .default) { (_) in
            self.shuffleCards(faction: self.selectedFaction)
        }
        
        alertController.addAction(doneAction)
        
        if success {
            alertController.addAction(shuffleAction)
        }
        
        present(alertController, animated: true)
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFilterVC" {
            guard let destination = segue.destination as? FilterViewController else { return }
            
            destination.delegate = self
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedCards.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell()}
        
        let card = displayedCards[indexPath.row]
        cell.card = card
    
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //present alert
        let card = displayedCards[indexPath.row]
        presentAlert(card: card)
    }
}

extension CardCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2
        return CGSize(width: width - 20, height: width + 30)
    }
}

extension CardCollectionViewController: FilterSelectionDelegate {
    func factionWasSelected(faction: String) {
        selectedFaction = faction
        shuffleCards(faction: faction)
    }
}

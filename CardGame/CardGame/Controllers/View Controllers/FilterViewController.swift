//
//  FilterViewController.swift
//  CardGame
//
//  Created by Gavin Woffinden on 4/22/21.
//

import UIKit

protocol FilterSelectionDelegate: AnyObject {
    func factionWasSelected(faction: String)
    
}

class FilterViewController: UIViewController {

    weak var delegate: FilterSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func heartButtonTapped(_ sender: Any) {
        delegate?.factionWasSelected(faction: "hearts")
        self.dismiss(animated: true)
        
    }

    @IBAction func clubButtonTapped(_ sender: Any) {
        delegate?.factionWasSelected(faction: "clubs")
        self.dismiss(animated: true)
    }
}

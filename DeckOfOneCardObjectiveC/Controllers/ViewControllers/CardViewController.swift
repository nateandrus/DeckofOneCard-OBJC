//
//  CardViewController.swift
//  DeckOfOneCardObjectiveC
//
//  Created by Nathan Andrus on 2/12/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    var card: DVMCard? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateViews() {
        guard let card = card else { return }
            self.nameLabel.text = card.suit
    }
    
    
    @IBAction func newCardButtonTapped(_ sender: UIButton) {
        DVMCardController.drawANewCard(1) { (card, error) in
            if let error = error {
                print("This sucks")
            }
            self.card = card?.first
            if let card = card {
                DVMCardController.fetchCardImage(card.first) { (image, error) in
                    if let error = error {
                        print("This sucks")
                    }
                    DispatchQueue.main.async {
                        self.cardImageView.image = image
                    }
                }
            }
        }
    }
}

//
//  PopUpVC.swift
//  FactCheck
//
//  Created by Oisín Byrne on 21/04/2017.
//  Copyright © 2017 Computer Science. All rights reserved.
//

import UIKit

class PopUpVC: UIViewController {
    var passedScore = 0
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showPopUp()
        scoreLabel.text = "Your score is \(passedScore)%"
    }
    
    func showPopUp() {
        self.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
}

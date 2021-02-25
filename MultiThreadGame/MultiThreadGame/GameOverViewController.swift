//
//  GameOverViewController.swift
//  MultiThreadGame
//
//  Created by meng on 2021/02/25.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var totalScore: UILabel!
    
    var scoreValue: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.totalScore.text = String(self.scoreValue)
    }
    
    @IBAction func againButtonClicked(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func exitButtonClicked(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
}

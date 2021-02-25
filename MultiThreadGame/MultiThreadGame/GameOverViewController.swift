//
//  GameOverViewController.swift
//  MultiThreadGame
//
//  Created by meng on 2021/02/25.
//

import UIKit

class GameOverViewController: UIViewController {


    @IBOutlet weak var totalScore: UILabel!
    @IBOutlet weak var bestScore: UILabel!
    
    var bestScoreValue: Int!
    var scoreValue: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.totalScore.text = String(self.scoreValue)
        self.bestScoreValue = UserDefaults.standard.integer(forKey: "bestScore")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateScore()
    }
    
    @IBAction func againButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func exitButtonClicked(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    func updateScore(){
        if self.bestScoreValue > self.scoreValue {
            self.bestScore.text = String(self.bestScoreValue)
        }
        else{
            UserDefaults.standard.set(scoreValue, forKey: "bestScore")
            self.bestScore.text = String(self.scoreValue)
        }
    }
    
}

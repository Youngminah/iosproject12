//
//  IntroViewController.swift
//  MultiThreadGame
//
//  Created by meng on 2021/02/25.
//

import UIKit

class IntroViewController: UIViewController {
    
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var explainButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 15
        startButton.layer.borderWidth = 6
        startButton.layer.borderColor = CGColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1)
        
        explainButton.layer.borderWidth = 6
        explainButton.layer.cornerRadius = 15
        explainButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func explainButtonClicked(_ sender: UIButton) {
        
    }
    
}

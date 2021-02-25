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
    
    @IBOutlet weak var startBoolImage: UIImageView!
    @IBOutlet weak var ExplainBoolImage: UIImageView!
    
    var startBool : Bool!
    var explainBool : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startBool = true
        startBoolImage.isHighlighted = true
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        explainBool = false
        if startBool == true {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayScene") as? PlayViewController else{
                return
            }
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        else {
            startBool = true
            startBoolImage.isHighlighted = true
            ExplainBoolImage.isHighlighted = false
        }
    }
    
    @IBAction func explainButtonClicked(_ sender: UIButton) {
        startBool = false
        if explainBool == true {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExplainScene") as? ExplainViewController else{
                return
            }
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        else {
            explainBool = true
            ExplainBoolImage.isHighlighted = true
            startBoolImage.isHighlighted = false
        }
    }
    
}

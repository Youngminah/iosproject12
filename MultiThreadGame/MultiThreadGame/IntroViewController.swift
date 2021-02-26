//
//  IntroViewController.swift
//  MultiThreadGame
//
//  Created by meng on 2021/02/25.
//

import UIKit
import AVFoundation

class IntroViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var explainButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var startBoolImage: UIImageView!
    @IBOutlet weak var ExplainBoolImage: UIImageView!
    
    var startBool : Bool!
    var explainBool : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "underthesea", ofType: "mp3") ?? ""))
            audioPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        audioPlayer.currentTime = 0
        audioPlayer.play()
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
            startBool = false
            startBoolImage.isHighlighted = false
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
            explainBool = false
            ExplainBoolImage.isHighlighted = false
        }
        else {
            explainBool = true
            ExplainBoolImage.isHighlighted = true
            startBoolImage.isHighlighted = false
        }
    }
    
}

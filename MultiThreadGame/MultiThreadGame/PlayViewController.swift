//
//  PlayViewController.swift
//  MultiThreadGame
//
//  Created by meng on 2021/02/25.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var heartLabel: UILabel!
    
    var preys: [UIImageView] = []
    var predators: [UIImageView] = []
    
    var dragging: Bool = false
    var positionX: CGFloat!
    var positionY: CGFloat!
    
    var preyTimer: Timer!
    var octopusTimer: Timer!
    var checkPreyTimer: Timer!
    var checkPredatorTimer: Timer!
    var player: UIImageView!
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    
    var heartToLive: Int = 5{
        didSet {
            heartLabel.text = "\(heartToLive)"
        }
    }
    
//    var player: UIImageView = {
//        let player = UIImageView(image: UIImage(named: "player"))
//        player.frame = CGRect(x: 200, y: 400, width: 60, height: 40)
//        return player
//    }()
//
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "underthesea", ofType: "mp3") ?? ""))
            audioPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }
        player = UIImageView(image: UIImage(named: "player"))
        player.frame = CGRect(x: 200, y: 400, width: 60, height: 40)
        self.view.addSubview(player)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        player.frame = CGRect(x: 200, y: 400, width: 60, height: 40)
        print("viewwill")
        heartToLive = 5
        score = 0
        positionX = self.player.frame.origin.x + 19
        positionY = self.player.frame.origin.y - 10
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        audioPlayer.stop()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 먹이 생성.
        if !audioPlayer.isPlaying{
            audioPlayer.currentTime = 0
            audioPlayer.play()
        }
        DispatchQueue.global(qos: .background).async {
            self.preyTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                DispatchQueue.main.sync {
                    self.createPrey()
                }
            }
            RunLoop.current.run()
        }
        // 먹이 생성.
        DispatchQueue.global(qos: .background).async {
            self.octopusTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                DispatchQueue.main.sync {
                    self.createOctopus()
                }
            }
            RunLoop.current.run()
        }
        // 먹이와 플레이어 충돌 타이머
        DispatchQueue.global().async {
            self.checkPreyTimer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { _ in
                DispatchQueue.main.sync {
                    self.checkPreyCollision()
                }
            }
            RunLoop.current.run()
        }
        // 먹이와 플레이어 충돌 타이머
        DispatchQueue.global().async {
            self.checkPredatorTimer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { _ in
                DispatchQueue.main.sync {
                    self.checkPredatorCollision()
                }
            }
            RunLoop.current.run()
        }
    }
    
    // 먹이 생성 함수
    func createPrey() {
        let prey = UIImageView(image: UIImage(named: "prey"))
        prey.contentMode = .scaleAspectFill
        preys.append(prey)
        let minValue = self.view.frame.size.width / 8
        let maxValue = self.view.frame.size.width - 20
        let createPoint = UInt32(maxValue - minValue)
        
        prey.frame = CGRect(x: CGFloat(arc4random_uniform(createPoint)), y: -50, width: 15, height: 15)
        // 애니메이션
        UIView.animate(withDuration: 5.0, delay: 0.0, options: .allowUserInteraction, animations: {
            prey.frame = CGRect(x: prey.frame.origin.x, y: 1000, width: 15, height: 15)
        }, completion: { _ in
            if self.preys.contains(prey) {
                let index = self.preys.firstIndex(of: prey)
                self.preys.remove(at: index!)
                prey.removeFromSuperview()
            }
        })
        self.view.addSubview(prey)
    }
    
    // 먹이 생성 함수
    func createOctopus() {
        let octopus = UIImageView(image: UIImage(named: "octopus"))
        octopus.contentMode = .scaleAspectFill
        predators.append(octopus)
        let minValue = self.view.frame.size.height / 100
        let maxValue = self.view.frame.size.height - 20
        let createPoint = UInt32(maxValue - minValue)
        octopus.frame = CGRect(x: -50, y: CGFloat(arc4random_uniform(createPoint)), width: 80, height: 80)
        // 애니메이션
        UIView.animate(withDuration: 7.0, delay: 0.0, options: .allowUserInteraction, animations: {
            octopus.frame = CGRect(x: 500, y: octopus.frame.origin.y, width: 80, height: 80)
        }, completion: { _ in
            if self.predators.contains(octopus) {
                let index = self.predators.firstIndex(of: octopus)
                self.predators.remove(at: index!)
                octopus.removeFromSuperview()
            }
        })
        self.view.addSubview(octopus)
    }
    
    // 먹이 & 플레이어 충돌 함수
    func checkPreyCollision() {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                if self.preys.count > 0 {
                    for prey in self.preys {
                        if let preyVal = prey.layer.presentation()?.frame {
                            if preyVal.intersects(self.player.frame) {
                                let index = self.preys.firstIndex(of: prey)
                                self.preys.remove(at: index!)
                                prey.removeFromSuperview()
                                self.score += 10
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    // 문어 & 플레이어 충돌 함수
    func checkPredatorCollision() {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                if self.predators.count > 0 {
                    for predator in self.predators {
                        if let preyVal = predator.layer.presentation()?.frame {
                            if preyVal.intersects(self.player.frame) {
                                let index = self.predators.firstIndex(of: predator)
                                self.predators.remove(at: index!)
                                predator.removeFromSuperview()
                                self.heartToLive -= 1
                                if self.heartToLive == 0{
                                    self.presentGameOver()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func presentGameOver(){
        if let gameOverVC = self.storyboard?.instantiateViewController(identifier: "GameoverScene") as? GameOverViewController{
            self.pause()
            gameOverVC.scoreValue = self.score
            gameOverVC.modalTransitionStyle = .coverVertical
            gameOverVC.modalPresentationStyle = .fullScreen
            self.present(gameOverVC, animated: true, completion: nil)
            self.score = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let touchPoint = touch.location(in: self.view)
        if player.frame.contains(touchPoint){
            dragging = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let touchPoint = touch.location(in: self.view)
        if (self.dragging) {
            DispatchQueue.global().async { [unowned self] in
                DispatchQueue.main.async {
                    self.player.center = CGPoint(x: (touchPoint.x), y: (touchPoint.y))
                    self.positionX = self.player.frame.origin.x + 19
                    self.positionY = self.player.frame.origin.y - 10
                }
            }
        }
    }
    
    func pause() {
        preyTimer.invalidate()
        octopusTimer.invalidate()
        checkPreyTimer.invalidate()
        checkPredatorTimer.invalidate()
    }
}

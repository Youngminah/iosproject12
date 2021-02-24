//
//  GameViewController.swift
//  Mutithread
//
//  Created by meng on 2021/02/24.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
      super.viewDidLoad()
      
      if let view = self.view as? SKView {
        let scene = GameScene(size: UIScreen.main.bounds.size)
        scene.scaleMode = .aspectFill
        
        view.presentScene(scene)
      }
    }
    
    override var shouldAutorotate: Bool {
      return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      return .portrait
    }
    
    override var prefersStatusBarHidden: Bool {
      return true
    }
}

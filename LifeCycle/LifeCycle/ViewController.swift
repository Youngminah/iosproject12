//
//  ViewController.swift
//  LifeCycle
//
//  Created by meng on 2021/02/01.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var trackImage1: UIImageView!
    @IBOutlet weak var trackImage2: UIImageView!
    @IBOutlet weak var trackImage3: UIImageView!
    
    @IBOutlet weak var trackname1: UILabel!
    @IBOutlet weak var trackname2: UILabel!
    @IBOutlet weak var trackname3: UILabel!
    
    var tracks:[AVPlayerItem] = []
    
    @IBAction func Track1Clicked(_ sender: Any) {
        guard let receiveViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else{
            return
        }
        
        receiveViewController.imagename = "슬라임1"
        receiveViewController.trackname = trackname1.text
        
        let item = tracks[2]
        receiveViewController.simplePlayer.replaceCurrentItem(with: item)
        
        //self.present(receiveViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(receiveViewController, animated: true)
    }
    
    @IBAction func Track2Clicked(_ sender: UIButton) {
        guard let receiveViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else{
            return
        }
        
        receiveViewController.imagename = "슬라임2"
        receiveViewController.trackname = trackname2.text
        
        let item = tracks[5]
        receiveViewController.simplePlayer.replaceCurrentItem(with: item)
        
        //self.present(receiveViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(receiveViewController, animated: true)
    }
    
    func loadTracks() -> [AVPlayerItem] {
        //파일들 읽어서 AVPlayerItem만들기
        //local에 있는 mp3를 모두 가져와라 그걸로 urls로 가져옴
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
        //url을 가지고 AVPlayerItem을 만들었고 리턴시킴
        let items = urls.map { url in return AVPlayerItem(url: url) }
        return items
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tracks = loadTracks()
        print("화면1: viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("\n화면1: viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("화면1: viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("화면1: viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("화면1: viewDidDisappear")
    }
}


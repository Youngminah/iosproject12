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
    
    @IBOutlet weak var trackartist1: UILabel!
    @IBOutlet weak var trackartist2: UILabel!
    @IBOutlet weak var trackartist3: UILabel!
    
    
    var tracks:[AVPlayerItem] = []
    var randomTrack: [AVPlayerItem] = []
    
    @IBAction func Track1Clicked(_ sender: Any) {
        guard let receiveViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else{
            return
        }
        
        receiveViewController.image = trackImage1.image
        receiveViewController.trackname = trackname1.text
        receiveViewController.artist = trackartist1.text
        
        let item = randomTrack[0]
        receiveViewController.simplePlayer.replaceCurrentItem(with: item)
        
        //self.present(receiveViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(receiveViewController, animated: true)
    }
    
    @IBAction func Track2Clicked(_ sender: UIButton) {
        guard let receiveViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else{
            return
        }
        
        receiveViewController.image = trackImage2.image
        receiveViewController.trackname = trackname2.text
        receiveViewController.artist = trackartist2.text
        
        let item = randomTrack[1]
        receiveViewController.simplePlayer.replaceCurrentItem(with: item)
        
        //self.present(receiveViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(receiveViewController, animated: true)
    }
    
    @IBAction func Track3Clicked(_ sender: UIButton) {
        guard let receiveViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else{
            return
        }
        
        receiveViewController.image = trackImage3.image
        receiveViewController.trackname = trackname3.text
        receiveViewController.artist = trackartist3.text
        
        let item = randomTrack[2]
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
        let len = UInt32(tracks.count)
        while randomTrack.count < 3 {
            let randomNo: Int = Int(arc4random_uniform(len));
            if !randomTrack.contains(tracks[randomNo]){
                randomTrack.append(tracks[randomNo])
            }
        }
        updateTrackInfo()
        print(len)
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
        randomTrack = []
    }
    
    
    func updateTrackInfo() {
        // TODO: 트랙 정보 업데이트
        //print(randomTrack[0].asset.metadata)
        trackImage1.image = randomTrack[0].asset.metadata[10].artwork
        trackname1.text = randomTrack[0].asset.metadata[0].title
        trackartist1.text = randomTrack[0].asset.metadata[1].artist
        
        trackImage2.image = randomTrack[1].asset.metadata[10].artwork
        trackname2.text = randomTrack[1].asset.metadata[0].title
        trackartist2.text = randomTrack[1].asset.metadata[1].artist
        
        trackImage3.image = randomTrack[2].asset.metadata[10].artwork
        trackname3.text = randomTrack[2].asset.metadata[0].title
        trackartist3.text = randomTrack[2].asset.metadata[1].artist
        
    }
    
}


extension AVMetadataItem {
    var title: String? {
        guard let key = commonKey?.rawValue, key == "title" else {
            return nil
        }
        return stringValue
    }
    
    var artist: String? {
        guard let key = commonKey?.rawValue, key == "artist" else {
            return nil
        }
        return stringValue
    }
    
    var albumName: String? {
        guard let key = commonKey?.rawValue, key == "albumName" else {
            return nil
        }
        return stringValue
    }
    
    var artwork: UIImage? {
        guard let key = commonKey?.rawValue, key == "artwork", let data = dataValue, let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
}

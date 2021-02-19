//
//  DetailViewController.swift
//  TableView
//
//  Created by meng on 2021/02/19.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var personimg: UIImageView!
    @IBOutlet weak var personname: UILabel!
    @IBOutlet weak var personnumber: UILabel!
    
    var name: String?
    var number: String?
    var img: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI(){
        if let name = self.name, let number = self.number, let img = self.img{
            personname.text = name
            personnumber.text = number
            personimg.image = img
        }
    }
    
    @IBAction func callClicked(_ sender: UIButton) {
        //let urlString = "TEL://010-1111-2222"
        //let url:NSURL = URL(string: urlString)! as NSURL
        //UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
}

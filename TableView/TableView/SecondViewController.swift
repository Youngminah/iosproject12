//
//  SecondViewController.swift
//  TableView
//
//  Created by meng on 2021/02/19.
//

import UIKit
import CallKit

class SecondViewController: UIViewController {

    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personName: UITextField!
    @IBOutlet weak var personPhoneNum: UITextField!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var unspecButton: UIButton!
    
    var getImageName: String = "female.png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        femaleButton.isSelected = true
        maleButton.isSelected = false
        unspecButton.isSelected = false
        print("viewDidLoad()")
    }
    
    @IBAction func radioGenderClicked(_ sender: UIButton) {
        if sender.tag == 1{
            femaleButton.isSelected = true
            maleButton.isSelected = false
            unspecButton.isSelected = false
            getImageName = "female.png"
            personImage.image = UIImage(named: getImageName)
        }
        else if sender.tag == 2{
            femaleButton.isSelected = false
            maleButton.isSelected = true
            unspecButton.isSelected = false
            getImageName = "male.png"
            personImage.image = UIImage(named: getImageName)
        }
        else if sender.tag == 3{
            femaleButton.isSelected = false
            maleButton.isSelected = false
            unspecButton.isSelected = true
            getImageName = "unspecified.png"
            personImage.image = UIImage(named: getImageName)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
   }
    
    @IBAction func saveClicked(_ sender: Any) {
        //let urlString = "TEL://010-1111-2222"
        //let url:NSURL = URL(string: urlString)! as NSURL
        //UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        
//        guard let receiveViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else{
//            return
//        }
//        guard let name = personName.text else{
//            return
//        }
//        guard let number = personPhoneNum.text else{
//            return
//        }
//        receiveViewController.dataName[1].append(name)
//        receiveViewController.dataNumber[1].append(number)
//        receiveViewController.dataImage[1].append(getImageName)
//        print(receiveViewController.dataName[1])
        
        
        guard let name = personName.text, name.isEmpty == false else { return }
        guard let number = personPhoneNum.text, name.isEmpty == false else { return }
        let info = InfoManager.shared.createInfo(dataName: name, dataNumber: number, dataImage: getImageName, isStar: false)
        InfoManager.shared.addInfo(info)
//        infoListViewModel.addTodo(todo)
//        collectionView.reloadData()
//        inputTextField.text = ""
//        isTodayButton.isSelected = false
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


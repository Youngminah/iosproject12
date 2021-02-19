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
    
    //이름 입력 갯수 제한.
    @IBAction func nameTextEditChanging(_ sender: UITextField) {
        if (personName.text?.count ?? 0 > 11) {
            personName.deleteBackward()
        }
    }
    
    //번호 입력 갯수 제한.
    @IBAction func textfieldEditing(_ sender: UITextField) {
        if (personPhoneNum.text?.count ?? 0 > 11) {
            personPhoneNum.deleteBackward()
        }
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        guard let name = personName.text, name.isEmpty == false, let number = personPhoneNum.text, number.isEmpty == false else {
            let dialog = UIAlertController(title: "필수", message: "이름 혹은 번호를 입력하세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
            dialog.addAction(action)
            self.present(dialog, animated: true, completion: nil)
            return
        }
        let info = InfoManager.shared.createInfo(dataName: name, dataNumber: number, dataImage: getImageName, isStar: false)
        InfoManager.shared.addInfo(info)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        let dialog = UIAlertController(title: "알림", message: "입력 중인 정보는 저장되지 않습니다.\n입력을 취소하시겠습니까?", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "아니요", style: UIAlertAction.Style.default)
        let action2 = UIAlertAction(title: "예", style: UIAlertAction.Style.default){ (action: UIAlertAction) -> Void in
            self.navigationController?.popViewController(animated: true)
        }
        dialog.addAction(action1)
        dialog.addAction(action2)
        self.present(dialog, animated: true, completion: nil)
    }
}


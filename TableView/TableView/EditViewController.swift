//
//  EditViewController.swift
//  TableView
//
//  Created by meng on 2021/02/20.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var personimg: UIImageView!
    @IBOutlet weak var personname: UITextField!
    @IBOutlet weak var personnumber: UITextField!
    @IBOutlet weak var femalebutton: UIButton!
    @IBOutlet weak var malebutton: UIButton!
    @IBOutlet weak var unspecbutton: UIButton!
    @IBOutlet weak var stackbuttomCons: NSLayoutConstraint!
    
    
    var getNumber: String = ""
    var getName: String = ""
    var getImageName: String = "female.png"
    var info: Info?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //키보드가 올라오기를 감시하기 위한 옵저버
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
        updateUI()
        print("viewDidLoad()")
    }
    
    @IBAction func radioGroupClicked(_ sender: UIButton) {
        if sender.tag == 1{
            femalebutton.isSelected = true
            malebutton.isSelected = false
            unspecbutton.isSelected = false
            getImageName = "female.png"
            personimg.image = UIImage(named: getImageName)
        }
        else if sender.tag == 2{
            femalebutton.isSelected = false
            malebutton.isSelected = true
            unspecbutton.isSelected = false
            getImageName = "male.png"
            personimg.image = UIImage(named: getImageName)
        }
        else if sender.tag == 3{
            femalebutton.isSelected = false
            malebutton.isSelected = false
            unspecbutton.isSelected = true
            getImageName = "unspecified.png"
            personimg.image = UIImage(named: getImageName)
        }
        
    }
    
    func updateUI(){
        personname.text = getName
        personnumber.text = getNumber
        personimg.image =  UIImage(named: getImageName)
        if getImageName == "female.png" {
            femalebutton.isSelected = true
            malebutton.isSelected = false
            unspecbutton.isSelected = false
        }
        else if getImageName == "female.png"{
            femalebutton.isSelected = false
            malebutton.isSelected = true
            unspecbutton.isSelected = false
        }
        else if getImageName == "unspecified.png"{
            femalebutton.isSelected = false
            malebutton.isSelected = false
            unspecbutton.isSelected = true
        }
    }
    
    //전화번호에 "-" 삽입하기.
    func phonenumberCharInsert(){
        guard var num = personnumber.text else {
            return
        }
        if num.count == 11{
            num.insert("-", at: num.index(num.startIndex, offsetBy: 3))
            num.insert("-", at: num.index(num.endIndex, offsetBy: -4))
        }
        else {
            num.insert("-", at: num.index(num.startIndex, offsetBy: 2))
            num.insert("-", at: num.index(num.endIndex, offsetBy: -4))
        }
        self.getNumber = num
    }
    
    //화면 아무곳 클릭하면 키보드 내려가게 하기.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
    }
    
    @IBAction func saveClicked(_ sender: UIButton) {
        guard let name = personname.text, name.isEmpty == false, let number = personnumber.text, number.isEmpty == false else {
            let dialog = UIAlertController(title: "필수", message: "이름 혹은 번호 입력을 확인하세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
            dialog.addAction(action)
            self.present(dialog, animated: true, completion: nil)
            return
        }
        //저장되어있으면 "-"추가하여 Info추가하고 이전 뷰로 되돌아간다.
        phonenumberCharInsert()
        guard var info = self.info else {
            return
        }
        info.dataName = name
        info.dataImage = getImageName
        info.dataNumber = getNumber
        InfoManager.shared.updateInfo(info)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelClicked(_ sender: UIButton) {
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


//키보드가 올라가거나 내려갈때, 입력 필드의 배치 지정해주기.
extension EditViewController {
    @objc private func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        // [x] TODO: 키보드 높이에 따른 인풋뷰 위치 변경
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if noti.name == UIResponder.keyboardWillShowNotification {
            let adjustmentHeight = keyboardFrame.height - view.safeAreaInsets.bottom
            stackbuttomCons.constant = adjustmentHeight
        } else {
            stackbuttomCons.constant = 120
        }
        print("---> Keyboard End Frame: \(keyboardFrame)")
    }
}

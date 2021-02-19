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
    @IBOutlet weak var stackViewBottom: NSLayoutConstraint!
    
    var getImageName: String = "female.png"
    var getNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //키보드가 올라오기를 감시하기 위한 옵저버
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
        print("viewDidLoad()")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //처음 뷰 셋팅.
        femaleButton.isSelected = true
        maleButton.isSelected = false
        unspecButton.isSelected = false
    }
    
    @IBAction func radioGenderClicked(_ sender: UIButton) { //라디오 버튼 선택 했을 때, 이미지 변경
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){ //화면 아무곳 클릭하면 키보드 내려가게 하기.
         self.view.endEditing(true)
    }
    
    //전화번호에 "-" 삽입하기.
    func phonenumberCharInsert(){
        guard var num = personPhoneNum.text else {
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
    
    //저장버튼 눌렸을 때.
    @IBAction func saveClicked(_ sender: Any) {
        //입력필드가 비어있으면 저장이 되지 않고 알림을 띄움.
        guard let name = personName.text, name.isEmpty == false, let number = personPhoneNum.text, number.isEmpty == false else {
            let dialog = UIAlertController(title: "필수", message: "이름 혹은 번호를 입력하세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
            dialog.addAction(action)
            self.present(dialog, animated: true, completion: nil)
            return
        }
        //저장되어있으면 "-"추가하여 Info추가하고 이전 뷰로 되돌아간다.
        phonenumberCharInsert()
        let info = InfoManager.shared.createInfo(dataName: name, dataNumber: getNumber, dataImage: getImageName, isStar: false)
        InfoManager.shared.addInfo(info)
        self.navigationController?.popViewController(animated: true)
    }
    
    //취소 버튼 눌렀을 때, 알림을 띄우고, 정말 취소 할 것인지 다시 한번 물어보기.
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

//키보드가 올라가거나 내려갈때, 입력 필드의 배치 지정해주기.
extension SecondViewController {
    @objc private func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        // [x] TODO: 키보드 높이에 따른 인풋뷰 위치 변경
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if noti.name == UIResponder.keyboardWillShowNotification {
            let adjustmentHeight = keyboardFrame.height - view.safeAreaInsets.bottom
            stackViewBottom.constant = adjustmentHeight
        } else {
            stackViewBottom.constant = 120
        }
        print("---> Keyboard End Frame: \(keyboardFrame)")
    }
}

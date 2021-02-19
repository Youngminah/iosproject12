//
//  ViewController.swift
//  TableView
//
//  Created by meng on 2021/02/16.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

//    var dataName = [
//        ["철수","민수","영희"],
//        ["아영","민희","영수"]
//    ]
//
//    var dataNumber = [
//        ["010-6565-6565","010-3456-3456","010-2435-3535"],
//        ["010-7777-7777","010-3454-3535","010-3435-3434"]
//    ]
//
//    var dataImage = [
//        ["male.png","male.png","male.png"],
//        ["male.png","male.png","male.png"]
//    ]
    
    var Infolist: [[Info]] = []
    let heardername = ["즐겨찾기","친구"]
    
    let infoListViewModel = InfoViewModel()
    
//    var name: String?
//    var number: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        infoListViewModel.loadTasks()
//        let info = InfoManager.shared.createInfo(dataName: "영수", dataNumber: "010-6666-6666", dataImage: "male.png", isStar: false)
//        Storage.saveTodo(info, fileName: "text.json")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        let info = Storage.restoreTodo("text.json")
        print("\(info)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let info = Storage.restoreTodo("text.json")
//        print("\(info)")
    }
    
    @IBAction func addClicked(_ sender: UIButton) {
        guard let receiveViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else{
            return
        }
        self.navigationController?.pushViewController(receiveViewController, animated: true)
    }
    
    //각 섹션의 들어있는 데이터 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("실행")
        if section == 0 {
            return infoListViewModel.starInfos.count
        } else {
            return infoListViewModel.unstarInfos.count
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return infoListViewModel.numOfSection
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return heardername[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        
        var info: Info
        if indexPath.section == 0 {
            info = infoListViewModel.starInfos[indexPath.row]
        } else {
            info = infoListViewModel.unstarInfos[indexPath.row]
        }
        
        cell.updateUI(info: info)
        
//        if indexPath.row == 5 {
//            cell.backgroundColor = .white
//        }else {
//            cell.backgroundColor = .systemBackground
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("클릭되었음.")
        print(Infolist[1])
    }
}

class ListCell: UITableViewCell{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    


    func updateUI(info: Info) {
        nameLabel.text = info.dataName
        numberLabel.text = info.dataNumber
        imgView.image = UIImage(named: info.dataImage)
    }
}


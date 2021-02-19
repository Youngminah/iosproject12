//
//  ViewController.swift
//  TableView
//
//  Created by meng on 2021/02/16.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let heardername = ["즐겨찾기","친구목록"]
    
    let infoListViewModel = InfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //저장되어있는 데이터 가져오기
        infoListViewModel.loadTasks()
        // Do any additional setup after loading the view.
//        let info = InfoManager.shared.createInfo(dataName: "영수", dataNumber: "010-6666-6666", dataImage: "male.png", isStar: false)
//        Storage.saveTodo(info, fileName: "text.json")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        tableView.reloadData()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            if let indexPath = sender as? IndexPath {
                var info: Info
                if indexPath.section == 0 {
                    info = infoListViewModel.starInfos[indexPath.row]
                } else {
                    info = infoListViewModel.unstarInfos[indexPath.row]
                }
                vc?.name = info.dataName
                vc?.number = info.dataNumber
                vc?.img = UIImage(named: info.dataImage)
            }
        }
    }
    

    
    //각 섹션의 들어있는 데이터 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    //해더 섹션 총 갯수 몇개 ?
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return heardername[section]
    }
    
    //해더 섹션 폰트, 폰트크기 정하기
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 15)
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
        
        cell.starButtonTapHandler = { isStar in
            info.isStar = isStar
            self.infoListViewModel.updateInfo(info)
            self.tableView.reloadData()
        }
        
//        if indexPath.row == 5 {
//            cell.backgroundColor = .white
//        }else {
//            cell.backgroundColor = .systemBackground
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath)
        print("클릭되었음.")
    }
}

class ListCell: UITableViewCell{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var starAdd: UIButton!
    
    var starButtonTapHandler: ((Bool) -> Void)?
    
    func updateUI(info: Info) {
        nameLabel.text = info.dataName
        numberLabel.text = info.dataNumber
        imgView.layer.cornerRadius = 10;
        imgView.image = UIImage(named: info.dataImage)
        starAdd.isSelected = info.isStar
    }
    
    @IBAction func starClicked(_ sender: UIButton) {
        starAdd.isSelected = !starAdd.isSelected
        let isStar = starAdd.isSelected
        starButtonTapHandler?(isStar)
    }
    
}


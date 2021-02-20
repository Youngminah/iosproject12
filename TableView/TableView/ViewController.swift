//
//  ViewController.swift
//  TableView
//
//  Created by meng on 2021/02/16.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITableViewDropDelegate, UITableViewDragDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let heardername = ["즐겨찾기","친구목록"] //섹션 이름.
    let infoListViewModel = InfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //저장되어있는 데이터 가져오기
        infoListViewModel.loadTasks()
        self.tableView.dragInteractionEnabled = true
        self.tableView.dragDelegate = self
        self.tableView.dropDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()  //테이블 재배치하기.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //"+"버튼 클릭시 실행 되는 함수.
    @IBAction func addClicked(_ sender: UIButton) {
        guard let receiveViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else{
            return
        }
        self.navigationController?.pushViewController(receiveViewController, animated: true)
    }
    
    //세그웨이 실행직전 실행되는 함수. 세그웨이 데이터 셋팅.
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
    
    //테이블 뷰 각 섹션의 들어있는 데이터 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return infoListViewModel.starInfos.count
        } else {
            return infoListViewModel.unstarInfos.count
        }
    }

    //테이블 뷰 헤더 섹션의 높이 설정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    //테이블 뷰 해더 섹션 총 갯수 몇개 ?
    func numberOfSections(in tableView: UITableView) -> Int {
        return infoListViewModel.numOfSection
    }
    
    //테이블 뷰 해더 섹션의 타이틀 이름 설정.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return heardername[section]
    }
    
    //테이블 뷰 해더 섹션 폰트, 폰트크기 정하기
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 15)
    }
    
    //테이블 뷰에 커스텀 셸 재사용 함수이용하여 삽입하기.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        //재사용 문제 해결을 위해 각각 모든 cell을 지정해준다.
        var info: Info
        if indexPath.section == 0 {
            info = infoListViewModel.starInfos[indexPath.row]
        } else {
            info = infoListViewModel.unstarInfos[indexPath.row]
        }
        //셸 업뎃.
        cell.updateUI(info: info)
        //즐겨찾기가 눌렸을 경우 발생하는 클로져
        cell.starButtonTapHandler = { isStar in
            info.isStar = isStar
            self.infoListViewModel.updateInfo(info)
            self.tableView.reloadData()
        }
        return cell
    }
    
    //테이블 뷰 클릭하면 세그웨이 띄우기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath)
        print("클릭되었음.")
    }
    
    //테이블 뷰 수정 가능?
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //테이블 뷰 trailing 옆으로 밀어서 딜리트 시키기.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            var info: Info
            if indexPath.section == 0 {
                info = infoListViewModel.starInfos[indexPath.row]
            } else {
                info = infoListViewModel.unstarInfos[indexPath.row]
            }
            self.infoListViewModel.deleteInfo(info)
            self.tableView.reloadData()
        }
    }

    //테이블 뷰 trailing 옆으로 밀어서 수정 시키기.
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath:IndexPath) -> UISwipeActionsConfiguration? {

            let shareAction = UIContextualAction(style: .normal, title:  "수정", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                
                guard let receiveViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as? EditViewController else{
                    return
                }
                
                var info: Info
                if indexPath.section == 0 {
                    info = self.infoListViewModel.starInfos[indexPath.row]
                } else {
                    info = self.infoListViewModel.unstarInfos[indexPath.row]
                }
                
                receiveViewController.getName = info.dataName
                receiveViewController.getImageName = info.dataImage
                receiveViewController.getNumber = info.dataNumber
                receiveViewController.info = info
                self.navigationController?.pushViewController(receiveViewController, animated: true)
                success(true)
                self.tableView.reloadData()
            })
            return UISwipeActionsConfiguration(actions:[shareAction])

    }
    
    //테이블 뷰의 행을 옮길 수 있는지 ?
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    //테이블 뷰 드래그엔 드랍으로 행을 바꿔주기
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if destinationIndexPath.section != sourceIndexPath.section{
            print("같지않음")
            return
        }
//        var info: Info
//        if sourceIndexPath.section == 0 {
//            info = self.infoListViewModel.starInfos[sourceIndexPath.row]
//        } else {
//            info = self.infoListViewModel.unstarInfos[sourceIndexPath.row]
//        }
//        self.infoListViewModel.deleteInfo(info)
//        self.infoListViewModel.insertInfo(info, destinationIndexPath.row)
//        self.tableView.reloadData()
    }
    
    //테이블 뷰 드래그엔 드랍 프로토콜
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]

    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
    }

}

//커스텀 셸 만들기.
class ListCell: UITableViewCell{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var starAdd: UIButton!
    
    var starButtonTapHandler: ((Bool) -> Void)?  //클로져.
    
    //셸 업뎃함수.
    func updateUI(info: Info) {
        nameLabel.text = info.dataName
        numberLabel.text = info.dataNumber
        imgView.layer.cornerRadius = 10;
        imgView.image = UIImage(named: info.dataImage)
        starAdd.isSelected = info.isStar
    }
    
    //별모양 버튼 클릭시 발생되는 함수.
    @IBAction func starClicked(_ sender: UIButton) {
        starAdd.isSelected = !starAdd.isSelected
        let isStar = starAdd.isSelected
        starButtonTapHandler?(isStar)
    }
    
}


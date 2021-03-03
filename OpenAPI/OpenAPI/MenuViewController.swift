//
//  MenuViewController.swift
//  OpenAPI
//
//  Created by meng on 2021/03/03.
//

import UIKit

class MenuViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionview: UICollectionView!
    
    let menuList = ["newspaper", "music.note.list", "photo","play.tv" ,"pencil","gamecontroller","cloud.sun","car"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as?  MenuCell else {
            return UICollectionViewCell()
        }
        let image = UIImage(systemName: menuList[indexPath.item])
        cell.menuButton.setImage(image, for: .normal)
        return cell
        
    }
    
    //UICollectionViewDelegateFlowLayout 프로토콜
    //cell사이즈를  계산할꺼 - 다양한 디바이스에서 일관적인 디자인을 보여주기 위해 에 대한 답
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        
        let width: CGFloat = (collectionview.bounds.width - itemSpacing)/2
        let height: CGFloat = (collectionview.bounds.height - itemSpacing*3)/4
        return CGSize(width: width, height: height)
    }
    
    
}


class MenuCell: UICollectionViewCell{
    
    @IBOutlet weak var menuButton: UIButton!
}

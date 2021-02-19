//
//  InfoList.swift
//  TableView
//
//  Created by meng on 2021/02/19.
//

import UIKit


struct Info: Codable, Equatable{
    
    let id: Int
    var dataName: String
    var dataNumber: String
    var dataImage: String
    var isStar: Bool
    
    mutating func update(dataName: String, dataNumber: String, dataImage: String, isStar: Bool){
        self.dataName = dataName
        self.dataNumber = dataNumber
        self.dataImage = dataImage
        self.isStar = isStar
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        // [x]TODO: 동등 조건 추가
        return lhs.id == rhs.id
    }

}


class InfoManager {
    
    static let shared = InfoManager()
    
    static var lastId: Int = 0
    
    var infos: [Info] = []
    
    func createInfo(dataName: String, dataNumber: String, dataImage: String, isStar: Bool) -> Info {
        // [x] TODO: create로직 추가
        let nextId = InfoManager.lastId + 1
        InfoManager.lastId = nextId
        return Info(id: nextId,dataName: dataName, dataNumber: dataNumber, dataImage: dataImage, isStar: isStar)
        
    }
    
    func addInfo(_ info: Info) {
        // [x] TODO: add로직 추가
        infos.append(info)
        saveInfo()
    }
    
    func deleteInfo(_ info: Info) {
        // [x] TODO: delete 로직 추가
        infos = infos.filter { $0.id != info.id }
//        if let index = todos.firstIndex(of: todo) {
//            todos.remove(at: index)
//        }
        saveInfo()
    }

    func updateInfo(_ info: Info) {
        // [x] TODO: updatee 로직 추가
        guard let index = infos.firstIndex(of: info) else { return }
        infos[index].update(dataName: info.dataName, dataNumber: info.dataNumber, dataImage: info.dataImage, isStar: info.isStar)
        saveInfo()
    }

    func saveInfo() {
        Storage.store(infos, to: .documents, as: "test.json")
    }

    func retrieveInfo() {
        infos = Storage.retrive("test.json", from: .documents, as: [Info].self) ?? []

        let lastId = infos.last?.id ?? 0
        InfoManager.lastId = lastId
    }
}


class InfoViewModel {
    
    enum Section: Int, CaseIterable {
        case star
        case friend
        
        var title: String {
            switch self {
            case .star: return "즐겨찾기"
            default: return "친구목록"
            }
        }
    }
    
    private let manager = InfoManager.shared
    
    var infos: [Info] {
        return manager.infos
    }
    
    var starInfos: [Info] {
        return infos.filter { $0.isStar == true }
    }
    
    var unstarInfos: [Info] {
        return infos.filter { $0.isStar == false }
    }
    
    var numOfSection: Int {
        return Section.allCases.count
    }
    
    func addInfo(_ info: Info) {
        manager.addInfo(info)
    }
    
    func deleteInfo(_ info: Info) {
        manager.deleteInfo(info)
    }
    
    func updateInfo(_ info: Info) {
        manager.updateInfo(info)
    }
    
    func loadTasks() {
        manager.retrieveInfo()
    }
}

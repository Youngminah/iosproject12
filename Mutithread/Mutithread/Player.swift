//
//  Player.swift
//  Mutithread
//
//  Created by meng on 2021/02/24.
//

import UIKit

class Player: NSObject {
    
    enum Value: Int {
      case empty
      case brain
      case zombie
      
      var name: String {
        switch self {
        case .empty:
          return ""
          
        case .brain:
          return "Brain"
          
        case .zombie:
          return "Zombie"
        }
      }
    }
    
    var value: Value
    var name: String
    
    static var allPlayers = [
      Player(.brain),
      Player(.zombie)
    ]
    
    var opponent: Player {
      if value == .zombie {
        return Player.allPlayers[0]
      } else {
        return Player.allPlayers[1]
      }
    }
    
    init(_ value: Value) {
      self.value = value
      name = value.name
    }
    
}

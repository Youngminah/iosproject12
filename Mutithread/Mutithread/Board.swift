//
//  Board.swift
//  Mutithread
//
//  Created by meng on 2021/02/24.
//

import GameplayKit

class Board: NSObject {

    var currentPlayer = Player.allPlayers[arc4random() % 2 == 0 ? 0 : 1]
    
    fileprivate var values: [[Player.Value]] = [
      [.empty, .empty, .empty],
      [.empty, .empty, .empty],
      [.empty, .empty, .empty]
    ]
    
    subscript(x: Int, y: Int) -> Player.Value {
      get {
        return values[y][x]
      }
      set {
        if values[y][x] == .empty {
          values[y][x] = newValue
        }
      }
    }
    
    var isFull: Bool {
      for row in values {
        for tile in row {
          if tile == .empty {
            return false
          }
        }
      }
      return true
    }
    
    var winningPlayer: Player? {
      for column in 0..<values.count {
        if values[column][0] == values[column][1] && values[column][0] == values[column][2] && values[column][0] != .empty {
          if let index = Player.allPlayers.firstIndex(where: { player -> Bool in
            return player.value == values[column][0]
          }) {
            return Player.allPlayers[index]
          } else {
            return nil
          }
        } else if values[0][column] == values[1][column] && values[0][column] == values[2][column] && values[0][column] != .empty {
          if let index = Player.allPlayers.firstIndex(where: { player -> Bool in
            return player.value == values[0][column]
          }){
            return Player.allPlayers[index]
          } else {
            return nil
          }
        }
      }
      
      if values[0][0] == values[1][1] && values[0][0] == values[2][2] && values[0][0] != .empty {
        if let index = Player.allPlayers.firstIndex(where: { player -> Bool in
          return player.value == values[0][0]
        }){
          return Player.allPlayers[index]
        } else {
          return nil
        }
      } else if values[2][0] == values[1][1] && values[2][0] == values[0][2] && values[0][2] != .empty {
        if let index = Player.allPlayers.firstIndex(where: { player -> Bool in
          return player.value == values[2][0]
        }){
          return Player.allPlayers[index]
        } else {
          return nil
        }
      } else {
        return nil
      }
    }
    
    func clear() {
      for x in 0..<values.count {
        for y in 0..<values[x].count {
          self[x, y] = .empty
        }
      }
    }
    
    func canMove(at position: CGPoint) -> Bool {
      if self[Int(position.x), Int(position.y)] == .empty {
        return true
      } else {
        return false
      }
    }
}

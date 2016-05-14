//
//  Player.swift
//  LetsAttack
//
//  Created by Bhrigu Gupta on 11/05/16.
//  Copyright © 2016 Awwsome. All rights reserved.
//

import Foundation

class Player{
    
    // my properties
    private var _hp : Int = 100
    private var _attackPwr : Int!
    private var _characterName : String!
    
    // my methods
    init(hp : Int, attackPwr : Int, name : String) {
        _hp = hp
        _attackPwr = attackPwr
        _characterName = name
    }
    
    var hp : Int {
        get {
            return _hp
        }
    }
    
    var attackPwr : Int {
        return _attackPwr
    }
    
    func IsAlive() -> Bool {
        if _hp > 0 {
            return true
        } else {
            return false
        }
    }
    
    var characterName : String {
        return _characterName
    }
    
    func ReduceHp(attackPWr : Int) -> Int{
        _hp -= attackPwr
        return _hp
    }
}
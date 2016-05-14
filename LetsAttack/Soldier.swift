//
//  Soldier.swift
//  LetsAttack
//
//  Created by Bhrigu Gupta on 11/05/16.
//  Copyright © 2016 Awwsome. All rights reserved.
//

import Foundation
class Soldier: Player {
    
    // my properties
    private var immunity = 15 //won't harm if the atack is less than 15
    
    
    convenience init(hp: Int, attackPwr: Int, name: String, immunity : Int) {
        self.init(hp: hp, attackPwr: attackPwr, name: name)
        self.immunity = immunity
        
    }
    override func ReduceHp(attackPWr: Int!) -> Int {
        if attackPwr > immunity {
            return super.ReduceHp(attackPwr)
        }
        return hp
    }
}

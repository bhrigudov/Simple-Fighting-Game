//
//  Game.swift
//  LetsAttack
//
//  Created by Bhrigu Gupta on 11/05/16.
//  Copyright © 2016 Awwsome. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Game : NSObject{
    
    // my properties
    var vc : ViewController!
    
    var bgmusic, punchSound : AVAudioPlayer!
    
    private var player1, player2 : Player!
    private var player1HasBeenSelected, player2HasBeenSelected : Bool!
    private var attackAllowed : Bool

    
    //my functions
    init(vc : ViewController!) {
        self.vc = vc
        
        player1HasBeenSelected = false
        player2HasBeenSelected = false
        
        let path = NSBundle.mainBundle().pathForResource("bgmusic", ofType: "mp3")
        let audioURL = NSURL(fileURLWithPath: path!)
        
        do {
            try bgmusic = AVAudioPlayer(contentsOfURL: audioURL)
            bgmusic.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        bgmusic.play()

        attackAllowed = true
    }
   
    func AddSound(inout audioVar : AVAudioPlayer!, name : String!, type : String!) {
        let path = NSBundle.mainBundle().pathForResource(name, ofType: type)
        let audioURL = NSURL(fileURLWithPath: path!)
        
        do {
            try audioVar = AVAudioPlayer(contentsOfURL: audioURL)
            audioVar.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        audioVar.play()
    }
    
    func AllowAttack() {
        attackAllowed = true
    }
    
    func DoChangesAfterAttack(player : Player!, enemy : Player!) -> Int{
        let oldHP = player.hp
        let newHp = player.ReduceHp(player.attackPwr)
        
        if newHp <= 0 {
            vc.AttackInfoLbl.text = "\(enemy.characterName) won !"
            return newHp
        }
        
        vc.AttackInfoLbl.text = "\(enemy.characterName) attacked for \(oldHP - newHp)HP"
        return newHp
    }
    
    func MakeCharacterImg(btn : UIButton!, inout img : UIImageView!) {
        let imgName = "character"+"\(btn.tag)"
        img.image = UIImage(named: imgName)
    }
    
    func endGame() {
        vc.Player1Img.hidden = true
        vc.Player2Img.hidden = true
        vc.Player1HPLbl.hidden = true
        vc.Player2HPLbl.hidden = true
        vc.Player1AttackBtn.hidden = true
        vc.Player2AttackBtn.hidden = true
        vc.Player1AttackLbl.hidden = true
        vc.player2AttackLbl.hidden = true

        vc.restartBtn.hidden = false
    }
    
    func Character1Pressed(btn : UIButton!) {
        
        vc.character1.hidden = true
        vc.player1SelectedLbl.hidden = false
        player1HasBeenSelected = true
        
        GenerateCharacter(btn, playero: &player1)
        MakeCharacterImg(btn, img: &vc.Player1Img)
        vc.Player1HPLbl.text = "\(player1.hp)HP"
        
        ShowStartGameBtn()
    }
    
    func Character2Pressed(btn : UIButton!) {
        vc.character2.hidden = true
        vc.player2SelectedLbl.hidden = false
        player2HasBeenSelected = true
        
        GenerateCharacter(btn, playero : &player2)
        MakeCharacterImg(btn, img: &vc.Player2Img)
        vc.Player2HPLbl.text = "\(player2.hp)HP"

        ShowStartGameBtn()
    }
    
    func GenerateCharacter(pressedButton : UIButton!, inout playero : Player!) {
        let playerName = pressedButton.titleLabel!.text
        
        let randHP = (Int)(arc4random_uniform(10)+5)*10
        let attackPwr = (Int)(arc4random_uniform(4)+3)*5
        
        switch pressedButton.tag {
        case 1 :
            playero = Player(hp: randHP, attackPwr: attackPwr, name: playerName!)
        case 2:
            playero = Player(hp: randHP, attackPwr: attackPwr, name: playerName!)
        case 3:
            playero = Player(hp: randHP, attackPwr: attackPwr, name: playerName!)
        case 4:
            playero = Player(hp: randHP, attackPwr: attackPwr, name: playerName!)
            
        default:
            print("None character was selected")
        }
        
    }
    
    func StartGame() {
        //hiding screen 1
        vc.player1SelectedLbl.hidden = true
        vc.player2SelectedLbl.hidden = true
        vc.startGameBtn.hidden = true
        vc.logo.hidden = true
        
        //unhiding screen 2
        vc.Player1Img.hidden = false
        vc.Player2Img.hidden = false
        vc.ground.hidden =  false
        vc.printScreen.hidden = false
        vc.Player1HPLbl.hidden = false
        vc.Player2HPLbl.hidden = false
        vc.AttackInfoLbl.hidden = false
        vc.Player1AttackBtn.hidden = false
        vc.Player2AttackBtn.hidden = false
        vc.Player1AttackLbl.hidden = false
        vc.player2AttackLbl.hidden = false
        
        vc.AttackInfoLbl.text = "Attack to start Fight!"
        
    }

    func ShowStartGameBtn() {
        if player2HasBeenSelected! && player1HasBeenSelected! {
            vc.startGameBtn.hidden = false
        }
    }
    
    func Attack(playerIndex : Int) {
        if attackAllowed {
            AddSound(&punchSound, name: "punchSound", type: "mp3")
            
            attackAllowed = false
            
            if playerIndex == 1 {
                
                let newHP = DoChangesAfterAttack(player2, enemy: player1)
                if newHP > 0 {
                    vc.Player2HPLbl.text = "\(newHP)HP"
                } else {
                    endGame()
                }
                
            } else {
                let newHP = DoChangesAfterAttack(player1, enemy: player2)
                if newHP > 0 {
                    vc.Player1HPLbl.text = "\(newHP)HP"
                } else {
                    endGame()
                }
            }
           
            NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "AllowAttack", userInfo: nil, repeats: false)
        }
    }
    
    func RestartGame() {
        //hiding screen 2
        vc.ground.hidden =  true
        vc.printScreen.hidden = true
        vc.AttackInfoLbl.hidden = true
        vc.restartBtn.hidden = true
        
        //unhiding screen 1
        vc.logo.hidden = false
        vc.character1.hidden = false
        vc.character2.hidden = false
        
        player1HasBeenSelected = false
        player2HasBeenSelected = false
    }
    
}
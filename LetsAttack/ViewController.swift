//
//  ViewController.swift
//  LetsAttack
//
//  Created by Bhrigu Gupta on 11/05/16.
//  Copyright © 2016 Awwsome. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var game : Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Game(vc: self)
    }


    //my outlets
    @IBOutlet weak var logo : UIImageView!
    
    @IBOutlet weak var player1Lbl : UILabel!
    @IBOutlet weak var player2Lbl : UILabel!
    @IBOutlet weak var player1SelectedLbl : UILabel!
    @IBOutlet weak var player2SelectedLbl : UILabel!
    
    @IBOutlet weak var startGameBtn : UIButton!
    @IBOutlet weak var restartBtn: UIButton!
    
    @IBOutlet weak var character1 : UIStackView!
    @IBOutlet weak var character2 : UIStackView!
    
    @IBOutlet weak var Player1AttackLbl: UILabel!
    @IBOutlet weak var player2AttackLbl: UILabel!
    
    @IBOutlet weak var Player1AttackBtn: UIButton!
    @IBOutlet weak var Player2AttackBtn: UIButton!
    
    @IBOutlet weak var Player1HPLbl: UILabel!
    @IBOutlet weak var Player2HPLbl: UILabel!
    @IBOutlet weak var AttackInfoLbl: UILabel!
    
    @IBOutlet weak var Player1Img: UIImageView!
    @IBOutlet weak var Player2Img: UIImageView!
    @IBOutlet weak var ground: UIImageView!
    @IBOutlet weak var printScreen: UIImageView!
    
    
    // my actions
    @IBAction func Player1Selected(btn : UIButton!) {
        game.Character1Pressed(btn)
    }
    
    @IBAction func Player2Selected(btn : UIButton!) {
        game.Character2Pressed(btn)
    }
    
    @IBAction func StartGame(btn : UIButton!) {
        game.StartGame();
    }
    
    @IBAction func Player1AttackPressed(btn : UIButton!) {
        game.Attack(1)
    }
    
    @IBAction func Player2AttackPressed(btn : UIButton!) {
        game.Attack(2)
    }
    
    @IBAction func RestartGame() {
        game.RestartGame()
    }

}


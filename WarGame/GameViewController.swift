//
//  GameViewController.swift
//  WarGame
//
//  Created by Luba Gluhov on 08/06/2023.
//

import UIKit

class GameViewController: UIViewController{
    
    var message: String?
    var name = UserDefaults.standard.string(forKey:"StoredTextKey")
    var imageArray: [UIImage] = [#imageLiteral(resourceName: "two"), #imageLiteral(resourceName: "three"), #imageLiteral(resourceName: "four"), #imageLiteral(resourceName: "five"), #imageLiteral(resourceName: "six"), #imageLiteral(resourceName: "seven"), #imageLiteral(resourceName: "eight"), #imageLiteral(resourceName: "nine"), #imageLiteral(resourceName: "ten"), #imageLiteral(resourceName: "prince"), #imageLiteral(resourceName: "queen"), #imageLiteral(resourceName: "king"), #imageLiteral(resourceName: "as") , #imageLiteral(resourceName: "backBlue")]
    @IBOutlet weak var eastCards: UIImageView!
    @IBOutlet weak var westName: UILabel!
    @IBOutlet weak var westCards: UIImageView!
    @IBOutlet weak var eastName: UILabel!
    @IBOutlet weak var eastGamer: UILabel!
    @IBOutlet weak var viewCounter: UILabel!
    @IBOutlet weak var clock: UIImageView!
    @IBOutlet weak var westGamer: UILabel!
    var timer1: Timer?
    var timer2: Timer?
    var timerCounter1 = 0
    var timerCounter2 = 0
    var roundCounter = 0
    var scoreCounterPc = 0
    var scoreCounterGamer = 0
    var indexEast: Int = 0
    var indexWest: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"back2.png")!)
        startTimer()
        if let message = message {
            if message == "west"
            {
                westName.text=name
                eastName.text="PC"
            } else if message == "east" {
                eastName.text=name
                westName.text="PC"

            }
        }
    }
    func openPopup() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let popupViewController = storyboard.instantiateViewController(withIdentifier: "FinishGameViewController") as! FinishGameViewController
        if(scoreCounterPc>scoreCounterGamer){
            popupViewController.winnerScore=String(scoreCounterPc)
            popupViewController.winnerName="PC"

        }else if(scoreCounterPc==scoreCounterGamer){
            popupViewController.winnerScore=String(scoreCounterPc)
            popupViewController.winnerName="Tie"
        }
        else{
            popupViewController.winnerScore=String(scoreCounterGamer)
            popupViewController.winnerName=name
        }
        present(popupViewController, animated: true, completion: nil)
    }
    
    func startTimer() {
        timer1?.invalidate()
        timer1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }

    @objc func timerAction() {
            timerCounter1 += 1
            viewCounter.text = String(timerCounter1)
            if timerCounter1 > 5 {
                viewCounter.text = String(0)
                indexEast = Int.random(in: 0...12)
                eastCards.image = imageArray[indexEast]
                indexWest = Int.random(in: 0...12)
                westCards.image = imageArray[indexWest]
                stopTimer()
            }
        }
    func stopTimer() {
        timer1?.invalidate()
        timer1 = nil
        startTimer2()
        timerCounter1=0
        if let message = message {
            if message == "west"
            {
                if( indexEast < indexWest ){
                    scoreCounterGamer+=1
                    westGamer.text=String(scoreCounterGamer)
                }else{
                    scoreCounterPc+=1
                    eastGamer.text=String(scoreCounterPc)
                }
            } else if message == "east" {
                if( indexEast < indexWest ){
                    scoreCounterPc+=1
                    westGamer.text=String(scoreCounterPc)
                }else if(indexEast > indexWest){
                    scoreCounterGamer+=1
                    eastGamer.text=String(scoreCounterGamer)
                }
            }
        }
    }
    
    
    func startTimer2() {
        timer2?.invalidate()
        timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction2), userInfo: nil, repeats: true)
        }
    
    @objc func timerAction2() {
            timerCounter2 += 1
            viewCounter.text = String(timerCounter2)
            if timerCounter2 > 3 {
                viewCounter.text = String(0)
                eastCards.image = imageArray[13]
                westCards.image = imageArray[13]
                stopTimer2()
            }
        }

    func stopTimer2() {
        timer2?.invalidate()
        timer2 = nil
        timerCounter2=0
        roundCounter+=1;
        if(roundCounter < 5){
            startTimer()
        }
        if( roundCounter == 5){
            openPopup()
        }
    }

}

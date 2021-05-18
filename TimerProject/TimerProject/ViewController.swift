//
//  ViewController.swift
//  TimerProject
//
//  Created by Mehmet Nafi ISLEK on 6.05.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    var timer = Timer()
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
       counter = 10
        timeLabel.text = "Time: \(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
    }
    
    /* scheduledTimer zamanı kurduk timeınterval ile 1 saniyede bir çalışacak self yani bu view controllerda çalışacak bir fonksiyonu selector fonksiyonu seçiyorum objc fonksiyonu seçtik user info kullanıcı infosuna gerek var mı repeats tekrar ediyor mu diye soruyor timer.invalidate ise bu timerı durdurur.*/
    @objc func timerFunction(){
        timeLabel.text = "Time: \(counter)"
        counter -= 1
        if counter == 0{
            timer.invalidate()
            timeLabel.text = "Times Over"
        }
    }
    

    @IBAction func butonClicked(_ sender: Any) {
        print("Butona bastın")
    }
    
}


//
//  ViewController.swift
//  HesapMakinesi
//
//  Created by Mehmet Nafi ISLEK on 1.05.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var num1: UITextField!
    
    @IBOutlet weak var num2: UITextField!
    
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func sumButon(_ sender: Any) {
        let num1 = Int(num1.text!)!
        let num2 = Int(num2.text!)!
        let toplam = num1 + num2
        result.text = String(toplam)
    }
    @IBAction func minusButon(_ sender: Any) {
        let num1 = Int(num1.text!)!
        let num2 = Int(num2.text!)!
        let toplam = num1 - num2
        result.text = String(toplam)
    }
    
    @IBAction func multiplyClicked(_ sender: Any) {
        let num1 = Int(num1.text!)!
        let num2 = Int(num2.text!)!
        let toplam = num1 * num2
        result.text = String(toplam)
    }
    @IBAction func divideButon(_ sender: Any) {
        let num1 = Int(num1.text!)!
        let num2 = Int(num2.text!)!
        let toplam = num1 / num2
        result.text = String(toplam)
    }
    
    
   
}


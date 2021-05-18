//
//  ViewController.swift
//  SegueApp
//
//  Created by Mehmet Nafi ISLEK on 3.05.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myLabel1st: UILabel!
    @IBOutlet weak var nameText: UITextField!
    
    var userName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad function called") // kullanıcı görmeden daha viewDidLoad 1 yapılıyor
        //viewDidLoad ilk açtığında yapılıyor ve 2.sayfaya gittiğinde çalışmıyor tekrar
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear function called") // artık gitti ikinci görünümdeyiz
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear function called") // görünüm gidebilir ikinci görünüme geçebilir ekrana geri döndüğümde işlemi yapıyor
    }
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear function called") // kullanıcı görmek üzere 2
    }
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear function called") // kullanıcı artık gördü 3
    }
    @IBAction func nextClicked(_ sender: Any) {
        
        performSegue(withIdentifier:"toSecondVC" , sender: nil) // bu segue yi gerçekleştir butona tıklanınca
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // segue olmadan önce son çalışan fonksiyon
        if segue.identifier == "toSecondVC" {
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.myName = userName
        }
    }
    
}


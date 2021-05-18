//
//  ViewController.swift
//  ObjectsWithCode
//
//  Created by Mehmet Nafi ISLEK on 2.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var myLabel = UILabel() // bir text değişkeni oluşturduk

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let widht = view.frame.size.width  // telefonun genişliğini aldık ve widht e atadık
        let height = view.frame.size.height // telefonun yüksekliğini aldık ve height e atadık
        
        myLabel.text = "Text Here" // textin içinde yazan şey
        myLabel.textAlignment = .center // textin text için açılan yerin neresinde yazacağı                           .left de olabilirdi mesela, alligment = hizalama demek
        myLabel.frame = CGRect(x: widht * 0.5 - widht * 0.8 / 2, y: height * 0.5 - 50/2, width: widht * 0.8, height: 50) //myLabel ın telefondaki yerini belirliyoruz frame = bir diktörtgendir boyutunu ve nerde durduğunu belirtir
        view.addSubview(myLabel) // telefonda gösterimi yapılıyor görünümü eklemek içine atmak mainstoryboardda tutup atmak gibi bir şey
        
        let myButton = UIButton()
        myButton.setTitle("My Button", for: UIControl.State.normal)
        myButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        myButton.frame = CGRect(x: widht * 0.5 - 100, y: height * 0.6, width: 200, height: 100)
        view.addSubview(myButton)
        myButton.addTarget(self, action:#selector(ViewController.myAction),for: UIControl.Event.touchUpInside) // self = ViewController ın içinde bir fonksiyon vereceğimin haberi ViewController içinden bir aksiyon çağıracaksın anladık
        //#selector diyince fonksiyon istiyor ? tam olarak ne neden @objc istiyor fonksiyonu
        
    }
    @objc func myAction() {
        myLabel.text = "Tapped"
    }
    

}


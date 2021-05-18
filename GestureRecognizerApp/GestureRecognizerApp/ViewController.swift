//
//  ViewController.swift
//  GestureRecognizerApp
//
//  Created by Mehmet Nafi ISLEK on 5.05.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    var istutamadi = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true // kullanıcı resme tıklayabilsin mi kodu
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:  #selector(changePic)) // uı tap yani dokununca çalışacak bir kod self = viewControllerın içinde 
        imageView.addGestureRecognizer(gestureRecognizer)
    }

    @objc func changePic(){
        
        if istutamadi == true{
            imageView.image = UIImage(named: "basaramadik")
            myLabel.text = "İbo-Dertler Derya"
            istutamadi = false
        }else{
            
            imageView.image = UIImage(named: "tutamadi")
            myLabel.text = "Catch Boy!"
            istutamadi = true
        }
        
    }
}


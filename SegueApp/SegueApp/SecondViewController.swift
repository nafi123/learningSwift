//
//  SecondViewController.swift
//  SegueApp
//
//  Created by Mehmet Nafi ISLEK on 3.05.2021.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var myLabelSecond: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var myName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = myName
        
    }
   
    

}

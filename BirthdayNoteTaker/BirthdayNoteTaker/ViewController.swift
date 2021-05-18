//
//  ViewController.swift
//  BirthdayNoteTaker
//
//  Created by Mehmet Nafi ISLEK on 2.05.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let storedName = UserDefaults.standard.object(forKey: "name") // kaydedilmiş ismi yani kullanıcı yazdı veritabanına kaydettiği ismi storedName e yani kaydedilmiş isme atadık object ve kodadını söylememiz yeterli oldu
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        if let newName = storedName as? String{ // casting işlemi var as? vs. as! yani kesin String mi gelecek
            nameLabel.text = "Name: \(newName)"
        }
        if let newBirthday = storedBirthday as? String{
            birthdayLabel.text = "BirthDay: \(newBirthday)"
        }
    }
    @IBAction func saveClicked(_ sender: Any) {
        UserDefaults.standard.setValue(nameTextField.text!, forKey: "name") //Veritabanına erişip name kodadlı kullanıcıdan geleni yolladık
        UserDefaults.standard.setValue(birthdayTextField.text!, forKey: "birthday")
        nameLabel.text = "Name: \(nameTextField.text!)"
        birthdayLabel.text = "Birthday: \(birthdayTextField.text!)"
        
        
    }
    // Veritabanından silme işlemi
    @IBAction func deleteClicked(_ sender: Any) {
        
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
        if(storedName as? String) != nil { // eğer bir şeyler varsa boş değilse string varsa
            UserDefaults.standard.removeObject(forKey: "name")
            nameLabel.text = "Name: "
        }
        if(storedBirthday as? String) != nil {
            UserDefaults.standard.removeObject(forKey: "birthday")
            nameLabel.text = "Birthday: "
        }
    }
    

}


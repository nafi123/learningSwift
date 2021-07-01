//
//  ViewController.swift
//  InstaCloneFirebase
//
//  Created by Mehmet Nafi ISLEK on 3.06.2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    //MARK: Variables
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //scene delegate içinde kullanıcı tanımlıysa direk feedde çalıştır işlemi var...
    }
    
    //MARK: Button Processes
    
    //MARK: SignIn Button
    @IBAction func singInClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    //self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if(emailText.text != "" && passwordText.text != "" ) {
            
            Auth.auth().createUser(withEmail: emailText.text! , password: passwordText.text!) { (authdata , error) in //firabase de kullanıcı oluşturuyoruz auth firebase kullanıcı işlemleri yapmaya yarar türkçesi yetki demektir.
                
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error") // ?errordan firebase den bir hata mesajı gelmezse sistem localized error vermezse ?? error de
                }else {
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            
            makeAlert(titleInput: "Error", messageInput: "username/password")
        }
    }
    

    
    //MARK: Alert Function
    func makeAlert(titleInput: String , messageInput: String) {
        let alert  = UIAlertController(title: titleInput , message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}


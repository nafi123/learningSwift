//
//  UploadViewController.swift
//  InstaCloneFirebase
//
//  Created by Mehmet Nafi ISLEK on 5.06.2021.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer) //image e dokunulmasının ayarlanması
    }
    //dokununca galeri açılması olayı ve fotoğraf seçmek
    
    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    //kullanıcı bunu seçince ne olacak...
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeAlert(titleInput: String , messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media") //storage referans veriyoruz ama onun altında bulunan media klasörüne gidiyoruz .child.child gibi diyip medianın içinede gidebilirdik
        
        // Resmi dataya çevirip kaydetmemiz gerekiyor. Bunun içinde aşağıdaki kodu yazıp yarısı kadar 0.5 kadar
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg") //yukarda oluşturulmuş olan media klasörürünün içindeki foto bu şekilde kaydedilecek firebasee
            
            imageReference.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")
                } else {
                    
                    //image ın url sini alacaz bu şekilde
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            //DATABASE
                            
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl": imageUrl!,"postedBy" : Auth.auth().currentUser!.email!,"postComment" : self.commentText.text!,"date":FieldValue.serverTimestamp(),"likes": 0 ] as [String : Any]
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil {
                                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                                }else {
                                    
                                    //yükledikten sonra default olarak ayarladığımız hali gelsin diye...
                                    self.imageView.image = UIImage(named: "tapme")
                                    self.commentText.text = ""
                                    
                                    self.tabBarController?.selectedIndex = 0  //feed  upload settting tab bar contoller kısmı 0 ile feed e götürüyor
                                }
                            })
                        }
                    }
                }
            }
        }
    }
}

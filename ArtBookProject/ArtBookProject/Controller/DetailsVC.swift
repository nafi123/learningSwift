//
//  DetailsVC.swift
//  ArtBookProject
//
//  Created by Mehmet Nafi ISLEK on 15.05.2021.
//

import UIKit
import CoreData

class DetailsVC: UIViewController {
    //MARK: variables
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var chosenPainting = ""
    var chosenPaintingid: UUID?
    
    //MARK: lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if chosenPainting != "" {
            //saveButton.isEnabled = false //şeffaf tıklanamaz
            saveButton.isHidden = true //komple görünmez
            //core data
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = chosenPaintingid?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let name = result.value(forKey: "name") as? String {
                            nameText.text = name
                        }
                        if let artist = result.value(forKey: "artist") as? String {
                            artistText.text = artist
                        }
                        if let year = result.value(forKey: "year") as? Int {
                            yearText.text = String(year)
                        }
                        if let imageData = result.value(forKey: "image") as? Data {
                            let image = UIImage(data: imageData)
                            imageView.image = image
                        }
                    }
                }
            }catch{
                
            }
        }else {
            saveButton.isHidden = false
            saveButton.isEnabled = false
        }
        
        //MARK: recognizer
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)) //hareket algılayıcısı
        
        imageView.isUserInteractionEnabled = true
        view.addGestureRecognizer(gestureRecognizer) //görünümün kendisine çünkü nereye tıklarsa kapansın
        
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
    }
    
    // MARK: functions
    @IBAction func saveButtonClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate //appdelegate sınıfını aldık içindeki kütüphaneleri kullanmak için
        let context = appDelegate.persistentContainer.viewContext //dataları yönetmek için gerekli şeyler
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        //MARK: Attributes
        
        newPainting.setValue(nameText.text!, forKey: "name")
        newPainting.setValue(artistText.text!, forKey: "artist")
        
        if let year = Int(yearText.text!){
            newPainting.setValue(year, forKey: "year")
        }
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("success")
        }catch {
            print("error")
        }
        //notificationcenter yeni data geldi diyince new data diye mesaj gelince yapılacak işlem mesela kaydedince mesaj gönderiyor viewcontrollerlar arasında mesajlaşıyor
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
}
//MARK: Extension
extension DetailsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: ObjcFunctions
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary //cameramı photolibrary mi
        picker.allowsEditing = true //zoomlayabilir vs
        present(picker, animated: true, completion: nil) //alertmesajıgibisine
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: PickerControler
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        saveButton.isEnabled = true //tıklanabilir
        self.dismiss(animated: true, completion: nil)
    }
}


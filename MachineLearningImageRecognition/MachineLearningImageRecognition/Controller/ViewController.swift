//
//  ViewController.swift
//  MachineLearningImageRecognition
//
//  Created by Mehmet Nafi ISLEK on 28.06.2021.
//

import UIKit
import CoreML
import Vision // image recognizer için özellikle kullanılan yardımcı kütüphane

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    var chosenImage = CIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
   
    @IBAction func changeClicked(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }
    //kullanıcı resmi bir kere seçtikten sonra ne yapacağını seçiyoruz
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
         //CIImage görsel yapısı bekliyor modelimiz core image tarafından kullanılacak
        if let ciImage = CIImage(image: imageView.image!) {
            chosenImage = ciImage
        }
        recognizeImage(image: chosenImage)
        
    }
    
    func recognizeImage(image: CIImage) {
        //1) Request oluşturacaz
        //2) Handler bu requesti handle edecez yani ele alacaz
        // istek oluşturacaz ve bu isteğimizi ele alacaz
        // model oluşturduk ve bu modeli mobilenetv2 modeline verdik
        if let model = try?  VNCoreMLModel(for: MobileNetV2().model) {
            let request = VNCoreMLRequest(model: model) { vnrequest, error in
                // görsel analizin isteğinin sonucunda üretilen sınıflandırmayı alıyoruz
                if let results = vnrequest.results as? [VNClassificationObservation] {
                    if results.count > 0 {
                        let topResult = results.first
                        DispatchQueue.main.async {
                            
                            let confidenceLevel = (topResult?.confidence ?? 0 ) * 100
                            
                            let rounded = Int (confidenceLevel * 100) / 100

                            self.resultLabel.text = "\(rounded)% \(topResult?.identifier)"
                        }
                    }
                }
                
            }
            let handler = VNImageRequestHandler(ciImage: image)
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                   try  handler.perform([request])
                }catch {
                    print("error")
                }
                
            }
        }
        
        
    }

}


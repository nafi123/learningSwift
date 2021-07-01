//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Mehmet Nafi ISLEK on 24.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: labels
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //MARK: Button
    @IBAction func getRatesClicked(_ sender: Any) {
        // 1) Request & Session = internetten web adresine gitmek istek yollamak
        // 2) Response & Data = datayı almak isteği almak
        // 3) Parsing & JSON Serialization = bu datayı işlemek
        
        //1)
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=223b49262c3f76a2b29c909f3fb57457")
        let session = URLSession.shared //url sessionun bir objesi oluşturulacak shared.data task ile direk istek başlatılabilir ama yapmıyoruz çünkü "complitionhandler" input veriyoruz karşısında output verecek
        
        //Closure = değişkenleri atarsan bu kod bloğun içinde kullanabilirsin
        let task = session.dataTask(with: url!) { (data, response, error) in //url sessiondan geliyor
            if error != nil {
                
                let alert = UIAlertController(title: "error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert) //localizedDescription kullanıcının anlayacağı dilden bir hata internet bulunamadı gibi
                let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil) //ekranda göster
            }else {
                //2)
                //data?.isEmpty
                if let newData = data {
                
                   // JSONSerialization //bu jsonu alıp objelere tek tek oluşturabileceğiniz sınıf
                    do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: newData, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
                        //aynı threadde yapamıyorz kullanıcı arayüüzünü kitleyebilir progrmaı çökertebilir
                        DispatchQueue.main.async {
                            
                            if let rates = jsonResponse?["rates"] as? [String : Any] {
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                if let turk = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(turk)"
                                }
                            }
                        }
                    } catch {
                        print("error")
                    }
                }
            }
        }
        task.resume()
    }
    

}


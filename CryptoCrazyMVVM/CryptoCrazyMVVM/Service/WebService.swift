//
//  WebService.swift
//  CryptoCrazyMVVM
//
//  Created by Mehmet Nafi ISLEK on 3.07.2021.
//

import Foundation

class Webservice {
    //veriyi indirdikten sonra sonucunu döndürülmesi isteniyorsa @escaping kullanılıyor.
    func dowloadCurrencies(url: URL, completion: @escaping ([CryptoCurrency]) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let error = error {
                
                print(error.localizedDescription)
                let emptyArray : [CryptoCurrency] = []
                completion(emptyArray)
                
            } else if let data = data {
                
               let cryptoList = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
                
                if let cryptoList = cryptoList {
                    completion(cryptoList)
                }
            }
        }.resume()
    }
}

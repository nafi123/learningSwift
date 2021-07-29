//
//  CryptoCurrency.swift
//  CryptoCrazyMVVM
//
//  Created by Mehmet Nafi ISLEK on 4.07.2021.
//

import Foundation

struct CryptoViewModel {
    let cryptCurrency : CryptoCurrency
}

extension CryptoViewModel {
    
    var name : String {
        return self.cryptCurrency.currency
    }
    var price: String {
        return self.cryptCurrency.price
    }
}

//
//  CryptoViewModel.swift
//  CryptoCrazyMVVM
//
//  Created by Mehmet Nafi ISLEK on 3.07.2021.
//

import Foundation

struct CryptoListViewModel {
    let cryptoCurrencyList : [CryptoCurrency]
}

extension CryptoListViewModel {
    func numberOfRowsInSection() -> Int {
        return self.cryptoCurrencyList.count
    }
    
    func cryptoAtIndex(_ index:Int) -> CryptoViewModel {
        let crypto = self.cryptoCurrencyList[index]
        return CryptoViewModel(cryptCurrency: crypto)
    }
}



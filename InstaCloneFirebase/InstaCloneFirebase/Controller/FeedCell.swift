//
//  FeedCell.swift
//  InstaCloneFirebase
//
//  Created by Mehmet Nafi ISLEK on 25.06.2021.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {
    
    //MARK: Variables
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var documentIdLabel: UILabel! // hangi postun like butonuna basıldığını anlamak için oluşturduk ve kullanıcı bunu görmüyor...
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
        
        let fireStoreDatabase = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!) {
            
            let likeStore = ["likes": likeCount + 1 ] as [String : Any]
            
            fireStoreDatabase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true) //.setdata da merge var sadece verileni güncelle geri kalana dokunma demek oluyor yani data zaten yukarısında tanımlandı likeStore onu güncelle fakat diğerlerine karışma...
        }
    }
}

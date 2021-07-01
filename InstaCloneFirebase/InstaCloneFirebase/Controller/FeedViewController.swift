//
//  FeedViewController.swift
//  InstaCloneFirebase
//
//  Created by Mehmet Nafi ISLEK on 5.06.2021.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController   {
    @IBOutlet weak var tableView: UITableView!
    //MARK: Data Array
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentIdArray = [String]()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFirestore()
        
    }
    //MARK: Get Data Function
    func getDataFromFirestore() {
        let fireStoreDatabase = Firestore.firestore()
        
        // ne kadar derine inmek istiyorsak o kadar işte .document sonra .collection falan diyip derine inip sonra addSnapShotListener denebilirdi
        
        fireStoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in //tarihe göre azalarak görünmesi olayı
            if error != nil {
                print(error?.localizedDescription ?? "error")
                
            }else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    // altalta aynı şeyi göstermesin diye for looptan önce
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.documentIdArray.append(documentID) //kullanıcıya göstermeden documentıd yi feedcell de tanımlanan bir labeldan okuyacaz...
                        
                        //eğer postedBy ı string olarak alabilirsem...
                        if let postedBy = document.get("postedBy") as? String {
                            self.userEmailArray.append(postedBy) // postedBy arrayıne ekle
                        }
                        if let postComment = document.get("postComment") as? String {
                            self.userCommentArray.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int {
                            self.likeArray.append(likes)
                        }
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.userImageArray.append(imageUrl)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension FeedViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count //user emailArray ı kadar row oluşturacak döndürecek
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row])) //https://github.com/SDWebImage/SDWebImage burdaki linki podfile ın içine eklersek ve terminalden projeyi açıp podfile install dersek bu kütüphaneye erişebiliyoruz bu bize resmi url olarak alıp indirip göstermemizi sağlıyor...
        cell.documentIdLabel.text = documentIdArray[indexPath.row]
        return cell
    }
}

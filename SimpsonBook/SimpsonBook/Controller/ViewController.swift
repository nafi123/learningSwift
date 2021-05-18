//
//  ViewController.swift
//  SimpsonBook
//
//  Created by Mehmet Nafi ISLEK on 14.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Variables
    @IBOutlet weak var tableView: UITableView!
    var chosenSimpson : Simpson?
    var mySimpson = [Simpson]()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        //MARK: Simpson Object
        let homer = Simpson(simpsonName: "Homer Simpson", simpsonJob: "Nuclear Safety", simpsonImage: UIImage(named: "homer")!)
        let marge = Simpson(simpsonName: "Marge Simpson", simpsonJob: "House Wife", simpsonImage: UIImage(named: "marge")!)
        let bart = Simpson(simpsonName: "Bart Simpson", simpsonJob: "Student", simpsonImage: UIImage(named: "bart")!)
        let lisa = Simpson(simpsonName: "Lisa Simpson", simpsonJob: "Student", simpsonImage: UIImage(named: "lisa")!)
        let maggie = Simpson(simpsonName: "Maggie Simpson", simpsonJob: "Baby", simpsonImage: UIImage(named: "maggie")!)
        
        //MARK: Array append
        mySimpson.append(homer)
        mySimpson.append(marge)
        mySimpson.append(bart)
        mySimpson.append(lisa)
        mySimpson.append(maggie)
    }
}

//MARK: Extension
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySimpson.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = mySimpson[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSimpson = mySimpson[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! detailsVC
            destinationVC.selectedSimpson = chosenSimpson
        }
    }
}

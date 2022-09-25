//
//  BookVC.swift
//  Bookworm
//
//  Created by Dipak Amreliya  on 30/04/22.
//

import UIKit

class BookVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var arrBookName = ["Alice's Adventures in Wonderland by Lewis Caroll", "An Introduction to Agriculture", "Basics Of HTML5", "DotNETFramework Professionals", "Einstein's Dreams by Alan Lightman ", "Geography of the US by the Core Knowledge Foundation", "JavaScript for Web Development", "Practical Web Scraping", "Python Programming", "The Metamorphosis by Franz Kafka"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tblView.reloadData()
    }

}

extension BookVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBookName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : Book_Cell = tblView.dequeueReusableCell(withIdentifier: "Book_Cell", for: indexPath) as! Book_Cell
        
        if let path = Bundle.main.path(forResource: "\(arrBookName[indexPath.row])", ofType: "pdf") {
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.black.cgColor
            cell.imgBook.image = drawPDFfromURL(url: URL(fileURLWithPath: path))
            cell.lblName.text = arrBookName[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReadBookVC") as! ReadBookVC
        vc.strBookName = arrBookName[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

//
//  HomeVC.swift
//  Bookworm
//
//  Created by Dipak Amreliya  on 30/04/22.
//

import UIKit
import CoreData

var msg = ""

class HomeVC: UIViewController {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblStdID: UILabel!
    
    @IBOutlet weak var imgUSer: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchUserData()
        self.imgUSer.layer.cornerRadius = 25
    }
    
    func fetchUserData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<UserData>(entityName: "UserData")
            
        do {
            let arrUserData = try context.fetch(fetchRequest)
            self.lblUserName.text = arrUserData[arrUserData.count-1].name
            self.lblStdID.text = arrUserData[arrUserData.count-1].studentID
            if let imageData = arrUserData[arrUserData.count-1].profileimg as? NSData {
                if let image = UIImage(data:imageData as Data) {
                    imgUSer.image = image
                }
            }
        } catch {
            print("")
        }
    }
    
    @IBAction func btnLogoutAction(_ sender: UIButton) {
        gotoLoginVC()
    }
}

//
//  WishListVC.swift
//  Bookworm
//
//  Created by Dipak Amreliya  on 30/04/22.
//

import UIKit
import CoreData

class WishListVC: UIViewController {

   
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtAuthorName: UITextField!
    
    @IBOutlet weak var tblView: UITableView!
    
    var arrWishData = [WishData]()
    var isEdit = false
    
    var model: WishData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchList()
        isEdit = false
    }

    @IBAction func btnSubmitAction(_ sender: Any) {
        if let text = txtTitle.text , text.isEmpty {
            self.view.makeToast("Please enter title")
        } else if let text = txtAuthorName.text , text.isEmpty {
            self.view.makeToast("Please enter author name")
        } else {
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            if (isEdit), let model = model{
                self.isEdit = false
                let task: WishData!

                let fetchUser: NSFetchRequest<WishData> = WishData.fetchRequest()
                fetchUser.predicate = NSPredicate(format: "id = %@", model.id! as CVarArg)

                let results = try? context.fetch(fetchUser)
                if results?.count == 0 {
//                   task = ModelTransactions(context: context)
                } else {
                    task = results?.first
                    task.authTitle = txtTitle.text ?? ""
                    task.authName = txtAuthorName.text ?? ""
                    
                    appDelegate.saveContext()
                    self.view.makeToast("Updated successfully")
                    fetchList()
                }
            }else{
                let WishDict = WishData(context: context)
                WishDict.id = UUID()
                WishDict.studentID = stdId
                WishDict.authTitle = self.txtTitle.text ?? ""
                WishDict.authName = self.txtAuthorName.text ?? ""
                appDelegate.saveContext()
                self.txtTitle.text = ""
                self.txtAuthorName.text = ""
                fetchList()
            }
        }
    }
    
    func fetchList() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<WishData>(entityName: "WishData")
            
        do {
            arrWishData = try context.fetch(fetchRequest)
            self.tblView.reloadData()
        } catch {
            print("")
        }
    }
}

extension WishListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrWishData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "WishList_Cell", for: indexPath) as! WishList_Cell
        
        if arrWishData.count > 0{
            cell.viewBack.layer.borderColor = UIColor.black.cgColor
            cell.viewBack.layer.borderWidth = 1
            cell.lblTitle?.text = "Title : \(arrWishData[indexPath.row].authTitle ?? "")"
            cell.lblAuthName?.text = "Author Name : \(arrWishData[indexPath.row].authName ?? "")"
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView,
//                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//    {
//        let updateAction = UIContextualAction(style: .normal, title:  "Update", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//            print("Update action ...")
//            success(true)
//            self.isEdit = true
//            self.txtTitle.text = self.arrWishData[indexPath.row].authTitle
//            self.txtAuthorName.text = self.arrWishData[indexPath.row].authName
//            self.model = self.arrWishData[indexPath.row]
//        })
//        updateAction.image = UIImage(systemName: "pencil")
//        updateAction.backgroundColor = .systemBlue
//
//        let removeAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//            print("Remove action ...")
//            success(true)
//            let alert = UIAlertController(title: "Info", message: "Are you sure you want delete this Author Name?", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
//            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {_ in
//
//                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//                let context = appDelegate.persistentContainer.viewContext
//
//                let task: WishData!
//
//                let fetchUser: NSFetchRequest<WishData> = WishData.fetchRequest()
//                fetchUser.predicate = NSPredicate(format: "id = %@", self.arrWishData[indexPath.row].id! as CVarArg)
//
//                let results = try? context.fetch(fetchUser)
//                if results?.count == 0 {
//                } else {
//                    task = results?.first
//                    context.delete(task)
//                    appDelegate.saveContext()
//                    self.view.makeToast("Wish List deleted successfully")
//                    self.fetchList()
//                }
//            }))
//            self.present(alert, animated: true, completion: nil)
//
//        })
//        removeAction.image = UIImage(systemName: "trash")
//        removeAction.backgroundColor = .red
//
//        return UISwipeActionsConfiguration(actions: [removeAction, updateAction])
//    }
}

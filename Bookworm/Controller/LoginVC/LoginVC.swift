//
//  LoginVC.swift
//  Bookworm
//
//  Created by Dipak Amreliya  on 30/04/22.
//

import UIKit
import CoreData

class LoginVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtStdID: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var contraint_center: NSLayoutConstraint!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var contraint_Top: NSLayoutConstraint!
    @IBOutlet weak var contraint_Height: NSLayoutConstraint!
    
    // MARK: - Variable Declaration
    
    var arrUesrData = [UserData]()
    var isShowBack = false
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isShowBack = false
        showUsername()
    }
    
    func showUsername() {
        if isShowBack{
            btnBack.isHidden = false
            txtUserName.isHidden = false
            contraint_Height.constant = 50
            contraint_Top.constant = 30
            btnCreate.isHidden = true
            imgUser.isHidden = false
            btnProfile.isHidden = false
            contraint_center.constant = -10
        }else{
            btnBack.isHidden = true
            txtUserName.isHidden = true
            contraint_Height.constant = 0
            contraint_Top.constant = 0
            btnCreate.isHidden = false
            imgUser.isHidden = true
            btnProfile.isHidden = true
            contraint_center.constant = -60
        }
    }
    
    func fetchUserData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<UserData>(entityName: "UserData")
            
        do {
            self.arrUesrData = try context.fetch(fetchRequest)
        } catch {
            print("")
        }
    }

    // MARK: - Button Actions
    @IBAction func btnProfileAction(_ sender: Any) {
        ImagePickerManager().pickImage(self){ image in
            self.imgUser.image = image
        }
    }
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        view.endEditing(true)
        if isShowBack{
            if let text = txtUserName.text , text.isEmpty {
                self.view.makeToast("Please enter username")
            } else if let text = txtStdID.text , text.isEmpty {
                self.view.makeToast("Please enter student id")
            } else if let text = txtPassword.text , text.isEmpty {
                self.view.makeToast("Please enter password")
            }else if imgUser.image == UIImage(named: "user"){
                self.view.makeToast("Please Select image")
            } else {
                addRecord()
            }
        }else{
            if let text = txtStdID.text , text.isEmpty {
                self.view.makeToast("Please enter student id")
            } else if let text = txtPassword.text , text.isEmpty {
                self.view.makeToast("Please enter password")
            } else {
                if arrUesrData.count > 0{
                    if arrUesrData.contains(where: {$0.studentID == txtStdID.text ?? ""}){
                        self.gotoTabbarVC()
                    }else{
                        self.view.makeToast("Please create account after login")
                    }
                }else{
                    self.view.makeToast("Please create account after login")
                }
            }
        }
    }
    
    @IBAction func btnCreateAction(_ sender: UIButton) {
        isShowBack = true
        showUsername()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        isShowBack = false
        showUsername()
    }
    
    func addRecord() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let UserDict = UserData(context: context)
        
        let imgData = imgUser.image!.jpegData(compressionQuality: 0.7)
        
        UserDict.id = UUID()
        UserDict.name = txtUserName.text ?? ""
        UserDict.studentID = txtStdID.text ?? ""
        UserDict.password = txtPassword.text ?? ""
        UserDict.profileimg = imgData
        
        appDelegate.saveContext()
        
        self.gotoTabbarVC()
    }
}

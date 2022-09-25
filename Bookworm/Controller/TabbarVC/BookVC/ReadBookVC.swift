//
//  ReadBookVC.swift
//  Bookworm
//
//  Created by Dipak Amreliya  on 30/04/22.
//

import UIKit
import WebKit

class ReadBookVC: UIViewController {

    @IBOutlet weak var viewRating: UIView!
    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var navigatioBar: UINavigationBar!
    
    var strBookName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.viewRating.isHidden = true
        self.navigatioBar.topItem?.title = self.strBookName
        if let pdfURL = Bundle.main.url(forResource: strBookName, withExtension: "pdf", subdirectory: nil, localization: nil)  {
            do {
                let data = try Data(contentsOf: pdfURL)
                webview.load(data, mimeType: "application/pdf", characterEncodingName:"", baseURL: pdfURL.deletingLastPathComponent())
            }catch {
                // catch errors here
            }
        }
    }
    
    @IBAction func barbtnCloseAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnRatingAction(_ sender: Any) {
        self.viewRating.isHidden = false
        
    }
    @IBAction func btnSubmitRateAction(_ sender: UIButton) {
        self.viewRating.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
}

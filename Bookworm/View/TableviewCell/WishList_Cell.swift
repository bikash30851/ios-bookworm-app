//
//  WishList_Cell.swift
//  Bookworm
//
//  Created by Dipak Amreliya  on 30/04/22.
//

import UIKit

class WishList_Cell: UITableViewCell {

    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

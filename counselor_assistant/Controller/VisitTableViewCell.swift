//
//  VisitTableViewCell.swift
//  Pods
//
//  Created by Albert on 2021/10/15.
//

import UIKit

class VisitTableViewCell: UITableViewCell {

    @IBOutlet var initials: UILabel!
    @IBOutlet var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

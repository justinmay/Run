//
//  CustomTabelTableViewCell.swift
//  Run
//
//  Created by Justin May on 5/11/18.
//  Copyright © 2018 Justin May. All rights reserved.
//

import UIKit

class CustomTabelTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var textFieldtemplate: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

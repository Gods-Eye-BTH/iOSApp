//
//  ConnectionCell.swift
//  InidiProjekt
//
//  Created by Erik Westerberg on 2018-10-22.
//  Copyright © 2018 Erik Westerberg. All rights reserved.
//

import UIKit

class ConnectionCell: UITableViewCell {

    
    @IBOutlet weak var urlButton: UIButton!
    @IBOutlet weak var trashButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

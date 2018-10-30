//
//  RobotCell.swift
//  InidiProjekt
//
//  Created by Erik Westerberg on 2018-10-15.
//  Copyright © 2018 Erik Westerberg. All rights reserved.
//

import UIKit

class RobotCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var heigthLabel: UILabel!
    @IBOutlet weak var idButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

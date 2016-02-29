//
//  ResultTableViewCell.swift
//  SieveOfEratosthenes
//
//  Created by Mark Lin on 2/28/16.
//  Copyright © 2016 marklinapp. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
  @IBOutlet weak var numberLabel: UILabel!

  @IBOutlet weak var statusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

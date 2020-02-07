//
//  ChecklistTableViewCell.swift
//  CheckList
//
//  Created by Qadriyyah Griffin on 1/29/20.
//  Copyright © 2020 Qadriyyah Thomas. All rights reserved.
//

import UIKit

class ChecklistTableViewCell: UITableViewCell {

  @IBOutlet weak var checkmarkLabel: UILabel!
  @IBOutlet weak var todoTextLabel: UILabel!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

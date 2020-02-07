//
//  ChecklistItem.swift
//  CheckList
//
//  Created by Qadriyyah Griffin on 1/21/20.
//  Copyright © 2020 Qadriyyah Thomas. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
  @objc var text = ""
  var checked = false
  
  func toggleChecked() {
    checked = !checked
  }
  
}

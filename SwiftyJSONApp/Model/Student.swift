//
//  Student.swift
//  SwiftyJSONApp
//
//  Created by Francesca Valeria Haro Dávila on 1/14/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import UIKit
import SwiftyJSON
import UIKit

class Student: NSObject {

  var name = ""
  var id = 0
  
  init(jsonObject: JSON) {
    
    if let name = jsonObject["name"].string {
      self.name = name
    }
    if let id = jsonObject["id"].int {
      self.id = id
    }
  }

  
}

//
//  StudentManager.swift
//  CoreDataCRUD
//
//  Created by Francesca Valeria Haro Dávila on 1/11/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class StudentManager {
  
  private var handler: RequestHandler!
  init(requestHandler: RequestHandler) {
    self.handler = requestHandler
  }
  
  func listStudentsRequest() {
    
    var request = URLRequest(url: URL(string: "http://www.mocky.io/v2/5c38cad03100002b00a99230")!)
    request.httpMethod = "GET"

    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    handler.makeRequest(request, completion: { result in
      switch result {
    case .success(let data):

      guard let json = try? JSON(data: data) else {
        return
      }
      let text = json[0]["name"]
      print(text)

    case .failure( _):
      print("ERROR")
      }
    })
  }
}



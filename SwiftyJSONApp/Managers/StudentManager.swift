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
  
  func listStudentsRequest(completionHandler: @escaping (_ students: [Student]) -> ()) {
    
    var allStudents: [Student] = []
    var request = URLRequest(url: URL(string: "http://192.168.0.47:3000/api/v1/tasks")!)
    request.httpMethod = "GET"
    
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    
//    let url = "http://192.168.0.47:3000/api/v1/tasks"
//    Alamofire.request(url , method: .get, parameters: nil, encoding: nil, headers: nil)
    
    
    handler.makeRequest(request, completion: { result in
      switch result {
      case .success(let data):
        
        if let json = try? JSON(data: data) {
          for (_, object) in json {
            let studentObject = Student(jsonObject: object)
            allStudents.append(studentObject)
          }
          completionHandler(allStudents)
          print(json[0]["name"])
        }
        
      case .failure( _):
        print("ERROR")
      }
      
    })
  }
  
  
}


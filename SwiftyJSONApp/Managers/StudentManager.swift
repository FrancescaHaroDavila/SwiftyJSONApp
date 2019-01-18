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
  

  var request = URLRequest(url: URL(string: "http://192.168.0.47:3000/api/v1/tasks")!)
  
  func listStudentsRequest(completionHandler: @escaping (_ students: [Student]) -> ()) {
    var allStudents: [Student] = []
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
   
    handler.makeRequest(request, completion: { result in
      switch result {
      case .success(let data):
        if let json = try? JSON(data: data) {
          for (_, object) in json {
            
            let studentObject = Student(jsonObject: object)
            allStudents.append(studentObject)
          }
          completionHandler(allStudents)
          print("arregloL:\(allStudents.count)")
        }
      case .failure( _):
        print("ERROR")
      }
      
    })
  }

  
  func addStudent(name: String, completionHandler: @escaping (_ students: [Student]) -> ()) {
    let allStudents: [Student] = []
    let url = "http://192.168.0.47:3000/api/v1/tasks"
    let parameters = [ "name" : name  ]
    
    Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { result in
   
    }
    completionHandler(allStudents)
    
  }
  
  func deleteStudent(id: String, completionHandler: @escaping () ->()) {
    let url = "http://192.168.0.47:3000/api/v1/tasks/" + id
    
    Alamofire.request(url, method: .delete).response { response in
      if response.error == nil {
        completionHandler()
      } else {
        print(response.error)
      }
      
    }

  }
  
}
  


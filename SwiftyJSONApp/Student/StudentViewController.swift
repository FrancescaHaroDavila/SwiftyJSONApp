//
//  ViewController.swift
//  CoreDataCRUD
//
//  Created by Francesca Valeria Haro Dávila on 1/9/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import UIKit


class StudentViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var allStudents: [Student] = []
    var identifierStudentManager = StudentManager(requestHandler: AlamofireClient())
  
  @IBAction func addName(_ sender: Any) {
    
    
  }
  
  @IBAction func deleteById(_ sender: Any) {
    
  }
  
  override func viewDidLoad() {
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    super.viewDidLoad()
    self.identifierStudentManager.listStudentsRequest() { students in
        self.allStudents = students
        self.tableView.reloadData()
    }
  }
  
}

extension StudentViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allStudents.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let person = allStudents[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = person.name
    return cell
  }
  
  
}


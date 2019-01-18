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
  
  var studentsAll: [Student] = []
  var identifierStudentManager = StudentManager(requestHandler: AlamofireClient())
  
  @IBAction func addName(_ sender: Any) {
    
    let alert = UIAlertController(title: "New Student", message: "Add a new student", preferredStyle: .alert)
    
    alert.addTextField(configurationHandler: { (textFieldName) in textFieldName.placeholder = "name" })
    
    let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
      
      guard let textField = alert.textFields?.first,
        let nameToSave = textField.text else {
          return
      }
      
      self.identifierStudentManager.addStudent(name: nameToSave) { students in
        self.studentsAll = students
        self.tableView.reloadData()
      }
      
      self.identifierStudentManager.listStudentsRequest() { students in
        self.studentsAll = students
        self.tableView.reloadData()
      }

    }
    
 
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .default)
    
    alert.addAction(cancelAction)
    alert.addAction(saveAction)
    present(alert, animated: true)
  }
  
  
  @IBAction func deleteById(_ sender: Any) {
    
    let alert = UIAlertController(title: "Delete by ID", message: "Enter ID", preferredStyle: .alert)
    
    let deleteAction = UIAlertAction(title: "Delete", style: .default) { [unowned self] action in
      guard let textField = alert.textFields?.first ,
        let itemToDelete = textField.text else {
        return
      }
      
      self.identifierStudentManager.deleteStudent(id: itemToDelete ) { 
        self.identifierStudentManager.listStudentsRequest() { students in
          self.studentsAll = students
          self.tableView.reloadData()
        }
      }
      
      self.identifierStudentManager.listStudentsRequest() { students in
        self.studentsAll = students
        self.tableView.reloadData()
      }
    }
    
    let cancelAciton = UIAlertAction(title: "Cancel", style: .default)
    
    alert.addTextField()
    alert.addAction(deleteAction)
    alert.addAction(cancelAciton)
    
    present(alert, animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    super.viewDidLoad()
    self.identifierStudentManager.listStudentsRequest() { students in
      self.studentsAll = students
      self.tableView.reloadData()
    }
  }
  
}

extension StudentViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return studentsAll.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let person = studentsAll[indexPath.row]
    var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
    cell.textLabel?.text = person.name
    cell.detailTextLabel?.text = String(person.id)
    return cell
  }
  
  
}


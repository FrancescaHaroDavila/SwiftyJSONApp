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
      
      self.listStudents()

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
        self.listStudents()
      }
      
      self.listStudents()
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
    listStudents()
  }
  func listStudents(){
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
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?{
    
    let person = studentsAll[indexPath.row]
    
    let alert = UIAlertController(title: "Update Name",
                                  message: "Update Name",
                                  preferredStyle: .alert)
    
    alert.addTextField(configurationHandler: { (textFieldName) in
      
      textFieldName.placeholder = "name"
      
      textFieldName.text = person.name
      
    })
    
    let editAction = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
      
      let updateAction = UIAlertAction(title: "Update", style: .default) { [unowned self] action in
        
        guard let textField = alert.textFields?[0],
          let nameToSave = textField.text else {
            return
        }
        
        self.identifierStudentManager.updateStudent(id: String(person.id), name: nameToSave){ students in
          self.studentsAll = students
          self.listStudents()
        }
        self.listStudents()
        self.tableView.reloadData()
        
      }
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .default)
      
      alert.addAction(cancelAction)
      alert.addAction(updateAction)
      
      self.present(alert, animated: true)
      
    }
    
    let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
      // delete item at indexPath
      self.identifierStudentManager.deleteStudent(id: String(person.id)){
        self.listStudents()
      }
      self.studentsAll.remove(at: (self.studentsAll.index(of: person))!)
      
      self.tableView.reloadData()
    }
    
    editAction.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    deleteAction.backgroundColor = #colorLiteral(red: 0.6138959391, green: 0.09183319133, blue: 0.005303928019, alpha: 1)
    
    return [editAction, deleteAction]
    
  }
  
}


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
  
  var people: [Student] = []
  var identifierStudentManager = StudentManager(requestHandler: AlamofireClient())
  
  @IBAction func addName(_ sender: Any) {

    
  }
  
  @IBAction func deleteById(_ sender: Any) {
    
}
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    identifierStudentManager.listStudentsRequest()
  }
 
}

extension StudentViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return people.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let person = people[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                             for: indexPath)
    cell.textLabel?.text = person.value(forKeyPath: "name") as? String
    return cell
  }
  

}


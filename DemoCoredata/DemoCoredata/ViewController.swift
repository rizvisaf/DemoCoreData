//
//  ViewController.swift
//  DemoCoredata
//
//  Created by Abdul Hameed Mohamed Rizvi on 11/21/18.
//  Copyright © 2018 Abdul Hameed Mohamed Rizvi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var departmenttableView: UITableView!
    var departmentArray = [Departments]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.departmenttableView.delegate = self
        self.departmenttableView.dataSource = self
        
        self.context = self.appDelegate.managedObjectContext
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Departments")
        let sort = NSSortDescriptor(key: "dep_id", ascending: true)
        request.sortDescriptors = [sort]
        do {
            let result = try self.context?.fetch(request)
            if result?.count != 0 {
                self.departmentArray = result! as! [Departments]
                self.departmenttableView.reloadData()
            }
        } catch {
          
        }
    }


    @IBAction func AddDepartmentView(_ sender: Any) {
        let addDepartmentView = self.storyboard?.instantiateViewController(withIdentifier: "AddDepartment") as? AddDepartment
        self.navigationController?.pushViewController(addDepartmentView!, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.departmentArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.departmenttableView.register(UINib(nibName: "DepartmentTableCell", bundle: nil), forCellReuseIdentifier: "DepartmentTableCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepartmentTableCell") as! DepartmentTableCell
        let singleDepartment = self.departmentArray[indexPath.row]
        cell.departmentID.text = String(singleDepartment.dep_id)
        cell.departmentName.text = singleDepartment.dep_name
        cell.departmentDescription.text = singleDepartment.dep_description
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    
}

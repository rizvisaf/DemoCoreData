//
//  AddDepartment.swift
//  DemoCoredata
//
//  Created by Abdul Hameed Mohamed Rizvi on 11/21/18.
//  Copyright © 2018 Abdul Hameed Mohamed Rizvi. All rights reserved.
//

import UIKit
import CoreData

class AddDepartment: UIViewController {

    @IBOutlet weak var depName: UITextField!
    @IBOutlet weak var depDescription: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.context = self.appDelegate.managedObjectContext
    }
    
    @IBAction func AddDepartmetnAction(_ sender: Any) {
        let lastInsertedid = self.GetLastInsertedID()
        let newDepartment = Departments(context: self.context!)
        newDepartment.dep_id = lastInsertedid + 1
        newDepartment.dep_name = self.depName.text
        newDepartment.dep_description = self.depDescription.text
        
        let departmentAdded = self.appDelegate.saveContext()
        if departmentAdded {
            self.lblResult.text = "Department added"
            self.depName.text = ""
            self.depDescription.text = ""
        }else{
            self.lblResult.text = "Error When creating department"
        }
    }
    
    func GetLastInsertedID () -> Int16 {
        var returnID: Int16 = 0
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Departments")
        let sort = NSSortDescriptor(key: "dep_id", ascending: false)
        request.sortDescriptors = [sort]
        request.fetchLimit = 1
        do {
            let result = try self.context?.fetch(request)
            if result?.count != 0 {
                let dipResults = result! as! [Departments]
                returnID = Int16(dipResults[0].dep_id)
            }else{
                returnID = 0
            }
        } catch {
            returnID = 0
        }
        return returnID
    }

}

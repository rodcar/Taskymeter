//
//  AddTaskViewController.swift
//  Taskymeter1
//
//  Created by user155748 on 6/29/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {

    
    @IBOutlet weak var taskNameTextField: UITextField!
    
    @IBOutlet weak var taskDescriptionTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let name = self.taskNameTextField.text
        let description = self.taskDescriptionTextField.text
        
        if name == "" || description == "" {
            return
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        let newTask = NSManagedObject(entity: taskEntity!, insertInto: context)
        newTask.setValue(name!, forKey: "name")
        newTask.setValue(description!, forKey: "desc")
        newTask.setValue("To Do", forKey: "status")
        
        do {
            try context.save()
            self.dismiss(animated: true, completion: nil)
        } catch let error as NSError {
            print("\(error): \(error.userInfo)")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddTaskViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

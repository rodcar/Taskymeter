//
//  EdittaskViewController.swift
//  Taskymeter1
//
//  Created by user155748 on 6/29/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit
import CoreData

class EdittaskViewController: UIViewController {

    @IBOutlet weak var taskDescriptionTextField: UITextField!
    @IBOutlet weak var taskNameTextField: UITextField!
    
    var taskName: String = ""
    var taskDescription: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.taskNameTextField.text = self.taskName
        self.taskDescriptionTextField.text = self.taskDescription
    }

    @IBAction func inProcessButtonTapped(_ sender: Any) {
        updateTaskStatus("In Process")
    }
    
    @IBAction func completedButtonTapped(_ sender: Any) {
        updateTaskStatus("Completed")
    }
    
    func updateTaskStatus(_ status: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "name = %@", self.taskName)
        
        do {
            let results = try context.fetch(fetchRequest)
            let task = results[0] as! NSManagedObject
            task.setValue(status, forKey: "status")
            
            do {
                try context.save()
                self.navigationController?.popViewController(animated: true)
            } catch let error as NSError {
                print(error.userInfo)
            }
        } catch let error as NSError {
            print(error.userInfo)
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

extension EdittaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

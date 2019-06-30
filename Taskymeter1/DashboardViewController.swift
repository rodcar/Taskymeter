//
//  DashboardViewController.swift
//  Taskymeter1
//
//  Created by user155748 on 6/29/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit
import CoreData

class DashboardViewController: UIViewController {

    @IBOutlet weak var completedProgressView: UIProgressView!
    
    @IBOutlet weak var inProcessProgressView: UIProgressView!
    
    @IBOutlet weak var toDoProgressView: UIProgressView!
    
    var allTasksCount: Int = 0
    var todoTasksCount: Int = 0
    var completedTasksCount: Int = 0
    var inProcessTasksCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStats()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadStats()
    }
    
    func loadStats() {
        self.allTasksCount = countTasks(WithStatus: nil)
        self.todoTasksCount = countTasks(WithStatus: "To Do")
        self.completedTasksCount = countTasks(WithStatus: "Completed")
        self.inProcessTasksCount = countTasks(WithStatus: "In Process")
               toDoProgressView.setProgress(Float(self.todoTasksCount) / Float(self.allTasksCount), animated: true)
        completedProgressView.setProgress(Float(self.completedTasksCount) / Float(self.allTasksCount), animated: true)
        inProcessProgressView.setProgress(Float(self.inProcessTasksCount) / Float(self.allTasksCount), animated: true)
 
    }
    
    func countTasks(WithStatus status: String?) -> Int {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        if status != nil{
            fetchRequest.predicate = NSPredicate(format: "status = %@", status!)
        }
        
        do {
            return (try context.fetch(fetchRequest) as! [NSManagedObject]).count
        } catch let error as NSError {
            print(error.userInfo)
        }
        return 0
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

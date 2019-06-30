//
//  ViewController.swift
//  Taskymeter1
//
//  Created by user155748 on 6/29/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tasksTableView: UITableView!
    
    var tasks: [NSManagedObject] = [NSManagedObject]()
    var currentRow: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTasks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadTasks()
    }

    func loadTasks() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
            self.tasks = try context.fetch(fetchRequest) as! [NSManagedObject]
            self.tasksTableView.reloadData()
        } catch let error as NSError {
            print(error.userInfo)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskDetailSegue" {
            let destination = segue.destination as! EdittaskViewController
            destination.taskName = self.tasks[currentRow].value(forKey: "name") as! String
            destination.taskDescription = self.tasks[currentRow].value(forKey: "desc") as! String
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        let task = self.tasks[indexPath.row]
        cell.setTask(WithName: task.value(forKey: "name") as! String, WithDescription: task.value(forKey: "desc") as! String, WithStatus: task.value(forKey: "status") as! String)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRow = indexPath.row
        performSegue(withIdentifier: "showTaskDetailSegue", sender: self)
    }
}


//
//  ViewController.swift
//  bucketlist_client
//
//  Created by Erick Lui on 7/17/17.
//  Copyright © 2017 Erick Lui. All rights reserved.
//

import UIKit

class BucketListTableViewController: UITableViewController {
  
  var tasks = [NSDictionary]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    retrieveAllTasks()
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasks.count
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = tasks[indexPath.row]["objective"] as? String
    return cell
  }
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    performSegue(withIdentifier: "NewTaskSegue", sender: nil)
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
  @IBAction func unwindToBucketListVC(segue: UIStoryboardSegue) {
    let newTaskVC = segue.source as! NewTaskViewController
    let text = newTaskVC.taskLabel.text!
    addTask(text)
  }
  func retrieveAllTasks() {
    TaskModel.getAllTasks(completionHandler: {
      data, response, error in
      do {
        if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [NSDictionary] {
          self.tasks = jsonResult
        }
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      } catch {
        print(error)
      }
    })
  }
  func addTask(_ text: String) {
    TaskModel.addTaskWithObjective(objective: text, completionHandler: {
      data, response, error in
      do {
        if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [NSDictionary] {
          self.tasks = jsonResult
        }
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      } catch {
        print(error)
      }
    })
  }
}


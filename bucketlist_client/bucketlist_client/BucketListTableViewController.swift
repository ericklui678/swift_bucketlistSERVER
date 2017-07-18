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
    cell.accessoryType = .detailDisclosureButton
    cell.textLabel?.text = tasks[indexPath.row]["objective"] as? String
    return cell
  }
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    performSegue(withIdentifier: "NewTaskSegue", sender: indexPath.row)
  }
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    performSegue(withIdentifier: "NewTaskSegue", sender: nil)
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let index = sender as? Int {
      let nav = segue.destination as! UINavigationController
      let newTaskVC = nav.topViewController as! NewTaskViewController
      newTaskVC.text = tasks[index]["objective"] as? String
      newTaskVC.index = sender as! Int
    }
  }
  @IBAction func unwindToBucketListVC(segue: UIStoryboardSegue) {
    let newTaskVC = segue.source as! NewTaskViewController
    let text = newTaskVC.taskLabel.text!
    if newTaskVC.index == -1 {
      addTask(text)
    }
    else {
      updateTask(text, tasks[newTaskVC.index]["_id"] as! String)
      newTaskVC.index = -1
    }
  }
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    deleteTask(tasks[indexPath.row]["_id"] as! String)
    tasks.remove(at: indexPath.row)
    tableView.reloadData()
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
  func updateTask(_ text: String, _ index: String) {
    TaskModel.updateTask(objective: text, index: index, completionHandler: {
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
  func deleteTask(_ index: String) {
    TaskModel.deleteTask(index: index, completionHandler: {
      data, response, error in
      do {
        if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [NSDictionary] {
          self.tasks = jsonResult
        }
      } catch {
        print(error)
      }
    })
  }
}


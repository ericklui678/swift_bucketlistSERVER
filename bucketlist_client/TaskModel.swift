//
//  TaskModel.swift
//  bucketlist_client
//
//  Created by Erick Lui on 7/17/17.
//  Copyright © 2017 Erick Lui. All rights reserved.
//

import Foundation

class TaskModel {
  static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
    let url = URL(string: "http://localhost:8000/tasks")
    let session = URLSession.shared
    let task = session.dataTask(with: url!, completionHandler: completionHandler)
    task.resume()
  }
  static func addTaskWithObjective(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
    if let urlToReq = URL(string: "http://localhost:8000/tasks") {
      var request = URLRequest(url: urlToReq)
      request.httpMethod = "POST"
      let bodyData = "objective=\(objective)"
      request.httpBody = bodyData.data(using: .utf8)
      let session = URLSession.shared
      let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
      task.resume()
    }
  }
  static func updateTask(objective: String, index: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
    if let urlToReq = URL(string: "http://localhost:8000/tasks/" + String(index)) {
      var request = URLRequest(url: urlToReq)
      request.httpMethod = "POST"
      let bodyData = "objective=\(objective)"
      request.httpBody = bodyData.data(using: .utf8)
      let session = URLSession.shared
      let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
      task.resume()
    }
  }
  static func deleteTask(index: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
    if let urlToReq = URL(string: "http://localhost:8000/delete/" + String(index)) {
      var request = URLRequest(url: urlToReq)
      request.httpMethod = "POST"
      let session = URLSession.shared
      let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
      task.resume()
    }
  }
}

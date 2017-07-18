//
//  NewTaskViewController.swift
//  bucketlist_client
//
//  Created by Erick Lui on 7/17/17.
//  Copyright © 2017 Erick Lui. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {
  
  var text: String?
  var index = -1
  
  @IBOutlet weak var taskLabel: UITextField!
  
  @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    taskLabel?.text =  text
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

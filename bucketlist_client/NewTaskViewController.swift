//
//  NewTaskViewController.swift
//  bucketlist_client
//
//  Created by Erick Lui on 7/17/17.
//  Copyright © 2017 Erick Lui. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {

  @IBOutlet weak var taskLabel: UITextField!
  
  @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

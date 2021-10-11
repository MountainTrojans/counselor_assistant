//
//  AdminViewController.swift
//  counselor_assistant
//
//  Created by Zhenghao Dai on 10/10/21.
//

import UIKit

class AdminViewController: UIViewController {
    @IBOutlet weak var addAdminBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickAddAdminBtn(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Admin Email",
        message: "Enter the email",
        preferredStyle: .alert)
        alertController.addTextField { (textField) in
        textField.placeholder = "Email"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        print("Cancel action")
        }
        let okAction = UIAlertAction(title: "Submit", style: .default) { (action) in
            let textField = alertController.textFields![0]
        print("OK action")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}

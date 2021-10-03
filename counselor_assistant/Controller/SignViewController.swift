//  Created by Zhenghao Dai on 10/02/21.
//  Copyright © 2021 Zhenghao Dai. All rights reserved.
//

import UIKit
import GoogleSignIn

// [START viewcontroller_interfaces]
class SignViewController: UIViewController {
  // [END viewcontroller_interfaces]
  // [START viewcontroller_vars]

    @IBOutlet weak var signInButton: GIDSignInButton!
    
  // [END viewcontroller_vars]
  // [START viewdidload]
  override func viewDidLoad() {
    super.viewDidLoad()

    GIDSignIn.sharedInstance()?.presentingViewController = self

    // Automatically sign in the user.
    //GIDSignIn.sharedInstance()?.restorePreviousSignIn()

    // [START_EXCLUDE]
    NotificationCenter.default.addObserver(self,
        selector: #selector(SignViewController.receiveToggleAuthUINotification(_:)),
        name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
        object: nil)

    
    toggleAuthUI()
    
  }
    
    //action for tap out
  @IBAction func didTapSignOut(_ sender: AnyObject) {
    GIDSignIn.sharedInstance().signOut()
    // [START_EXCLUDE silent]
    toggleAuthUI()
  }

  // [END disconnect_tapped]
  // [START toggle_auth]
  func toggleAuthUI() {
    if let _ = GIDSignIn.sharedInstance()?.currentUser?.authentication {
      // Signed in
      signInButton.isHidden = true
      //performSegue(withIdentifier: "login", sender: self)
    } else {
      signInButton.isHidden = false
      
      
    }
  }
  // [END toggle_auth]
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return UIStatusBarStyle.lightContent
  }

  deinit {
    NotificationCenter.default.removeObserver(self,
        name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
        object: nil)
  }

// if receive notification
  @objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
    if notification.name.rawValue == "ToggleAuthUINotification" {
      self.toggleAuthUI()
      if notification.userInfo != nil {
        guard (notification.userInfo as? [String:String]) != nil else { return }
      }
    }
  }

}

//
//  ViewController.swift
//  Run
//
//  Created by Justin May on 5/10/18.
//  Copyright © 2018 Justin May. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    let users = [User]()
    
    @IBOutlet var viewController: UIView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func signinButtonAction(_ sender: Any) {
        
        guard let userName = usernameTextField.text else {
                return
        }
        guard let password = passwordTextField.text else {
                return
        }
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            print(snapshot)
            if let dictionary = snapshot.value as? [String: AnyObject] {
                if snapshot.childSnapshot(forPath: "names").value! as! String == userName {
                    let email = snapshot.childSnapshot(forPath: "email").value! as! String
                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print(error)
                            return
                        }
                        print("logged in")
                        //signs in!
                        self.performSegue(withIdentifier: "login", sender: self)
                        
                    })
                }
            }
            
        }, withCancel: nil)
        
        
        
        //Auth.auth().signIn(withEmail: <#T##String#>, password: <#T##String#>, completion: <#T##AuthResultCallback?##AuthResultCallback?##(User?, Error?) -> Void#>)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: viewController.frame.width, height: viewController.frame.height))
        let gradient = CAGradientLayer()
        let top = UIColor(red:0.79, green:0.44, blue:0.94, alpha:1.0)
        let bottom = UIColor(red:0.98, green:0.44, blue:0.80, alpha:1.0)
        
        gradient.frame = view.bounds
        gradient.colors = [top.cgColor, bottom.cgColor]
        
        signInButton.layer.cornerRadius = 30
        self.view.layer.insertSublayer(gradient, at: 0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


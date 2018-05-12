//
//  SignUpViewController.swift
//  Run
//
//  Created by Justin May on 5/10/18.
//  Copyright © 2018 Justin May. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet var signupPageView: UIView!
    @IBOutlet weak var signupTopView: UIView!
    @IBOutlet weak var tableView: UITableView!
    let elements = ["UsernameIcon-3","Email-1","PasswordIcon-3"]
    let placeholder = ["Username","Email","Password"]
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        let usernameTextField = self.tableView.viewWithTag(2) as? UITextField
        let emailTextField = self.tableView.viewWithTag(3) as? UITextField
        let passwordTextField = self.tableView.viewWithTag(4) as? UITextField
        guard let userName = usernameTextField!.text
            else {
                return
        }
        guard let email = emailTextField!.text
            else {
                return
        }
        guard let password = passwordTextField?.text
            else {
                return
        }
        print( userName, email, password,"hi")
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            let ref = Database.database().reference(fromURL: "https://runcodingchallenge.firebaseio.com/")
            guard let uid = user?.uid
                else {
                    return 
            }
            let usersReference = ref.child("users").child(uid)
            let values = ["names": userName, "email": email,"password": password]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil {
                    print(err)
                    return
                }
                
                print("saved user successfully into firebase db")
            })
            
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        let view = UIView(frame: CGRect(x: 0, y: 0, width: signupPageView.frame.width, height: signupTopView.frame.height))
        let gradient = CAGradientLayer()
        let top = UIColor(red:0.79, green:0.44, blue:0.94, alpha:1.0)
        let bottom = UIColor(red:0.98, green:0.44, blue:0.80, alpha:1.0)
        
        gradient.frame = view.bounds
        gradient.colors = [top.cgColor, bottom.cgColor]
        signupTopView.layer.insertSublayer(gradient, at: 0)
        
        signupButton.layer.cornerRadius = 30
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTabelTableViewCell
        cell.iconImage.image = UIImage(named: elements[indexPath.row])
        cell.iconImage.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        cell.iconImage.tintColor = UIColor.black
        cell.textFieldtemplate.placeholder = placeholder[indexPath.row]
        cell.textFieldtemplate.tag = indexPath.row + 2
        print("tag is ",cell.textFieldtemplate.tag)

        
        return cell
    }

}

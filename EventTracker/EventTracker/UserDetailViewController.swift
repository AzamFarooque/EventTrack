//
//  UserDetailViewController.swift
//  EventTracker
//
//  Created by Farooque on 02/04/17.
//  Copyright © 2017 Farooque. All rights reserved.
//

import UIKit
import CoreData

class UserDetailViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextFieldLeftConstraints: NSLayoutConstraint!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var nameTextFieldRightConstraints: NSLayoutConstraint!
    @IBOutlet weak var proceedButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var proceedButtonRightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = true
        self.proceedButton.layer.cornerRadius = 10
        
        nameTextField.layer.borderColor = UIColor(red: 34/255, green: 96/255, blue: 125/255, alpha: 1).cgColor
        nameTextField.layer.borderWidth = 2
        if(self.view.frame.size.width > 714)
        {
            nameTextFieldRightConstraints.constant = 150
            nameTextFieldLeftConstraints.constant = 150
            proceedButtonRightConstraint.constant = 150
            proceedButtonLeftConstraint.constant = 150
        }

    }
    
    // MARK : ProceedButtonAction

      @IBAction func proceedAction(_ sender: AnyObject) {
        
        if (nameTextField.text?.isEmpty)!
        {
            let alert = UIAlertController(title: "Alert", message: "Please enter your name to proceed", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
       
        UserDefaults.standard.set(nameTextField.text, forKey: "userName")
        let storyboard = UIStoryboard(storyboard: .Main)
        let controller : ViewController = storyboard.instantiateViewController()
        self.navigationController?.pushViewController(controller, animated: true)
            
      }
      
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

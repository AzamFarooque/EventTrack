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
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var proceedButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = true
        self.proceedButton.layer.cornerRadius = 10

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

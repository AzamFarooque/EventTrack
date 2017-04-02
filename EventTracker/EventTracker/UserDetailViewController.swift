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
  self.navigationController?.isNavigationBarHidden = true
  self.proceedButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func proceedAction(_ sender: AnyObject) {
        
        if (nameTextField.text?.isEmpty)!
        {
            let alert = UIAlertController(title: "Alert", message: "Please enter your name to proceed", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
        print(_model)
        UserDefaults.standard.set(nameTextField.text, forKey: "userName")
        let storyboard = UIStoryboard(storyboard: .Main)
        let controller : ViewController = storyboard.instantiateViewController()
        self.navigationController?.pushViewController(controller, animated: true)
            
        }
    }
    
    internal var _model: NSManagedObjectModel {
        let model = NSManagedObjectModel()
        
        // Create the entity
        let entity = NSEntityDescription()
         entity.name = nameTextField.text
        // Assume that there is a correct
        // `CachedFile` managed object class.
        entity.managedObjectClassName = String(describing: CachedURLResponse())
        
        // Create the attributes
        var properties = Array<NSAttributeDescription>()
        
        let eventName = NSAttributeDescription()
        eventName.name = "eventName"
        eventName.attributeType = .stringAttributeType
        eventName.isOptional = false
        eventName.isIndexed = true
        properties.append(eventName)
        
        let eventLocation = NSAttributeDescription()
        eventLocation.name = "eventLocation"
        eventLocation.attributeType = .stringAttributeType
        eventLocation.isOptional = false
        eventLocation.isIndexed = true
        properties.append(eventLocation)
        
        let eventEntry = NSAttributeDescription()
        eventEntry.name = "eventEntry"
        eventEntry.attributeType = .stringAttributeType
        eventEntry.isOptional = false
        eventEntry.isIndexed = true
        properties.append(eventEntry)
        
        
        // Add attributes to entity
        entity.properties = properties
        
        // Add entity to model
        model.entities = [entity]
        
      
        
        // Done :]
        return model
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

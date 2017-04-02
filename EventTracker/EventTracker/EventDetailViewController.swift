//
//  EventDetailViewController.swift
//  EventTracker
//
//  Created by Farooque on 02/04/17.
//  Copyright © 2017 Farooque. All rights reserved.
//

import UIKit
import CoreData

class EventDetailViewController: UIViewController,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var trackerButton: UIButton!
    var isTrackListScreen:Bool = false
    var isTracked : Bool = false
    var navController : UINavigationController!
    var eventDetailDictionary : NSDictionary!
    var eventNameString : String!
    var eventLocationString : String!
    var eventEntryString : String!
    
    let userName : String = UserDefaults.standard.object(forKey: "userName") as! String
   
    var array: [NSManagedObject] = []

    

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var eventEntry: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       

        
        eventNameString = eventDetailDictionary.object(forKey: "Event Name") as! String?
        eventLocationString = eventDetailDictionary.object(forKey: "Event Location") as! String?
        eventEntryString = eventDetailDictionary.object(forKey: "Event Entry") as! String?
        
        eventName.text = "Event Name : "+eventNameString!
        eventLocation.text = "Event Location : "+eventLocationString!
        eventEntry.text = "Event Entry : "+eventEntryString!
        
        
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Users")
        
        //3
        do {
            array = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        for (index, element) in array.enumerated() {
            
            let event = array[index]
            let eventName = event.value(forKeyPath: "eventName") as? String
            print(eventNameString!)
            if(eventName == eventNameString)
            {
                trackerButton.setImage(UIImage(named: "trackImage"), for: UIControlState.normal)
                break
            }
        }

        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.leftSwipe))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)

    }
    
    
    func leftSwipe()
    {
        let storyboard = UIStoryboard(storyboard: .Main)
        let subsectionVC : EventTrackListViewController = storyboard.instantiateViewController()
        navController = UINavigationController(rootViewController: subsectionVC) // Creating a
        navController.isNavigationBarHidden = true
        self.present(navController, animated:true, completion: nil)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: AnyObject) {
     
          self.navigationController?.popViewController(animated: true)
        
    }

    @IBAction func eventTrackAction(_ sender: AnyObject) {
        
        
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Users")
        
        //3
        do {
            array = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        if array.count == 0 {
            save()
            sender.setImage(UIImage(named: "trackImage"), for: UIControlState.normal)
        }
        
        else
        {
        
        for (index, element) in array.enumerated() {
            
            let event = array[index]
            let eventName = event.value(forKeyPath: "eventName") as? String
            
            if(eventName == eventNameString)
            {
                
                 isTracked = true
            }
            
            else
            {
                isTracked = false

            }
            
            if(isTracked == true)
            {
                managedContext.delete(array[index])
                do {
                    try managedContext.save()
                    
                                      
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }

                sender.setImage(UIImage(named: "unTrackImage"), for: UIControlState.normal)
                
                if(isTrackListScreen == true)
                {
                self.navigationController?.popViewController(animated: true)
                }
                
                break

            }
            
            }
            
            if(isTracked == false)
            {
                save()
                sender.setImage(UIImage(named: "trackImage"), for: UIControlState.normal)
            }

          }
        
        
        }
    
    func save() {
        
       
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Users",
                                       in: managedContext)!
        
        let event = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        event.setValue(eventNameString, forKeyPath: "eventName")
        event.setValue(eventLocationString, forKeyPath: "eventLocation")
        event.setValue(eventEntryString, forKeyPath: "eventEntry")
        
        
        // 4
        do {
            try managedContext.save()
            
            array.append(event)
           
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
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

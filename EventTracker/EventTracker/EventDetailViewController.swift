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
        eventNameString = eventDetailDictionary.object(forKey: "Event Name") as! String?
        eventLocationString = eventDetailDictionary.object(forKey: "Event Location") as! String?
        eventEntryString = eventDetailDictionary.object(forKey: "Event Entry") as! String?
        eventName.text = "Event Name : "+eventNameString!
        eventLocation.text = "Event Location : "+eventLocationString!
        eventEntry.text = "Event Entry : "+eventEntryString!
        // Right to Left swipe Action
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.leftSwipe))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
      }
    // MARK : - Method ViewDidAppear
     override func viewDidAppear(_ animated: Bool) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Users")
        do {
            array = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        let userName : String = UserDefaults.standard.object(forKey: "userName") as! String
        for (index, element) in array.enumerated() {
            let event = array[index]
            let eventName = event.value(forKeyPath: "eventName") as? String
            let userNameInDb = event.value(forKeyPath: "userName") as? String
            if(eventName == eventNameString && userNameInDb == userName )
            {
                trackerButton.setImage(UIImage(named: "trackImage"), for: UIControlState.normal)
                break
            }
        }
    }
    // MARK : - Left swipe action
    func leftSwipe()
    {
        let storyboard = UIStoryboard(storyboard: .Main)
        let subsectionVC : EventTrackListViewController = storyboard.instantiateViewController()
        navController = UINavigationController(rootViewController: subsectionVC) // Creating a
        navController.isNavigationBarHidden = true
        self.present(navController, animated:true, completion: nil)
    }
    // MARK : - Backbutton Action
    @IBAction func backAction(_ sender: AnyObject) {
    self.navigationController?.popViewController(animated: true)
        }
     // MARK : - For saving and removing event in Core Data
    @IBAction func eventTrackAction(_ sender: AnyObject) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Users")
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
        let userName : String = UserDefaults.standard.object(forKey: "userName") as! String
           for (index, element) in array.enumerated() {
            
            let event = array[index]
            let eventName = event.value(forKeyPath: "eventName") as? String
            let userNameInDb = event.value(forKeyPath: "userName") as? String
            
            if(eventName == eventNameString && userNameInDb == userName)
            {
            isTracked = true
            }
            else
            {
            isTracked = false
            }
            if(isTracked == true)
            {managedContext.delete(array[index])
                do {
                    try managedContext.save()
                    } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
                 sender.setImage(UIImage(named: "unTrackImage"), for: UIControlState.normal)
                if(isTrackListScreen == true)
                {
                    let storyboard = UIStoryboard(storyboard: .Main)
                    let controller : EventTrackListViewController = storyboard.instantiateViewController()
                    self.navigationController?.pushViewController(controller, animated: false)
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
    // MARK : Saving Event Method
    func save() {
        
       let userName : String = UserDefaults.standard.object(forKey: "userName") as! String
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
            let entity =
            NSEntityDescription.entity(forEntityName: "Users",
                                       in: managedContext)!
            let event = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        event.setValue(eventNameString, forKeyPath: "eventName")
        event.setValue(eventLocationString, forKeyPath: "eventLocation")
        event.setValue(eventEntryString, forKeyPath: "eventEntry")
        event.setValue(userName, forKey: "userName")
        do {
            try managedContext.save()
            array.append(event)
           } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
}

//
//  EventTrackListViewController.swift
//  EventTracker
//
//  Created by Farooque on 02/04/17.
//  Copyright © 2017 Farooque. All rights reserved.
//

import UIKit
import CoreData

class EventTrackListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate {
    
    let gridFlowLayout = EventGridFlowLayout()
    /// Flow layout that displays cells with a List layout, like in a tableView
    let listFlowLayout = EventListFlowLayout()
    var isGridFlowLayoutUsed: Bool = false
    var eventTrackListarray: [NSManagedObject] = []
    var eventuserTrackListarray: [NSManagedObject] = []
    var array: [NSManagedObject] = []
    

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
       
        
        collectionView.backgroundColor = UIColor.black
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(EventTrackListViewController.rightSwipe))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
       setupInitialLayout()
       retriveTrackList()
    }
    

    
    @IBAction func listOrGridAction(_ sender: AnyObject) {
        
        if(sender.selectedSegmentIndex == 0)
        {
            isGridFlowLayoutUsed = true
            
            UIView.animate(withDuration: 0.2) { () -> Void in
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.setCollectionViewLayout(self.gridFlowLayout, animated: true)
            }
            
         }
           else
        {
            isGridFlowLayoutUsed = false
            
            UIView.animate(withDuration: 0.2) { () -> Void in
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.setCollectionViewLayout(self.listFlowLayout, animated: true)
            }
            
        }
    }
    
    func rightSwipe()
    {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func setupInitialLayout() {
        isGridFlowLayoutUsed = true
        collectionView.collectionViewLayout = gridFlowLayout
    }
    
    func retriveTrackList()
    {
       
       let userName : String = UserDefaults.standard.object(forKey: "userName") as! String
        
       
    guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
       
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Users")
        
        
        do {
            eventTrackListarray = try managedContext.fetch(fetchRequest)
            
              for (index, element) in eventTrackListarray.enumerated() {
                
                let eventDetail = eventTrackListarray[index]
                
                let userNameInDb = eventDetail.value(forKeyPath: "userName") as? String
                
                if(userNameInDb==userName)
                {
                    eventuserTrackListarray += [eventDetail]
                    let unique = Array(Set(eventuserTrackListarray))
                    eventuserTrackListarray = unique
                    
                }
                
            }
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
         array = eventuserTrackListarray
         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return array.count
    }
    
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventListCell", for: indexPath as IndexPath) as! EventListCell
        
         let eventDetail = array[indexPath.row]
        
        //        cell.layer.borderColor = UIColor.black.cgColor
        //        cell.layer.borderWidth = 0.5
        cell.backgroundColor = UIColor.white
        
        if (indexPath.row % 2 == 0)
        {
            let image: UIImage = UIImage(named: "eventImage")!
            cell.imageView.image = image
        }
        else
        {
            let image: UIImage = UIImage(named: "eventImage2")!
            cell.imageView.image = image
        }
        
        
        cell.eventName.text = eventDetail.value(forKeyPath: "eventName") as? String
        cell.eventLocation.text = eventDetail.value(forKeyPath: "eventLocation") as? String
        cell.eventDetail.text = eventDetail.value(forKeyPath: "eventEntry") as? String
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let eventDetail = array[indexPath.row]
        let storyboard = UIStoryboard(storyboard: .Main)
        let controller : EventDetailViewController = storyboard.instantiateViewController()
        
        controller.eventDetailDictionary = ["Event Name" : eventDetail.value(forKeyPath: "eventName") as? String , "Event Location" :eventDetail.value(forKeyPath: "eventLocation") as? String , "Event Entry" : eventDetail.value(forKeyPath: "eventEntry") as? String ]
        controller.isTrackListScreen = true
        self.navigationController?.pushViewController(controller, animated: true)
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

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
    let listFlowLayout = EventListFlowLayout()
    var isGridFlowLayoutUsed: Bool = false
    var eventTrackListarray: [NSManagedObject] = []
    var eventuserTrackListarray: [NSManagedObject] = []
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.black
    // Right to Left swipe Action
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(EventTrackListViewController.rightSwipe))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
    }
    // MARK : - Method ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
       setupInitialLayout()
       retriveTrackList()
    }
    // MARK : - Changing list to Grid or viceversa
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
    // MARK : - Right swipe action
    func rightSwipe()
    {
     self.dismiss(animated: true, completion: nil)
        
    }
     // MARK : - Setting Initial Layout For EventListing
    func setupInitialLayout() {
        isGridFlowLayoutUsed = true
        collectionView.collectionViewLayout = gridFlowLayout
    }
    // MARK : Retrive EventList for unique User
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
        
         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.reloadData()
    }
    // MARK : CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return eventuserTrackListarray.count
    }
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventListCell", for: indexPath as IndexPath) as! EventListCell
        let eventDetail = eventuserTrackListarray[indexPath.row]
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
        let eventDetail = eventuserTrackListarray[indexPath.row]
        let storyboard = UIStoryboard(storyboard: .Main)
        let controller : EventDetailViewController = storyboard.instantiateViewController()
        controller.eventDetailDictionary = ["Event Name" : eventDetail.value(forKeyPath: "eventName") as? String , "Event Location" :eventDetail.value(forKeyPath: "eventLocation") as? String , "Event Entry" : eventDetail.value(forKeyPath: "eventEntry") as? String ]
        controller.isTrackListScreen = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
}

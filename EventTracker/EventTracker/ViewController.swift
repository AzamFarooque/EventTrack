//
//  ViewController.swift
//  EventTracker
//
//  Created by Farooque on 01/04/17.
//  Copyright © 2017 Farooque. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
     var navController : UINavigationController!
     var numberOfRow = 0
     var eventNameArray = [String]()
     var eventLocationArray = [String]()
     var eventDetailArray = [String]()
     var eventImageArray = [String]()
     let gridFlowLayout = EventGridFlowLayout()
     let listFlowLayout = EventListFlowLayout()
     var isGridFlowLayoutUsed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        setupInitialLayout()
        collectionView.backgroundColor = UIColor.black
    // Right to Left swipe Action
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.leftSwipe))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
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
    // MARK : - Changing list to Grid or viceversa
    @IBAction func listOrGridAction(_ sender: AnyObject) {
        if(sender.selectedSegmentIndex == 0)
        {isGridFlowLayoutUsed = true
                UIView.animate(withDuration: 0.2) { () -> Void in
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.setCollectionViewLayout(self.gridFlowLayout, animated: true)
            }  }
        else
        {isGridFlowLayoutUsed = false
                UIView.animate(withDuration: 0.2) { () -> Void in
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.setCollectionViewLayout(self.listFlowLayout, animated: true)
            }
        }
    }
    // MARK : - Parson JSON from jsonFile
     func parseJSON()
    {
        if let path = Bundle.main.path(forResource: "jsonFile", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                   if jsonObj != JSON.null {
                  numberOfRow = jsonObj["Events"].count
                    for i in 1...numberOfRow{
                        var Event = "Event"
                        Event += "\(i)"
                        let eventName = jsonObj["Events"][Event]["EventName"].string as String!
                        var imageURL = jsonObj["Events"][Event]["imageURL"].string as String!
                        var venue = jsonObj["Events"][Event]["venue"].string as String!
                        var event = jsonObj["Events"][Event]["Event"].string as String!
                        eventNameArray.append(eventName!)
                        eventLocationArray.append(venue!)
                        eventDetailArray.append(event!)
                        collectionView.delegate = self
                        collectionView.dataSource = self
                        }
                    } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    // MARK : - Setting Initial Layout For EventListing
     func setupInitialLayout() {
        isGridFlowLayoutUsed = true
        collectionView.collectionViewLayout = gridFlowLayout
    }
    // MARK : - CollectionView Deleagtes
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return numberOfRow
    }
      private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventListCell", for: indexPath as IndexPath) as! EventListCell
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
        cell.eventName.text = eventNameArray[indexPath.row]
        cell.eventLocation.text = eventLocationArray[indexPath.row]
        cell.eventDetail.text = eventDetailArray[indexPath.row]
        return cell
     }
     func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(storyboard: .Main)
        let controller : EventDetailViewController = storyboard.instantiateViewController()
        controller.eventDetailDictionary = ["Event Name" : eventNameArray[indexPath.row] as String , "Event Location" : eventLocationArray[indexPath.row] , "Event Entry" : eventDetailArray[indexPath.row] ]
        self.navigationController?.pushViewController(controller, animated: true)
    }
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


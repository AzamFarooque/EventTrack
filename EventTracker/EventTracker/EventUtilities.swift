//
//  EventUtilities.swift
//  EventTracker
//
//  Created by Farooque on 02/04/17.
//  Copyright © 2017 Farooque. All rights reserved.
//

import Foundation
import UIKit
import CoreData


final class EventUtilities
{
    
    @available(iOS 10.0, *)
    static func savedUser(user : String)    {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: user, into: context)
        
    
        }
}

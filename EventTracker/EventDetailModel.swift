//
//  EventDetailModel.swift
//  EventTracker
//
//  Created by Farooque on 01/04/17.
//  Copyright © 2017 Farooque. All rights reserved.
//

import Foundation

class EventDetailModel {
    
    var event: NSDictionary?
    var location: String?
    var lat: String?
    var long: String?
    var subSectionArray : String?
    var name : String?
    var vicinity : String?
    
    init(json: NSDictionary) {
        self.event = json["geometry"] as? NSDictionary
        //self.location = geometry?["location"] as? String
        self.name = json["name"] as? String
        self.vicinity = json["vicinity"] as? String
        
        
    }
}

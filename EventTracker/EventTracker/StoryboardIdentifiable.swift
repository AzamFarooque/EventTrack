//
//  StoryboardIdentifiable.swift
//  AzamMedia
//
//  Created by Farooque on 20/02/17.
//  Copyright © 2016 NDTV World Wide. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

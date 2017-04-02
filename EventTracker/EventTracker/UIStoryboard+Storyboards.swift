//
//  UIStoryboard+Storyboards.swift
//  AzamMedia
//
//  Created by Farooque on 20/02/17.
//  Copyright © 2016 NDTV World Wide. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    /// Declare all the storyboard in application
    
    enum Storyboard : String {
        case Main
        }
    
    
    /// Convenience Initializers
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    
    /// Class Functions
    
    class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
    }
    
    
    /// View Controller Instantiation from Generics

    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
}


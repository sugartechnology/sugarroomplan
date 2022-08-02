//
//  CustomActivit.swift
//  RoomPlanExampleApp
//
//  Created by fatih erol on 29.07.2022.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation
import UIKit


class CustomActivity: UIActivity {
    
    var title:String
    var imagePath:String
    
     
    init(title:String, imagePath:String) {
        self.title = title
        self.imagePath = imagePath
    }
        //Returns custom activity title
    override var activityTitle: String?{
        return title
    }
    
        //Returns thumbnail image for the custom activity
    override var activityImage: UIImage?{
        return UIImage(named: imagePath)
    }
    
    
    override class var activityCategory: UIActivity.Category {
        return .share
    }
    
    
        //Custom activity type that is reported to completionHandler
    override var activityType: UIActivity.ActivityType{
        if(self.imagePath == "istikbal"){
            return UIActivity.ActivityType.customActivity
        }
            
        return UIActivity.ActivityType.customActivity1
    }
    
        //View controller for the activity
    override var activityViewController: UIViewController?{
        
        return nil
    }
    
        //Returns a Boolean indicating whether the activity can act on the specified data items.
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
        //If no view controller, this method is called. call activityDidFinish when done.
    override func prepare(withActivityItems activityItems: [Any]) {
            //Perform action on tap of custom activity
    }
}

extension UIActivity.ActivityType {
    static let customActivity = UIActivity.ActivityType("com.sugar.customActivity")
    static let customActivity1 = UIActivity.ActivityType("com.sugar.customActivity2")
}

//
//  ViewStyles.swift
//  RoomPlanExampleApp
//
//  Created by fatih erol on 29.07.2022.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation
import UIKit



class ButtonStyle: UIButton{
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    
    @IBInspectable var borderWith: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWith
        }
    }
}



class ViewStyle: UIImageView{
    
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    
    @IBInspectable var borderWith: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWith
        }
    }
}


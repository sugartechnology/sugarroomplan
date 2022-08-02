//
//  PopupBrands.swift
//  RoomPlanExampleApp
//
//  Created by fatih erol on 29.07.2022.
//  Copyright © 2022 Apple. All rights reserved.
//

import UIKit

class PopupBrands: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame);
        xibSetup(frame:CGRect(x:0, y:0, width:frame.width, height:frame.height))
    }
    
    
    
    func xibSetup(frame:CGRect){
        let v = loadXib()
        v.frame = frame
        addSubview(v)
    }
    
    
    func loadXib()->UIView{
        let bundle = Bundle(for:type(of: self))
        let uix = UINib(nibName: "PopupBrands", bundle: bundle)
        
        let view = uix.instantiate(withOwner: self, options: nil).first as? UIView;
        
        return view!;
    }
}

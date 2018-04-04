//
//  cocoa.swift
//  Coursework
//
//  Created by yc16abc on 02/04/2018.
//  Copyright © 2018 15062367. All rights reserved.
//

import UIKit

class cocoa: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var startLocation: CGPoint?
    
    var myDelegate: subviewDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startLocation = touches.first?.location(in: self)
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let currentLocation = touches.first?.location(in: self)
        let dx = currentLocation!.x - startLocation!.x
        let dy = currentLocation!.y - startLocation!.y
        
        self.center = CGPoint(x: self.center.x+dx, y: self.center.y+dy)
        
        //let halfx = (self.superview?.bounds.size.width)! * 0.5
        self.center.x = max(65, self.center.x)
        self.center.x = min((self.superview?.bounds.size.width)! - 65, self.center.x)

        
        self.myDelegate?.moveBoundary()
        //self.myDelegate?.debug(text: (self.superview?.bounds.size.width.description)!)
 
    }
    
}

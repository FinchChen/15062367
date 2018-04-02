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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        startLocation = touches.first?.locationInView(self)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let currentLocation = touches.first?.locationInView(self)
        let dx = currentLocation!.x - startLocation!.x
        let dy = currentLocation!.y - startLocation!.y
        
        self.center = CGPointMake(self.center.x+dx, self.center.y+dy)
        
        
        //let halfx = CGRectGetMidX(self.bounds)
        //self.center.x = max(halfx, self.center.x)
        //self.center.x = min((self.superview?.bounds.size.width)! - halfx, self.center.x)
        self.center.x = max(65, self.center.x)
        self.center.x = min((self.superview?.bounds.size.width)! - 65, self.center.x)
 
    }
    
}

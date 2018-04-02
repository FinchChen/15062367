//
//  ViewController.swift
//  Coursework
//
//  Created by yc16abc on 02/04/2018.
//  Copyright © 2018 15062367. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dynamicAnimator: UIDynamicAnimator!
    var dynamicItemBehavior: UIDynamicItemBehavior!
    
    
    @IBOutlet weak var roadView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var imageArray: [UIImage]!
        
        imageArray = [UIImage(named: "road1.png")!,
                      UIImage(named: "road2.png")!,
                      UIImage(named: "road3.png")!,
                      UIImage(named: "road4.png")!,
                      UIImage(named: "road5.png")!,
                      UIImage(named: "road6.png")!,
                      UIImage(named: "road7.png")!,
                      UIImage(named: "road8.png")!,
                      UIImage(named: "road9.png")!,
                      UIImage(named: "road10.png")!,
                      UIImage(named: "road11.png")!,
                      UIImage(named: "road12.png")!,
                      UIImage(named: "road13.png")!,
                      UIImage(named: "road14.png")!,
                      UIImage(named: "road15.png")!,
                      UIImage(named: "road16.png")!,
                      UIImage(named: "road17.png")!,
                      UIImage(named: "road18.png")!,
                      UIImage(named: "road19.png")!,
                      UIImage(named: "road20.png")!]
        
        roadView.image = UIImage.animatedImage(with: imageArray, duration: 1)
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            let carView = UIImageView(image: nil)
            carView.image = UIImage(named: "car1.png")
            let midx = UIScreen.main.bounds.size.width * 0.5
            carView.frame = CGRect(x:midx-15,y:30,width:30,height:45)
            self.view.addSubview(carView)
            // when = DispatchTime.now() + 2
            self.dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
            self.dynamicItemBehavior = UIDynamicItemBehavior(items:[carView])
            self.dynamicItemBehavior.addLinearVelocity(CGPoint(x:0,y:300), for: carView)
            self.dynamicAnimator.addBehavior(self.dynamicItemBehavior)
        }
        
        let timeOut = DispatchTime.now() + 20
        DispatchQueue.main.asyncAfter(deadline: timeOut) {
            // finish the game
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


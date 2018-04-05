//
//  ViewController.swift
//  Coursework
//
//  Created by yc16abc on 02/04/2018.
//  Copyright © 2018 15062367. All rights reserved.
//

import UIKit

protocol subviewDelegate {
    func moveBoundary();
    func debug(text: String)
}



class ViewController: UIViewController, subviewDelegate {
    
    
    var dynamicAnimator: UIDynamicAnimator!
    var collisionBehavior: UICollisionBehavior!
    var dynamicItemBehavior: UIDynamicItemBehavior!
    
    
    @IBOutlet weak var main_car: cocoa!
    @IBOutlet weak var debug: UILabel!
    @IBOutlet weak var roadView: UIImageView!
    @IBOutlet weak var game_over: UIImageView!
    
    @IBAction func replay(_ sender: UIButton) {
        self.game_over.isHidden = true
        self.replay2.isHidden = true
        self.viewDidLoad()
        
    }
    
    @IBOutlet weak var replay2: UIButton!
    
    func debug(text: String){
        self.debug.text = text
    }
    
    func random(_ range:Range<Int>) -> Int{
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
    
    func moveBoundary(){
        self.collisionBehavior.removeAllBoundaries()
        self.collisionBehavior.addBoundary(withIdentifier: "anything" as NSCopying,  for: UIBezierPath(rect: self.main_car.frame))
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        main_car.myDelegate = self
        
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
        
        var carArray = [UIImage(named: "car1.png")!,
                        UIImage(named: "car2.png")!,
                        UIImage(named: "car3.png")!,
                        UIImage(named: "car4.png")!,
                        UIImage(named: "car5.png")!,
                        UIImage(named: "car6.png")!]
        let carrange: UInt32 = UInt32(carArray.count)
        let randomcar = Int(arc4random_uniform(carrange))
        
        let midx = UIScreen.main.bounds.size.width * 0.5
        let midy = UIScreen.main.bounds.size.height * 0.5
        
        
        let xrange: Range = 65..<375-65

        let randomx = random(xrange)
        let carView = UIImageView(image: carArray[randomcar])
        carView.frame = CGRect(x:randomx,y:30,width:30,height:45)
        self.view.addSubview(carView)
            
        self.dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        self.dynamicItemBehavior = UIDynamicItemBehavior(items:[carView])
        self.dynamicItemBehavior.addLinearVelocity(CGPoint(x:0,y:300), for: carView)
        self.dynamicAnimator.addBehavior(self.dynamicItemBehavior)
            
        self.collisionBehavior = UICollisionBehavior(items:[carView])
        //self.collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        self.dynamicAnimator.addBehavior(self.collisionBehavior)
            
        self.collisionBehavior.addBoundary(withIdentifier: "anything" as NSCopying,  for: UIBezierPath(rect: self.main_car.frame))
            
        
        
        let timeOut = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: timeOut) {
            // finish the game
            self.game_over.isHidden = false
            self.replay2.isHidden = false
            // self.carView.isHidden = true
            carView.removeFromSuperview()
            self.main_car.center.x = midx
            self.main_car.center.y = (midy * 2) - 85
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


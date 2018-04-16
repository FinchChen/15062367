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
    
    struct NUM {
        static let W = UIScreen.main.bounds.width
        static let H = UIScreen.main.bounds.height
        static var score = 0
        static var counter = 0
    }
    
    struct CAR {
        static let carArray = [UIImage(named: "car1.png")!,
                               UIImage(named: "car2.png")!,
                               UIImage(named: "car3.png")!,
                               UIImage(named: "car4.png")!,
                               UIImage(named: "car5.png")!,
                               UIImage(named: "car6.png")!]
    }
    
    struct LIST {
        static var list = [UIImageView]()
    }
    
    @IBOutlet weak var main_car: cocoa!
    @IBOutlet weak var debug: UILabel!
    @IBOutlet weak var roadView: UIImageView!
    @IBOutlet weak var game_over: UIImageView!
    @IBOutlet weak var Score: UILabel!
    
    @IBAction func replay(_ sender: UIButton) {
        
        self.game_over.isHidden = true
        self.replay2.isHidden = true
        self.Score.isHidden = true
        self.main_car.isHidden = false
        NUM.score = 0
        NUM.counter = 0
        LIST.list = [UIImageView]()
        self.viewDidLoad()
        
    }
    
    @IBOutlet weak var replay2: UIButton!
    
    func debug(text: String){
        
        self.debug.text = String(NUM.score)
        
    }
    
    func random(_ range:Range<Int>) -> Int{
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
    
    func moveBoundary(){
        self.collisionBehavior.removeAllBoundaries()
        self.collisionBehavior.addBoundary(withIdentifier: "anything" as NSCopying,  for: UIBezierPath(rect: self.main_car.frame))
        for i in LIST.list {
            if i.frame.intersects(self.main_car.frame) {
                NUM.score -= 1
            }
        }
        
    }
    
    func generateCar() {
    
        
        
        let count = UInt32(2)
        let randomNumber = Int(arc4random_uniform(count))
        
        for _ in 0...randomNumber {
            
            let carrange: UInt32 = UInt32(CAR.carArray.count)
            let randomcar = Int(arc4random_uniform(carrange))
            let xrange: Range = Int(NUM.W*0.15)..<Int(NUM.W*0.78)
            let randomx = random(xrange)
            
            let vrange: Range = Int(NUM.H*0.35)..<Int(NUM.H*0.6)
            let randomv = random(vrange)
        
            let carView = UIImageView()
            carView.image = CAR.carArray[randomcar]
            carView.frame = CGRect(x:CGFloat(randomx),y:NUM.W*0.1,width:NUM.W*0.08,height:NUM.W*0.12)
            self.view.addSubview(carView)
            LIST.list.append(carView)

            if NUM.counter == 0{
            dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        }
        
            dynamicItemBehavior = UIDynamicItemBehavior(items:[carView])
            dynamicItemBehavior.addLinearVelocity(CGPoint(x:0,y:randomv), for: carView)
            dynamicAnimator.addBehavior(self.dynamicItemBehavior)
        
            collisionBehavior = UICollisionBehavior(items:LIST.list)
            dynamicAnimator.addBehavior(self.collisionBehavior)
            collisionBehavior.addBoundary(withIdentifier: "anything" as NSCopying,  for: UIBezierPath(rect: self.main_car.frame))
            
            NUM.score += 5
            NUM.counter += 1
            self.debug.text = String(NUM.score)
        }


        let tmp = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: tmp) {
            if (NUM.counter < 40 && NUM.counter != 999) {
                self.generateCar()
            }
        }
        
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
        
        debug.frame = CGRect(x:NUM.W * 0.9,y:NUM.H * 0.05,width:NUM.W * 0.1,height:NUM.H * 0.1)
        main_car.center = CGPoint(x: NUM.W * 0.5, y: NUM.H * 0.87)
        roadView.image = UIImage.animatedImage(with: imageArray, duration: 1)
        roadView.frame = CGRect(x:0,y:0,width:NUM.W,height:NUM.H)
        
        generateCar()

    
        let timeOut = DispatchTime.now() + 20
        DispatchQueue.main.asyncAfter(deadline: timeOut) {
            // finish the game
            NUM.counter = 999
            self.main_car.isHidden = true
            self.roadView.image = UIImage()
            self.game_over.frame = CGRect(x:0,y:0,width:NUM.W,height:NUM.H*0.3)
            self.game_over.isHidden = false
            self.view.backgroundColor = UIColor.black
            self.replay2.frame = CGRect(x: 0, y:0,width:NUM.W*0.3*1.4,height:NUM.H*0.17*1.4)
            self.replay2.center = CGPoint(x: NUM.W*0.5, y:NUM.H*0.7)
            self.replay2.isHidden = false
            self.Score.text = String(NUM.score) + " Score!"
            self.Score.isHidden = false
            self.view.bringSubview(toFront: self.replay2)
            // self.carView.isHidden = true
            for i in LIST.list {
                i.removeFromSuperview()
            }
 
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



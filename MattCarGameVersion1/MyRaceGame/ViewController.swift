//
//  ViewController.swift
//  MyRaceGame
//
//  Created by mc17adv on 16/04/2018.
//  Copyright © 2018 mc17adv. All rights reserved.
//

import UIKit
//Import needed to play game music
import AVFoundation

protocol subviewDelegate {
    func changeSomething()
}

class ViewController: UIViewController, subviewDelegate {
    
    func changeSomething()
    {
       
    }
    
    
    @IBOutlet weak var RoadView: UIImageView!
    @IBOutlet weak var BlackBG: UIImageView!
    @IBOutlet weak var cardraged: DraggedImageView!
    
    //Audio Player
    var player: AVAudioPlayer!
    //Falling obstacles
    var dynamicAnimator: UIDynamicAnimator!
    var collisionBehaviour: UICollisionBehavior!
    var dynamicItemBehaviour: UIDynamicItemBehavior!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Game music
        let path = Bundle.main.path(forResource: "Darude - Sandstorm", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        do{
        player = try AVAudioPlayer(contentsOf: url)
        player.prepareToPlay()
        player.play()
        }catch let error as NSError {
            print(error.description)
        }
        
        //Road animation string
        var imageArray: [UIImage]!
        //Declaration of images to be used in the animation
        imageArray = [UIImage(named:"road1.png")!,
                      UIImage(named:"road2.png")!,
                      UIImage(named:"road3.png")!,
                      UIImage(named:"road4.png")!,
                      UIImage(named:"road5.png")!,
                      UIImage(named:"road6.png")!,
                      UIImage(named:"road7.png")!,
                      UIImage(named:"road8.png")!,
                      UIImage(named:"road9.png")!,
                      UIImage(named:"road10.png")!,
                      UIImage(named:"road11.png")!,
                      UIImage(named:"road12.png")!,
                      UIImage(named:"road13.png")!,
                      UIImage(named:"road14.png")!,
                      UIImage(named:"road15.png")!,
                      UIImage(named:"road16.png")!,
                      UIImage(named:"road17.png")!,
                      UIImage(named:"road18.png")!,
                      UIImage(named:"road19.png")!,
                      UIImage(named:"road20.png")!]
        //Set the speed of the animation
        RoadView.image = UIImage.animatedImage(with: imageArray, duration: 0.3)
        
        //Declaration of obstacle cars
        let carView = UIImageView(image: nil)
        
        //Assign an image to the image view
        carView.image = UIImage(named: "car1.png")
        
        //Assign the size and position of the image view
        carView.frame = CGRect(x:100, y: 100, width: 30, height: 50)
        
        //Bring the car image subview forward
        self.view.bringSubview(toFront: carView)
        
        //Set obstacles velocity and collision boundary
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)

        dynamicItemBehaviour = UIDynamicItemBehavior(items: [carView])
        dynamicItemBehaviour.addLinearVelocity(CGPoint(x: 100, y: 300), for: carView)
        dynamicAnimator.addBehavior(dynamicItemBehaviour)
        
        //Add obstacle image view to the collision boundary
        collisionBehaviour = UICollisionBehavior(items: [carView])
        collisionBehaviour.addBoundary(withIdentifier: "car" as
            NSCopying, for: UIBezierPath(rect: carView.frame))
        dynamicAnimator.addBehavior(collisionBehaviour)
        
        //Spawn obstacle after 3 seconds
        let obstacle = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: obstacle) {
            //Add the image view to the main view
            self.view.addSubview(carView)
        }
        
        //End game after 15 seconds and show game over
//        let endtime = DispatchTime.now() + 15
//        DispatchQueue.main.asyncAfter(deadline: endtime) {
//             self.view.bringSubview(toFront: self.BlackBG)
//       \\ self.view.bringSubview(toFront:self.GameOver)        }
//    
//    }

    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

}

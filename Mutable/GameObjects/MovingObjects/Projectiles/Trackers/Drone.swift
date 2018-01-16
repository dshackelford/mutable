//
//  Drone.swift
//  Mutable
//
//  Created by Dylan Shackelford on 1/15/18.
//  Copyright © 2018 Dylan Shackelford. All rights reserved.
//

import Foundation

class Drone : Projectile
{
    init(targetInit:CGPoint, viewInit:UIView, placeHolderButton:UIButton)
    {
        super.init()
        
        let locationDeterminant = arc4random()%100;
        
        if(locationDeterminant < 25)
        {
            self.setPosition(CGPoint(x:screenWidth, y:screenHeight))
        }
        else if(locationDeterminant >= 25 && locationDeterminant < 50)
        {
            self.setPosition(CGPoint(x:0, y:screenHeight))
        }
        else if(locationDeterminant >= 50 && locationDeterminant < 75)
        {
            self.setPosition(CGPoint(x:screenWidth, y:0))
        }
        else
        {
            self.setPosition(CGPoint(x:screenWidth, y:screenHeight))
        }
        
        self.setSize(CGSize(width:25,height:40))
        self.setImageFileName("newKamikaze")
        self.setImage()
        viewInit.insertSubview(self.getImage(), belowSubview: placeHolderButton)
    
        let dx = targetInit.x - self.getPosition().x;
        let dy = targetInit.y - self.getPosition().y;
        
        let hypotenuse = sqrt(dx*dx + dy*dy);
        
        let droneSpeed = 300;
        
        let droneTime = Int(hypotenuse)/droneSpeed;
        
        let vx = Int(dx)/droneTime;
        let vy = Int(dy)/droneTime;
        
        self.setVelocity(CGVector(dx:vx,dy:vy))
        
        
        //ROTATE IMAGE FOR ASETHETIC PURPOSES
        if (dy > 0 && dx < 0)
        {
            self.setAngleOfRotation(Double(acos(dy/hypotenuse)+3.14))
        }
        if (dy > 0 && dx > 0)
        {
            self.setAngleOfRotation(Double(0 - acos(dy/hypotenuse) + 3.14))
        }
        
        if (dy < 0 && dx < 0)
        {
            self.setAngleOfRotation(Double(acos(dy/hypotenuse) + 3.14))
        }
        
        if (dy < 0 && dx > 0)
        {
            self.setAngleOfRotation(Double(0 - acos(dy/hypotenuse) + 3.14))
        }
        
        
        self.getImage().transform = CGAffineTransform(rotationAngle: CGFloat(self.getAngleOfRotation()))
        
        objectArray.add(self)
    }
    
    
    
    func move(objectTracker:BasicObject)
    {
        self.moveDrone(targetInit: objectTracker.getPosition())
        self.getImage().center = self.getPosition()
        if(self.getPosition().x > CGFloat(screenWidth + 5) || self.getPosition().x < -5)
        {
            self.getImage().removeFromSuperview()
        }
        if(self.getPosition().y > CGFloat(screenHeight + 5) || self.getPosition().y < 5)
        {
            self.getImage().removeFromSuperview()
        }
    }
    
    func moveDrone(targetInit:CGPoint)
    {
        let xDesitination = targetInit.x;
        let yDesitination = targetInit.y;
        
        let dx = xDesitination - self.getPosition().x;
        let dy = yDesitination - self.getPosition().y;
        
        let hypotenuse = sqrt(dx*dx + dy*dy);
        
        let droneVelocity = 145;
        
        let droneTime = Int(hypotenuse)/droneVelocity;
        
        let vx = Int(dx)/droneTime;
        let vy = Int(dy)/droneTime;
        
        //ROTATE IMAGE FOR ASETHETIC PURPOSES
        if (dy > 0 && dx < 0)
        {
            self.setAngleOfRotation(Double(acos(dy/hypotenuse)+3.14))
        }
        if (dy > 0 && dx > 0)
        {
            self.setAngleOfRotation(Double(0 - acos(dy/hypotenuse) + 3.14))
        }
        
        if (dy < 0 && dx < 0)
        {
            self.setAngleOfRotation(Double(acos(dy/hypotenuse) + 3.14))
        }
        
        if (dy < 0 && dx > 0)
        {
            self.setAngleOfRotation(Double(0 - acos(dy/hypotenuse) + 3.14))
        }
        
        self.setVelocity(CGVector(dx:CGFloat(vx), dy:CGFloat(vy)))
        
        self.getImage().transform = CGAffineTransform(rotationAngle:CGFloat(self.getAngleOfRotation()))
        
        self.setPosition(CGPoint(x:self.getPosition().x + self.getVelocity().dx*CGFloat(deltaTime),y:self.getPosition().y + self.getVelocity().dy*CGFloat(deltaTime)))
    }
}

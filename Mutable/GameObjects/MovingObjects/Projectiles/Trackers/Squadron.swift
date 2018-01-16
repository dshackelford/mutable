//
//  Squadron.swift
//  Mutable
//
//  Created by Dylan Shackelford on 1/15/18.
//  Copyright © 2018 Dylan Shackelford. All rights reserved.
//

import Foundation

class Squadron : Drone
{
    func makeTriangleSquadron(targetPosition: CGPoint , containerInit :UIView, placeHolderButton : UIButton)
    {
        let x = 300 //screenwidth + 10
        let y = 100 //arc4random()%screenHeight
        
        let aPosition = CGPoint(x: x, y:y)
        
        let triangleSqaudArray = NSMutableArray()
        
        let leaderDrone:Drone = Drone(drone: aPosition, container: containerInit, placeHolderButton: placeHolderButton)
        triangleSqaudArray.add(leaderDrone)
        
        let leftDrone:Drone = Drone(drone: CGPoint(x:targetPosition.x-35,y:targetPosition.y-35), container: containerInit, placeHolderButton: placeHolderButton)
        triangleSqaudArray.add(leftDrone)
        
        let rightDrone:Drone = Drone(drone: CGPoint(x:targetPosition.x+35,y:targetPosition.y+35), container: containerInit, placeHolderButton: placeHolderButton)
        triangleSqaudArray.add(rightDrone)
    }
}

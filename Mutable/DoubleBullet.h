//
//  DoubleBullet.h
//  Mutable
//
//  Created by Dylan Shackelford on 7/27/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//


#import "Bullet.h"

@interface DoubleBullet : Bullet
{
    double bulletOneX;
    double bulletOneY;
    double bulletOneTargetX;
    double bulletOneTargetY;
    
    double bulletTwoX;
    double bulletTwoY;
    double bulletTwoTargetX;
    double bulletTwoTargetY;
}

-(NSMutableArray*)createDoubleBullet:(HeadLink*)headLinkInit container:(UIView*)container placeHolder:(UIButton*)placeHolderButtonInit Target:(CGPoint)targetInit;


//-(UIImageView*)makeDoubleBulletImage;


@end
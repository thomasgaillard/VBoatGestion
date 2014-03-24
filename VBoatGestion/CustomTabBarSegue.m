//
//  CustomTabBarSegue.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 24/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "CustomTabBarSegue.h"
#import "CustomTabBarViewController.h"

@implementation CustomTabBarSegue

- (void) perform {
    
    CustomTabBarViewController *src = (CustomTabBarViewController *)self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    
    for(UIView *view in src.placeholderView.subviews){
        [view removeFromSuperview];
    }
    
    src.currentViewController = dst;
    [src.placeholderView addSubview:dst.view];
}

@end

//
//  CustomTabBarViewController.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 24/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBarViewController : UIViewController

@property (weak, nonatomic) UIViewController *currentViewController;
@property (weak, nonatomic) IBOutlet UIView *placeholderView;
@property (weak, nonatomic) IBOutlet UIView *buttons;


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end

//
//  ViewController.m
//  VBoatGestion
//
//  Created by Thomas Gaillard on 14/01/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "CustomTabBarViewController.h"

@interface CustomTabBarViewController ()

@end

@implementation CustomTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"HomeSegue"]
       || [segue.identifier isEqualToString:@"HeartSegue"]
       || [segue.identifier isEqualToString:@"CogSegue"]){
        
        for (int i=0; i<[self.buttons.subviews count];i++) {
            UIButton *button = (UIButton *)[self.buttons.subviews objectAtIndex:i];
            [button setSelected:NO];
        }
        
        UIButton *button = (UIButton *)sender;
        [button setSelected:YES];
    }
}

@end

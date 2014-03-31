//
//  CustomTabBarViewController.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 24/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "CustomTabBarViewController.h"

@interface CustomTabBarViewController ()

@end

@implementation CustomTabBarViewController

@synthesize currentViewController;
@synthesize placeholderView;
@synthesize buttons;
@synthesize lblDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSegueWithIdentifier:@"segActivite" sender:[self.buttons.subviews objectAtIndex:0]];
    
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];
    formatter.timeZone = destinationTimeZone;
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    [lblDate setText:[formatter stringFromDate:date]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"segActivite"]
       || [segue.identifier isEqualToString:@"segFacturation"]
       || [segue.identifier isEqualToString:@"segReservations"]
       || [segue.identifier isEqualToString:@"segFlotte"]
       || [segue.identifier isEqualToString:@"segPrix"]
       || [segue.identifier isEqualToString:@"segAdministration"]
       || [segue.identifier isEqualToString:@"segReglages"]){
        
        for (int i=0; i<[self.buttons.subviews count];i++) {
            UIButton *button = (UIButton *)[self.buttons.subviews objectAtIndex:i];
            [button setSelected:NO];
        }
        
        UIButton *button = (UIButton *)sender;
        [button setSelected:YES];
    }
}

@end

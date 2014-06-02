//
//  ReservationViewController.m
//  VBoatGestion
//
//  Created by Thomas Gaillard on 02/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "ReservationViewController.h"

@interface ReservationViewController ()

@end

@implementation ReservationViewController

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
    NSString *urlText = @"http://v-boat.fr/bateaux/pedalo.php?valid=ok";
    [_resaWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlText]]];
    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

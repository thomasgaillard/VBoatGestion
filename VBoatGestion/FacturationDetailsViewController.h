//
//  FacturationDetailsViewController.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 07/04/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facture.h"
#import "FacturationSelectionDelegate.h"

@interface FacturationDetailsViewController : UIViewController <FacturationSelectionDelegate>

@property (strong, nonatomic) Facture *facture;
@property (weak, nonatomic) IBOutlet UILabel *labelFacture;

-(void)rafraichir;
@end

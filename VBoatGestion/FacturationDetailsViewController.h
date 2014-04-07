//
//  FacturationDetailsViewController.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 07/04/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "Facture.h"
#import "Embarcation.h"
#import "FacturationSelectionDelegate.h"
#import "FacturationTableViewLocationCell.h"

@interface FacturationDetailsViewController : UIViewController <FacturationSelectionDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Facture *facture;
@property (strong, nonatomic) NSArray *listeLocations;
@property (weak, nonatomic) IBOutlet UILabel *prixTxt;
@property (weak, nonatomic) IBOutlet UILabel *etatTxt;
@property (weak, nonatomic) IBOutlet UITextField *remarquesTxt;
@property (weak, nonatomic) IBOutlet UITableView *chaqueLocsFacture;

-(void)rafraichir;
@end

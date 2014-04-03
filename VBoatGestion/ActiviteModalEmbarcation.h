//
//  ActiviteModalEmbarcation.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 02/04/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Embarcation.h"
#import "Pedalo.h"
#import "Bateau.h"
#import "Location.h"
#import "AppDelegate.h"

@interface ActiviteModalEmbarcation : UIViewController

@property (nonatomic, strong)Embarcation *embarcation ;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;

@property (weak, nonatomic) IBOutlet UILabel *nomEmbarcation;
@property (weak, nonatomic) IBOutlet UILabel *etatEmbarcation;
@property (weak, nonatomic) IBOutlet UITextField *remarquesLoc;
@property (weak, nonatomic) IBOutlet UITextField *hDebutLoc;
@property (weak, nonatomic) IBOutlet UITextField *hFinLoc;
@property (weak, nonatomic) IBOutlet UITextField *nbPersonnesLoc;
@property (weak, nonatomic) IBOutlet UILabel *typeOuNb;
@property (weak, nonatomic) IBOutlet UILabel *nbPlacesLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nbPersonnesLocLabel;
@property (weak, nonatomic) IBOutlet UILabel *titreLabel;

- (IBAction)closeModalButton:(id)sender;
- (IBAction)saveModalInfos:(id)sender;

@end

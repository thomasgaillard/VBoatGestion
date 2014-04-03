//
//  ActiviteModalEmbarcation.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 02/04/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Embarcation.h"
#import "Location.h"
#import "AppDelegate.h"

@interface ActiviteModalEmbarcation : UIViewController

@property (nonatomic, strong)Embarcation *embarcation ;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UILabel *nomEmbarcation;
@property (weak, nonatomic) IBOutlet UILabel *etatEmbarcation;
@property (weak, nonatomic) IBOutlet UILabel *nbPlacesPedalo;
@property (weak, nonatomic) IBOutlet UITextField *remarquesLoc;
@property (weak, nonatomic) IBOutlet UITextField *hDebutLoc;
@property (weak, nonatomic) IBOutlet UITextField *hFinLoc;
@property (weak, nonatomic) IBOutlet UITextField *nbPersonnesLoc;
@property (weak, nonatomic) IBOutlet UILabel *typeBateau;

- (IBAction)closeModalButton:(id)sender;
- (IBAction)saveModalInfos:(id)sender;

@end

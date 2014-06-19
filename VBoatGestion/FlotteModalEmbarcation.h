//
//  FlotteModalEmbarcation.h
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
#import "FlotteViewController.h"

@interface FlotteModalEmbarcation : UIViewController

@property (nonatomic, strong)Embarcation *embarcation ;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)NSArray *types ;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (weak, nonatomic) IBOutlet UITextField *nomText;

@property (weak, nonatomic) IBOutlet UITextField *nbPersonnesLoc;
@property (weak, nonatomic) IBOutlet UILabel *typeOuNb;
@property (weak, nonatomic) IBOutlet UILabel *nbPersonnesLocLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *idBeaconsLabel;
@property (weak, nonatomic) IBOutlet UITextField *majorTxt;
@property (weak, nonatomic) IBOutlet UITextField *minorTxt;
@property (weak, nonatomic) IBOutlet UIButton *supprBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *selectionType;


- (IBAction)closeModal:(id)sender;
- (IBAction)saveModalInfos:(id)sender;
- (IBAction)supprimerEmb:(id)sender;
-(void)saveContext;
-(void)saveInfos;

@end

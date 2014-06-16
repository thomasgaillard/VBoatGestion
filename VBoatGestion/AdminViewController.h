//
//  AdminViewController.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 15/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Journee;

@interface AdminViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Journee *journee;
@property (strong, nonatomic) NSArray *arrayJourneeEnCours;
@property (strong, nonatomic) NSArray *arrayFacturesRemisees;
@property (strong, nonatomic) NSDecimalNumber *totalRemises;

@property (weak, nonatomic) IBOutlet UIButton *finDJ;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UITextField *pwdTxt;
@property (weak, nonatomic) IBOutlet UILabel *pwdIncorrect;
- (IBAction)valider:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ongletJournee;
@property (weak, nonatomic) IBOutlet UIButton *ongletSaison;
@property (weak, nonatomic) IBOutlet UIView *ongletSaisonView;
@property (weak, nonatomic) IBOutlet UIView *ongletJourneeView;

@property (weak, nonatomic) IBOutlet UILabel *nbLocsTxt;
@property (weak, nonatomic) IBOutlet UILabel *totalEspecesTxt;
@property (weak, nonatomic) IBOutlet UILabel *totalCbTxt;
@property (weak, nonatomic) IBOutlet UILabel *totalTxt;
@property (weak, nonatomic) IBOutlet UILabel *remisesTxt;

- (IBAction)finDeJournee:(id)sender;
- (IBAction)ongletJourneeBtn:(id)sender;
- (IBAction)ongletSaisonBtn:(id)sender;

@end

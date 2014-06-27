//
//  ComptaViewController.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 19/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComptaViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *choixMoisSC;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *arrayJournees;
@property (strong, nonatomic) NSMutableArray *arrayMois;
@property (strong, nonatomic) NSMutableArray *arrayJoursMoiEnCours;
@property (strong, nonatomic) NSString *moisEnCours;
- (IBAction)changeMois:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titreMois;

@property (weak, nonatomic) IBOutlet UILabel *locMoyenne;
@property (weak, nonatomic) IBOutlet UILabel *especesMoyenne;
@property (weak, nonatomic) IBOutlet UILabel *cbMoyenne;
@property (weak, nonatomic) IBOutlet UILabel *totalMoyenne;

@property (weak, nonatomic) IBOutlet UILabel *totalMois;
@property (weak, nonatomic) IBOutlet UILabel *cbMois;
@property (weak, nonatomic) IBOutlet UILabel *especesMois;
@property (weak, nonatomic) IBOutlet UILabel *locMois;

@property (weak, nonatomic) IBOutlet UILabel *titreTotaux;
@property (weak, nonatomic) IBOutlet UILabel *titreMoyenne;
@property (strong, nonatomic) NSDecimalNumber *totalMoisNumber;
@property (strong, nonatomic) NSDecimalNumber *cbMoisNumber;
@property (strong, nonatomic) NSDecimalNumber *especesMoisNumber;
@property (strong, nonatomic) NSDecimalNumber *locMoisNumber;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *nbLocsAdd;
@property (weak, nonatomic) IBOutlet UITextField *especesAdd;
@property (weak, nonatomic) IBOutlet UITextField *cbAdd;
- (IBAction)ajouterJournee:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *exporter;

@property (weak, nonatomic) IBOutlet UIButton *finDJ;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UITextField *pwdTxt;
@property (weak, nonatomic) IBOutlet UILabel *pwdIncorrect;
@property (weak, nonatomic) IBOutlet UIView *devOnglet;
- (IBAction)valider:(id)sender;
- (IBAction)finDeSaisonBtn:(id)sender;

@end

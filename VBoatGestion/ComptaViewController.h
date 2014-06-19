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

@property (strong, nonatomic) NSDecimalNumber *totalMoisNumber;
@property (strong, nonatomic) NSDecimalNumber *cbMoisNumber;
@property (strong, nonatomic) NSDecimalNumber *especesMoisNumber;
@property (strong, nonatomic) NSDecimalNumber *locMoisNumber;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

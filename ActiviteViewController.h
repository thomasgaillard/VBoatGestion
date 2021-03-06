//
//  ActiviteViewController.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Journee;

@interface ActiviteViewController : UIViewController

@property (nonatomic,strong)NSArray* embarcationsArray;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblBateaux;
@property (strong, nonatomic) IBOutlet UILabel *lblPedalos;
@property (strong, nonatomic) IBOutlet UILabel *lblEspeces;
@property (strong, nonatomic) IBOutlet UILabel *lblCb;
@property (weak, nonatomic) IBOutlet UILabel *commencerJournee;
@property (strong, nonatomic) Journee *journee;
@property (strong, nonatomic) NSArray *arrayJourneeEnCours;
@property (weak, nonatomic) IBOutlet UIView *viewNouvelleJournee;
-(void)modalDismiss;
- (IBAction)creerJournee:(id)sender;


@end

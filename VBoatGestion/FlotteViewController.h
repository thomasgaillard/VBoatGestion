//
//  ActiviteViewController.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlotteViewController : UIViewController

@property (nonatomic,strong)NSArray* embarcationsArray;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UILabel *pwdIncorrect;
@property (weak, nonatomic) IBOutlet UITextField *pwdTxt;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
- (IBAction)valider:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblBateaux;
@property (strong, nonatomic) IBOutlet UILabel *lblPedalos;
@property (strong, nonatomic) IBOutlet UILabel *lblEspeces;
@property (strong, nonatomic) IBOutlet UILabel *lblCb;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
-(void)modalDismiss;


@end

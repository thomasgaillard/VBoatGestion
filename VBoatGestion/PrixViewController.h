//
//  ActiviteViewController.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Type;

@interface PrixViewController : UIViewController

@property (nonatomic,strong)NSArray* grillesPrixArray;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)Type* type;
@property (weak, nonatomic) IBOutlet UIButton *ajoutGrilleBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *selectionType;
@property (weak, nonatomic) IBOutlet UILabel *pwdIncorrect;
@property (weak, nonatomic) IBOutlet UITextField *pwdTxt;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UILabel *mdpinc;
- (IBAction)valider:(id)sender;
- (IBAction)ajoutType:(id)sender;
- (IBAction)ajoutGrille:(id)sender;
- (IBAction)supprType:(id)sender;


@property (nonatomic, strong)NSArray *types ;
-(void)modalDismiss;


@end

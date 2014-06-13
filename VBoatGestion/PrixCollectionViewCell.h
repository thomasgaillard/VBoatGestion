//
//  PrixCollectionViewCell.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 02/04/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Prix;

@interface PrixCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UILabel *heureLabel;
@property (weak, nonatomic) IBOutlet UITextField *montantTxt;
@property (weak, nonatomic) Prix *prix;
- (IBAction)startEdit:(id)sender;

@end

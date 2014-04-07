//
//  ActiviteViewController.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActiviteViewController : UICollectionViewController

@property (nonatomic,strong)NSArray* embarcationsArray;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblBateaux;
@property (strong, nonatomic) IBOutlet UILabel *lblPedalos;
@property (strong, nonatomic) IBOutlet UILabel *lblEspeces;
@property (strong, nonatomic) IBOutlet UILabel *lblCb;
- (IBAction)doubleClik:(id)sender;


@end

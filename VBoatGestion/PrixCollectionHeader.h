//
//  PrixCollectionHeader.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 13/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GrillePrix;

@interface PrixCollectionHeader : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UITextField *titreGrille;
@property (nonatomic,strong)GrillePrix* grille;

- (IBAction)modifTitreGrille:(id)sender;

@end

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


@end

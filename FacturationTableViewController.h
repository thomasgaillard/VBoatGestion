//
//  FacturationTableViewController.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 07/04/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacturationSelectionDelegate.h"
#import "FacturationDetailsViewController.h"


@interface FacturationTableViewController : UITableViewController

@property (nonatomic,strong)NSMutableArray* facturesArray;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, assign) id<FacturationSelectionDelegate> delegate;

-(void)reloadFactures;

@end

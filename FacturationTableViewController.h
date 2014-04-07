//
//  FacturationTableViewController.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 07/04/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacturationTableViewController : UITableViewController

@property (nonatomic,strong)NSArray* facturesArray;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

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

@property (weak, nonatomic) IBOutlet UIButton *optionGrouperBtn;
@property (weak, nonatomic) IBOutlet UIButton *optionAnnulerBtn;

- (IBAction)optionAnnuler:(id)sender;
- (IBAction)optionGrouper:(id)sender;
-(void)reloadFactures;

@end

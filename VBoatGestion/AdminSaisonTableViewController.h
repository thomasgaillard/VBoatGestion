//
//  AdminSaisonTableViewController.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 18/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminSaisonTableViewController : UIViewController

@property (strong, nonatomic) NSArray *arrayFactProblemes;
@property (strong, nonatomic) NSMutableArray *arrayFactRemisees;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

//
//  FacturationSelectionDelegate.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 07/04/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Facture;
@class FacturationTableViewController;

@protocol FacturationSelectionDelegate <NSObject>
@required
-(void)selectedFacture:(Facture *)facture :(UITableView *) tableView :(NSUInteger *)indexPath :(NSMutableArray*) facturesArray;

@end

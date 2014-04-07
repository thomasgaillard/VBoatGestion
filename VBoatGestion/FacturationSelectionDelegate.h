//
//  FacturationSelectionDelegate.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 07/04/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Facture;

@protocol FacturationSelectionDelegate <NSObject>
@required
-(void)selectedFacture:(Facture *)facture;

@end

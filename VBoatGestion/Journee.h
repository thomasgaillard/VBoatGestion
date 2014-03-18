//
//  Journee.h
//  VBoatGestion
//
//  Created by Thomas Gaillard on 18/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Journee : NSObject

@property NSDate *date;
@property NSDecimalNumber *totalCb;
@property NSDecimalNumber *totalEspeces;
@property NSDecimalNumber *nbLocBateaux;
@property NSDecimalNumber *nbLocPedalos;
@property NSString *etat;
@property NSMutableArray *listeFactures;

-(void)initierJournee;
-(void)cloturerJournee;

@end
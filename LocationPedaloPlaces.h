//
//  LocationPedaloPlaces.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 04/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Location.h"


@interface LocationPedaloPlaces : Location

@property (nonatomic, retain) NSDecimalNumber * nbPersonnes;

-(NSDecimalNumber*)calculerPrix;
-(void)modifierNbPersonnes:(NSDecimalNumber*)nbPersonnes;

@end

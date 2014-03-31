//
//  LocationBateau.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Location.h"

@interface LocationBateau : Location

@property (nonatomic, retain) NSString * type;

-(NSDecimalNumber*)calculerPrix;

@end

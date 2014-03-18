//
//  LocationBateau.h
//  VBoatGestion
//
//  Created by Thomas Gaillard on 18/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Location.h"

@interface LocationBateau : Location

@property NSString *type;

-(NSDecimalNumber*)calculerPrix;

@end

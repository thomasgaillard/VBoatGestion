//
//  Bateau.m
//  VBoatGestion
//
//  Created by Thomas Gaillard on 18/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Bateau.h"
#import "LocationBateau.h"

@implementation Bateau

-(void)rendreDisponible{
    [super rendreDisponible];
    [self affecterLocation:[LocationBateau new]];
}

-(void)affecterLocation:(LocationBateau*)loc{
    [super affecterLocation:loc];
    loc.type = self.type;
}

@end

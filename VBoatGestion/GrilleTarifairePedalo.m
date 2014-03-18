//
//  GrilleTarifairePedalo.m
//  VBoatGestion
//
//  Created by Thomas Gaillard on 18/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "GrilleTarifairePedalo.h"

static NSMutableArray* prix;

@implementation GrilleTarifairePedalo

+ (NSMutableArray*)prix {
    return prix;
}

+ (void)prix:(NSMutableArray*)nouveauPrix {
    if (prix != nouveauPrix) {
    	prix = [nouveauPrix copy];
    }
}

@end

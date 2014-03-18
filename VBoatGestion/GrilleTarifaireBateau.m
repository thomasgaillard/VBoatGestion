//
//  GrilleTarifaireBateau.m
//  VBoatGestion
//
//  Created by Thomas Gaillard on 18/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "GrilleTarifaireBateau.h"

static NSMutableArray* prix;

@implementation GrilleTarifaireBateau

+ (NSMutableArray*)prix {
    return prix;
}

+ (void)prix:(NSMutableArray*)nouveauPrix {
    if (prix != nouveauPrix) {
    	prix = [nouveauPrix copy];
    }
}

@end

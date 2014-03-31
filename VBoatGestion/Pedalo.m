//
//  Pedalo.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Pedalo.h"
#import "LocationPedalo.h"

@implementation Pedalo

@dynamic nbPlaces;

-(void)rendreDisponible{
    [super rendreDisponible];
    [self affecterLocation:[LocationPedalo new]];
}

-(void)affecterLocation:(LocationPedalo*)loc{
    [super affecterLocation:loc];
    loc.nbPersonnes = self.nbPlaces;
}

@end

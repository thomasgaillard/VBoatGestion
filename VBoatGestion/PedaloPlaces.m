//
//  PedaloPlaces.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 04/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "PedaloPlaces.h"
#import "LocationPedaloPlaces.h"
#import "Type.h"


@implementation PedaloPlaces

@dynamic nbPlaces;

-(void)affecterLocation:(LocationPedaloPlaces*)loc{
    [super affecterLocation:loc];
    loc.nbPersonnes = self.nbPlaces;
}

-(NSString*)getNbPlacesOuType{
    return [NSString stringWithFormat:@"%@", self.nbPlaces];
}

-(void)setNbPlacesOuType:(NSString*) nbPlacesOuType{
    self.nbPlaces = [NSDecimalNumber decimalNumberWithString:nbPlacesOuType];
}

@end

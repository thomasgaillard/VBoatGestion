//
//  LocationPedalo.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "LocationPedalo.h"
#import "GrilleTarifairePedalo.h"


@implementation LocationPedalo

@dynamic nbPersonnes;

-(NSDecimalNumber*)calculerPrix{
    return [GrilleTarifairePedalo calculerPrix:self.heureDebut :self.heureFin :self.nbPersonnes];
}

-(void)modifierNbPersonnes:(NSDecimalNumber*)nbPersonnes{
    self.nbPersonnes = nbPersonnes;
}

-(void)setNbPlacesOuType:(NSString*) nbOuType{
    NSDecimalNumber *places = [NSDecimalNumber decimalNumberWithString:nbOuType];
    self.nbPersonnes = places;
}

-(NSString*)getNbPlacesOuType{
    return [NSString stringWithFormat:@"%@",self.nbPersonnes];;
}


@end

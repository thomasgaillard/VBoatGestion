//
//  Pedalo.m
//  VBoatGestion
//
//  Created by Thomas Gaillard on 18/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Pedalo.h"
#import "LocationPedalo.h"

@implementation Pedalo

-(void)rendreDisponible{
    self.etat=@"disponible";
    NSLog(@"Fonction disponible, etat : %@",self.etat);
    [self affecterLocation:[LocationPedalo new]];
}

-(void)affecterLocation:(LocationPedalo*)loc{
    [super affecterLocation:loc];
    loc.nbPersonnes = self.nbPlaces;
}

@end

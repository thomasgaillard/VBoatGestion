//
//  Embarcation.m
//  VBoatGestion
//
//  Created by Thomas Gaillard on 17/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Embarcation.h"
#import "Location.h"

@implementation Embarcation

-(void)depart{
    self.etat=@"enlocation";
    [self.location lancerLocation];
}

-(void)retour{
    self.etat=@"disponible";
    [self.location cloturerLocation];
    [self affecterLocation:[Location new]];
}

-(void)rendreIndisponible{
    self.etat=@"indisponible";
}

-(void)rendreDisponible{
    self.etat=@"disponible";
}

-(void)affecterLocation:(Location*)loc{
    self.location = loc;
    [self.location affecterEmbarcation: self];
}

@end

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
    NSLog(@"Fonction depart, etat : %@",self.etat);
    [self.location lancerLocation];
}

-(void)retour{
    self.etat=@"disponible";
    NSLog(@"Fonction retour, etat : %@",self.etat);
    [self.location cloturerLocation];
    [self affecterLocation:[Location new]];
}

-(void)rendreIndisponible{
    self.etat=@"indisponible";
    NSLog(@"Fonction indisponible, etat : %@",self.etat);
}

-(void)rendreDisponible{
    self.etat=@"disponible";
    NSLog(@"Fonction disponible, etat : %@",self.etat);
    [self affecterLocation:[Location new]];
}

-(void)affecterLocation:(Location*)loc{
    self.location = loc;
    [self.location affecterEmbarcation: self];
}

@end

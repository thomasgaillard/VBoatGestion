//
//  Embarcation.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 20/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Embarcation.h"
#import "Location.h"
#import "Type.h"


@implementation Embarcation

@dynamic etat;
@dynamic nom;
@dynamic major;
@dynamic minor;
@dynamic uuid;
@dynamic location;
@dynamic type;

-(void)depart{
    self.etat=@"enlocation";
    NSLog(@"Fonction depart, etat : %@",self.etat);
    [self.location lancerLocation];
}

-(void)rendreIndisponible{
    self.etat=@"indisponible";
    NSLog(@"Fonction indisponible, etat : %@",self.etat);
    self.location = Nil;
}

-(void)rendreDisponible{
    self.location.remarque=@"Nouvelle location";
    self.etat=@"disponible";
    
    [self.location setNbPlacesOuType:[self getNbPlacesOuType]];
    [self.location affecterEmbarcation:self];
    
    NSLog(@"Fonction disponible, etat : %@",self.etat);
}


-(NSString*)getNbPlacesOuType{
    return self.type.nom;
}

-(void)setNbPlacesOuType:(Type*) nbPlacesOuType{
    self.type = nbPlacesOuType;
}

-(void)setPlaces:(NSString *)nb{
    NSLog(@"PAS ICI");
}


@end

//
//  Location.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 04/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Location.h"
#import "Embarcation.h"
#import "Facture.h"


@implementation Location

@dynamic heureDebut;
@dynamic heureFin;
@dynamic remarque;
@dynamic embarcation;

-(void)lancerLocation{
    self.heureDebut=[NSDate date];
    //self.heureDebut=[NSDate dateWithTimeIntervalSinceNow:-62*60];
    NSLog(@"Loc début, heure : %@",self.heureDebut);
}

-(void)cloturerLocation:(Facture*)fact{
    self.heureFin=[NSDate date];
    NSLog(@"Loc fin, heure : %@",self.heureFin);
    [fact ajouterLocation:self];
}

-(void)affecterEmbarcation:(Embarcation*)emb{
    NSLog(@"Loc affecter embarcation");
    self.embarcation = emb;
}

-(NSDecimalNumber*)calculerPrix{
    NSLog(@"Loc calcul prix dans classe mère location = PAS BIEN");
    return [NSDecimalNumber decimalNumberWithString:@"-1"];
}

-(NSString*)getNbPlacesOuType{
    //return self.type;
    return 0;
}

-(void)setNbPlacesOuType:(NSString*) nbOuType{
    //self.type = nbOuType;
}


@end

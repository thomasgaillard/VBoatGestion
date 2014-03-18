//
//  Location.m
//  VBoatGestion
//
//  Created by Thomas Gaillard on 17/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Location.h"
#import "Embarcation.h"
#import "Facture.h"

@implementation Location

-(void)lancerLocation{
    self.heureDebut=[NSDate date];
    NSLog(@"evasucemoi bordel");
    [self creerFacture];
}

-(void)cloturerLocation{
    self.heureFin=[NSDate date];
    [self creerFacture];
}

-(void)affecterEmbarcation:(Embarcation*)emb{
    self.embarcation = emb;
}

-(NSNumber*)calculerPrix{
    return [NSNumber numberWithInt:10000];
}

-(void)creerFacture{
    Facture *f=[Facture new];
    [f ajouterLocation:self];
}

@end

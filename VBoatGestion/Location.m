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
    NSLog(@"Loc début, heure : %@",self.heureDebut);
}

-(void)cloturerLocation{
    self.heureFin=[NSDate date];
    NSLog(@"Loc fin, heure : %@",self.heureFin);
    [self creerFacture];
}

-(void)affecterEmbarcation:(Embarcation*)emb{
    NSLog(@"Loc affecter embarcation");
    self.embarcation = emb;
}

-(NSNumber*)calculerPrix{
    NSNumber *prix = [NSNumber numberWithInt:10000];
    NSLog(@"Loc calcul prix, prix : %@", prix);
    return prix;
}

-(void)creerFacture{
    NSLog(@"Loc creer facture");
    Facture *f=[Facture new];
    [f ajouterLocation:self];
}

@end

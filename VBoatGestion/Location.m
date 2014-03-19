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

-(Facture*)cloturerLocation{
    self.heureFin=[NSDate date];
    NSLog(@"Loc fin, heure : %@",self.heureFin);
    return [self creerFacture];
}

-(void)affecterEmbarcation:(Embarcation*)emb{
    NSLog(@"Loc affecter embarcation");
    self.embarcation = emb;
}

-(NSDecimalNumber*)calculerPrix{
    NSDecimalNumber *prix = [NSDecimalNumber decimalNumberWithString:@"10000"];
    NSLog(@"Loc calcul prix, prix : %@", prix);
    return prix;
}

-(Facture*)creerFacture{
    NSLog(@"Loc creer facture");
    Facture *f=[Facture new];
    [f ajouterLocation:self];
    return f;
}

@end

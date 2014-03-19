//
//  Journee.m
//  VBoatGestion
//
//  Created by Thomas Gaillard on 18/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Journee.h"
#import "Embarcation.h"
#import "Facture.h"

@implementation Journee

-(void)initierJournee{
    self.date = [NSDate date];
    self.totalCb = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.totalEspeces = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.nbLocBateaux = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.nbLocPedalos = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.listeFacturesEnCours=[[NSMutableArray alloc] init];
    self.listeFacturesCloturees=[[NSMutableArray alloc] init];
    self.etat = @"encours";
}

-(void)tests{
    
}

-(void)cloturerJournee{
    self.etat = @"terminee";
}

-(void)ajouterFacture:(Facture*) fact {
    fact.journee = self;
    [self.listeFacturesEnCours removeObject:fact];
    [self.listeFacturesCloturees removeObject:fact];
    if([fact.etat  isEqual: @"encours"]){
        [self.listeFacturesEnCours addObject:fact];
    }else if ([fact.etat  isEqual: @"cloturee"]){
        [self.listeFacturesCloturees addObject:fact];
    }
    NSLog(@"Facture ajoutée en cours %lu",(unsigned long)self.listeFacturesEnCours.count);
    NSLog(@"Facture ajoutée cloturee %lu",(unsigned long)self.listeFacturesCloturees.count);
}

@end

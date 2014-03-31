//
//  Journee.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Journee.h"
#import "Facture.h"

@implementation Journee

@dynamic date;
@dynamic etat;
@dynamic nbLocBateaux;
@dynamic nbLocPedalos;
@dynamic totalCb;
@dynamic totalEspeces;
@dynamic factures;

-(void)initierJournee{
    self.date = [NSDate date];
    self.totalCb = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.totalEspeces = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.nbLocBateaux = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.nbLocPedalos = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.factures=[[NSMutableSet alloc] init];
    self.etat = @"encours";
}

-(void)cloturerJournee{
    self.etat = @"terminee";
}

-(void)ajouterFacture:(Facture*) fact {
    //TODO fact.journee = self;
    [self removeFacturesObject:fact];
    if([fact.etat  isEqual: @"encours"]){
        [self addFacturesObject:fact];
    }//else if ([fact.etat  isEqual: @"payee"]||[fact.etat  isEqual: @"annulee"]){
       // [self.listeFacturesCloturees addObject:fact];
    NSLog(@"Facture ajoutée en cours %lu",(unsigned long)self.factures.count);
}


@end

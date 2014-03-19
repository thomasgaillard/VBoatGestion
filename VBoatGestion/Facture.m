//
//  Facture.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 18/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Facture.h"
#import "Location.h"
#import "Paiement.h"
#import "Journee.h"

@implementation Facture

-(id)init{
    self = [super init];
    self.prixTotal = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.etat = @"encours";
    self.listeLocations=[[NSMutableArray alloc] init];
    self.listePaiements=[[NSMutableArray alloc] init];
    return self;
}
-(void)grouperFactures:(Facture*) fac{
}

-(void)ajouterPaiement:(NSString*) moyenPaiement :(NSDecimalNumber*) somme{
    Paiement *paiement=[[Paiement alloc]initPaiement:moyenPaiement :somme];
    NSLog(@"Nouveau paiement: moyen %@, somme %@",paiement.moyenPaiement ,paiement.montant);
    [self.listePaiements addObject:paiement];
    [self calculerResteAPayer];
}
-(void)ajouterLocation:(Location *)loc{
    self.prixTotal = [self.prixTotal decimalNumberByAdding:[loc calculerPrix]];
    [self.listeLocations addObject:loc];
}
-(void)calculerResteAPayer{
    NSDecimalNumber *reste = self.prixTotal;
    NSLog(@"Fonction reste à payer %@, %lu", reste, (unsigned long)self.listePaiements.count);
    for(Paiement *pay in self.listePaiements){
        reste = [reste decimalNumberBySubtracting:pay.montant];
        NSLog(@"Calcul reste à payer : %@",reste);
    }
    if([reste doubleValue] == 0.0)
    {
        [self cloturerFacture];
    }
}

-(void)recommencerPaiement{
    
}

-(void)cloturerFacture{
    NSLog(@"Cloturer Facture");
    self.etat=@"cloturee";
    [self.journee ajouterFacture:self];
}

-(void)annulerFacture{
    
}

-(void)ajouterPaiementAuTotalJournee{
    
}

@end

//
//  Facture.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Facture.h"
#import "Journee.h"
#import "Location.h"
#import "Paiement.h"


@implementation Facture

@dynamic etat;
@dynamic prixTotal;
@dynamic remarque;
@dynamic remise;
@dynamic journee;
@dynamic locations;
@dynamic paiements;

-(id)init{
    self = [super init];
    self.prixTotal = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.etat = @"encours";
    self.locations=[[NSMutableSet alloc] init];
    self.paiements=[[NSMutableSet alloc] init];
    return self;
}
-(void)grouperFactures:(Facture*) fac{
    NSLog(@"Grouper factures");
    //TODO
    /*Location *l = [self.locations firstObject];
    for(Location *loc in fac.locations){
        if (loc.embarcation == l.embarcation) {
            l.heureFin=loc.heureFin;
        }else
            [self ajouterLocation:loc];
    }*/
}

-(void)ajouterPaiement:(NSString*) moyenPaiement :(NSDecimalNumber*) somme{
    Paiement *paiement=[[Paiement alloc]initPaiement:moyenPaiement :somme];
    NSLog(@"Nouveau paiement: moyen %@, somme %@",paiement.moyenPaiement ,paiement.montant);
    [self addPaiementsObject:paiement];
    [self calculerResteAPayer];
}
-(void)ajouterLocation:(Location *)loc{
    //self.prixTotal = [self.prixTotal decimalNumberByAdding:[loc calculerPrix]];
    [self addLocationsObject:loc];
}
-(void)calculerResteAPayer{
    NSDecimalNumber *reste = self.prixTotal;
    NSLog(@"Fonction reste à payer %@, %lu", reste, (unsigned long)self.paiements.count);
    for(Paiement *pay in self.paiements){
        reste = [reste decimalNumberBySubtracting:pay.montant];
        NSLog(@"Calcul reste à payer : %@",reste);
    }
    if([reste doubleValue] == 0.0)
    {
        [self cloturerFacture];
    }
}

-(void)recommencerPaiement{
    //TODO
    //[self.paiements removeAllObjects];
}

-(void)cloturerFacture{
    NSLog(@"Cloturer Facture");
    self.etat=@"payee";
    [self.journee ajouterFacture:self];
    [self ajouterPaiementAuTotalJournee];
}

-(void)annulerFacture{
    NSLog(@"Annuler Facture");
    self.etat=@"annulee";
    [self.journee ajouterFacture:self];
}

-(void)ajouterPaiementAuTotalJournee{
    NSLog(@"Ajouter paiements au total");
    for(Paiement *pay in self.paiements){
        if([pay.moyenPaiement  isEqual: @"especes"]){
            [self.journee.totalEspeces decimalNumberByAdding:pay.montant];
        }else if([pay.moyenPaiement  isEqual: @"cb"]){
            [self.journee.totalCb decimalNumberByAdding:pay.montant];
        }
    }
}


@end

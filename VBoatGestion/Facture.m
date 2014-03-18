//
//  Facture.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 18/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Facture.h"
#import "Location.h"

@implementation Facture

-(id)init{
    NSLog(@"Facture new");
    self = [super init];
    
    self.listeLocations=[self.listeLocations init];
    self.listePaiements=[self.listePaiements init];
    return self;
}
-(void)grouperFactures:(Facture*) fac{
}

-(void)ajouterPaiement:(NSString*) moyenPaiement :(NSDecimalNumber*) somme{
    
}
-(void)ajouterLocation:(Location *)loc{
    NSDecimalNumber *prixTotal = [prixTotal decimalNumberByAdding:[loc calculerPrix]];
    NSLog(@"Prix Total : %@",self.prixTotal);
    [self.listeLocations addObject:loc];
   
    
}
-(void)calculerResteAPayer{
    
}

-(void)recommencerPaiement{
    
}

-(void)cloturerFacture{
    
}

-(void)annulerFacture{
    
}

-(void)ajouterPaiementAuTotalJournee{
    
}

@end

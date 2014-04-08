//
//  Paiement.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Paiement.h"


@implementation Paiement

@dynamic montant;
@dynamic moyenPaiement;

-(void)initPaiement:(NSString *)moyenP :(NSDecimalNumber *)somme{

        self.moyenPaiement=moyenP;
        self.montant=somme;
        NSLog(@"Init Paiement");

}

@end

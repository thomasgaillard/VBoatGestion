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

-(id)initPaiement:(NSString *)moyenP :(NSDecimalNumber *)somme{
    if(self = [super init])
    {
        self.moyenPaiement=moyenP;
        self.montant=somme;
        NSLog(@"Init Paiement");
    }
    return self;
}

@end

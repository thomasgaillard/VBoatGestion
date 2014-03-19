//
//  Paiement.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 18/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Paiement : NSObject

@property NSString *moyenPaiement;
@property NSDecimalNumber *montant;

-(id)initPaiement:(NSString*) moyenP :(NSDecimalNumber*)somme;

@end

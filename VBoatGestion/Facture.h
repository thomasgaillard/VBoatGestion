//
//  Facture.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 18/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Location;

@interface Facture : NSObject

@property NSNumber *id;
@property NSString *etat;
@property NSMutableArray *listeLocations;
@property NSDecimalNumber *prixTotal;
@property NSDecimalNumber *remise;
@property NSMutableArray *listePaiements;
@property NSString *remarque;

-(id)init;
-(void)grouperFactures:(Facture*) fac;
-(void)ajouterPaiement:(NSString*) moyenPaiement :(NSDecimalNumber*) somme;
-(void)ajouterLocation:(Location*) loc;
-(void)calculerResteAPayer;
-(void)recommencerPaiement;
-(void)cloturerFacture;
-(void)annulerFacture;
-(void)ajouterPaiementAuTotalJournee;


@end

//
//  Facture.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 18/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Facture : NSObject

@property NSNumber *id;
@property NSString *etat;
@property NSMutableArray *listeLocations;
@property NSNumber *prixTotal;
@property NSNumber *remise;
@property NSMutableArray *listePaiements;
@property NSString *remarqie;

-(void)grouperFactures:(Facture*) fac;
-(void)ajouterPaiement:(NSString*) moyenPaiement :(NSNumber*) somme;
-(void)calculerResteAPayer;
-(void)recommencerPaiement;
-(void)cloturerFacture;
-(void)annulerFacture;
-(void)ajouterPaiementAuTotalJournee;

@end

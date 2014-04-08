//
//  Facture.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Journee, Location, Paiement;

@interface Facture : NSManagedObject

@property (nonatomic, retain) NSString * etat;
@property (nonatomic, retain) NSDecimalNumber * prixTotal;
@property (nonatomic, retain) NSString * remarque;
@property (nonatomic, retain) NSDecimalNumber * remise;
@property (nonatomic, retain) Journee *journee;
@property (nonatomic, retain) NSSet *locations;
@property (nonatomic, retain) NSSet *paiements;

-(id)init;
-(void)grouperFactures:(Facture*) fac;
-(void)ajouterPaiement:(Paiement*)paiement :(NSString*) moyenPaiement :(NSDecimalNumber*) somme;
-(void)ajouterLocation:(Location*) loc;
-(NSDecimalNumber*)calculerResteAPayer;
-(void)recommencerPaiement;
-(void)cloturerFacture;
-(void)annulerFacture;
-(void)ajouterPaiementAuTotalJournee;

@end

@interface Facture (CoreDataGeneratedAccessors)

- (void)addLocationsObject:(Location *)value;
- (void)removeLocationsObject:(Location *)value;
- (void)addLocations:(NSSet *)values;
- (void)removeLocations:(NSSet *)values;

- (void)addPaiementsObject:(Paiement *)value;
- (void)removePaiementsObject:(Paiement *)value;
- (void)addPaiements:(NSSet *)values;
- (void)removePaiements:(NSSet *)values;

@end

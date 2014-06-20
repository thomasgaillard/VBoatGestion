//
//  Journee.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 20/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Facture;

@interface Journee : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * etat;
@property (nonatomic, retain) NSDecimalNumber * fondDeCaisse;
@property (nonatomic, retain) NSDecimalNumber * nbLocBateaux;
@property (nonatomic, retain) NSDecimalNumber * nbLocPedalos;
@property (nonatomic, retain) NSDecimalNumber * totalCb;
@property (nonatomic, retain) NSDecimalNumber * totalEspeces;
@property (nonatomic, retain) NSSet *factures;

-(void)initierJournee;
-(void)cloturerJournee;
-(void)ajouterFacture:(Facture*) fact;
-(void)ajouterPaiements:(Facture*) fact;

@end

@interface Journee (CoreDataGeneratedAccessors)

- (void)addFacturesObject:(Facture *)value;
- (void)removeFacturesObject:(Facture *)value;
- (void)addFactures:(NSSet *)values;
- (void)removeFactures:(NSSet *)values;

@end

//
//  Journee.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Facture;
@interface Journee : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * etat;
@property (nonatomic, retain) NSDecimalNumber * nbLocBateaux;
@property (nonatomic, retain) NSDecimalNumber * nbLocPedalos;
@property (nonatomic, retain) NSDecimalNumber * totalCb;
@property (nonatomic, retain) NSDecimalNumber * totalEspeces;
@property (nonatomic, retain) NSSet *factures;

-(void)initierJournee;
-(void)cloturerJournee;
-(void)ajouterFacture:(Facture*) fact;

@end

@interface Journee (CoreDataGeneratedAccessors)

- (void)addFacturesObject:(NSManagedObject*)value;
- (void)removeFacturesObject:(NSManagedObject*)value;
- (void)addFactures:(NSSet *)values;
- (void)removeFactures:(NSSet *)values;

@end

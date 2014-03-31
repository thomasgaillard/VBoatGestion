//
//  VBoatGestion.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Journee;

@interface Saison : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * annee;
@property (nonatomic, retain) NSOrderedSet *journees;
@end

@interface  Saison (CoreDataGeneratedAccessors)

- (void)insertObject:(Journee *)value inJourneesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromJourneesAtIndex:(NSUInteger)idx;
- (void)insertJournees:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeJourneesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInJourneesAtIndex:(NSUInteger)idx withObject:(Journee *)value;
- (void)replaceJourneesAtIndexes:(NSIndexSet *)indexes withJournees:(NSArray *)values;
- (void)addJourneesObject:(Journee *)value;
- (void)removeJourneesObject:(Journee *)value;
- (void)addJournees:(NSOrderedSet *)values;
- (void)removeJournees:(NSOrderedSet *)values;
@end

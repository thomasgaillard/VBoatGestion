//
//  GrillePrix.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 04/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Prix;

@interface GrillePrix : NSManagedObject

@property (nonatomic, retain) NSString * identifiantFacturation;
@property (nonatomic, retain) NSOrderedSet *grille;
@end

@interface GrillePrix (CoreDataGeneratedAccessors)

- (void)insertObject:(Prix *)value inGrilleAtIndex:(NSUInteger)idx;
- (void)removeObjectFromGrilleAtIndex:(NSUInteger)idx;
- (void)insertGrille:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeGrilleAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInGrilleAtIndex:(NSUInteger)idx withObject:(Prix *)value;
- (void)replaceGrilleAtIndexes:(NSIndexSet *)indexes withGrille:(NSArray *)values;
- (void)addGrilleObject:(Prix *)value;
- (void)removeGrilleObject:(Prix *)value;
- (void)addGrille:(NSOrderedSet *)values;
- (void)removeGrille:(NSOrderedSet *)values;
@end

//
//  Type.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 13/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GrillePrix;

@interface Type : NSManagedObject

@property (nonatomic, retain) NSString * nom;
@property (nonatomic, retain) NSOrderedSet *grillePrix;
@end

@interface Type (CoreDataGeneratedAccessors)

- (void)insertObject:(GrillePrix *)value inGrillePrixAtIndex:(NSUInteger)idx;
- (void)removeObjectFromGrillePrixAtIndex:(NSUInteger)idx;
- (void)insertGrillePrix:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeGrillePrixAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInGrillePrixAtIndex:(NSUInteger)idx withObject:(GrillePrix *)value;
- (void)replaceGrillePrixAtIndexes:(NSIndexSet *)indexes withGrillePrix:(NSArray *)values;
- (void)addGrillePrixObject:(GrillePrix *)value;
- (void)removeGrillePrixObject:(GrillePrix *)value;
- (void)addGrillePrix:(NSOrderedSet *)values;
- (void)removeGrillePrix:(NSOrderedSet *)values;
@end

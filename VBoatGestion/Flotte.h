//
//  Flotte.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Flotte : NSManagedObject

@property (nonatomic, retain) NSSet *embarcations;
@end

@interface Flotte (CoreDataGeneratedAccessors)

- (void)addEmbarcationsObject:(NSManagedObject *)value;
- (void)removeEmbarcationsObject:(NSManagedObject *)value;
- (void)addEmbarcations:(NSSet *)values;
- (void)removeEmbarcations:(NSSet *)values;

@end

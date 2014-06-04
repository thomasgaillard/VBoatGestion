//
//  Type.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 04/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GrillePrix;

@interface Type : NSManagedObject

@property (nonatomic, retain) NSString * nom;
@property (nonatomic, retain) NSSet *grillePrix;
@end

@interface Type (CoreDataGeneratedAccessors)

- (void)addGrillePrixObject:(GrillePrix *)value;
- (void)removeGrillePrixObject:(GrillePrix *)value;
- (void)addGrillePrix:(NSSet *)values;
- (void)removeGrillePrix:(NSSet *)values;

@end

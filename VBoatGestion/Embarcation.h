//
//  Embarcation.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Embarcation : NSManagedObject

@property (nonatomic, retain) NSString * etat;
@property (nonatomic, retain) NSString * nom;
@property (nonatomic, retain) NSManagedObject *location;

@end

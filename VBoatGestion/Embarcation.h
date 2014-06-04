//
//  Embarcation.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 04/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Location, Type;

@interface Embarcation : NSManagedObject

@property (nonatomic, retain) NSString * etat;
@property (nonatomic, retain) NSString * nom;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) Type *type;

-(void)depart;
-(void)rendreIndisponible;
-(void)rendreDisponible;
-(void)affecterLocation:(Location*) loc;
-(NSString*)getNbPlacesOuType;
-(void)setNbPlacesOuType:(NSString*) nbPlacesOuType;

@end

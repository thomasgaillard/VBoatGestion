//
//  Embarcation.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Facture;
@class Location;
@interface Embarcation : NSManagedObject

@property (nonatomic, retain) NSString * etat;
@property (nonatomic, retain) NSString * nom;
@property (nonatomic, retain) Location *location;



-(void)depart;
-(Facture*)retour;
-(void)rendreIndisponible;
-(void)rendreDisponible;
-(void)affecterLocation:(Location*) loc;
-(NSString*)getNbPlacesOuType;

@end

//
//  Location.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 04/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Embarcation, Facture;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSDate * heureDebut;
@property (nonatomic, retain) NSDate * heureFin;
@property (nonatomic, retain) NSString * remarque;
@property (nonatomic, retain) Embarcation *embarcation;

-(void)lancerLocation;
-(void)cloturerLocation:(Facture*)fact;
-(void)affecterEmbarcation:(Embarcation*)emb;
-(NSDecimalNumber*)calculerPrix;
-(NSDecimalNumber*)calcul:(NSDate*)hD :(NSDate*)hF;
-(void)setNbPlacesOuType:(NSString*) nbOuType;
-(NSString*)getNbPlacesOuType;

@end

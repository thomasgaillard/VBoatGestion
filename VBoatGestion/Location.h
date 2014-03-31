//
//  Location.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Embarcation;
@class Facture;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSDate * heureDebut;
@property (nonatomic, retain) NSDate * heureFin;
@property (nonatomic, retain) NSString * remarque;
@property (nonatomic, retain) Embarcation *embarcation;

-(void)lancerLocation;
-(Facture*)cloturerLocation;
-(void)affecterEmbarcation:(Embarcation*)emb;
-(NSDecimalNumber*)calculerPrix;
-(Facture*)creerFacture;

@end

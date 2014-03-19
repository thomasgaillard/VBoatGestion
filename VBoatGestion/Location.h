//
//  Location.h
//  VBoatGestion
//
//  Created by Thomas Gaillard on 17/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Embarcation;
@class Facture;

@interface Location : NSObject

@property NSNumber *id;
@property Embarcation *embarcation;
@property NSDate *heureDebut;
@property NSDate *heureFin;
@property NSString *remarque;

-(void)lancerLocation;
-(Facture*)cloturerLocation;
-(void)affecterEmbarcation:(Embarcation*)emb;
-(NSDecimalNumber*)calculerPrix;
-(Facture*)creerFacture;

@end
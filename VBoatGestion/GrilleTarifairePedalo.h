//
//  GrilleTarifairePedalo.h
//  VBoatGestion
//
//  Created by Thomas Gaillard on 18/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrilleTarifairePedalo : NSObject

+ (NSMutableArray*)prix;
+ (void)prix:(NSMutableArray*)nouveauPrix;
+ (void)tableauPrices;
+(NSDecimalNumber*)calculerPrix:(NSDate*)heureDebut :(NSDate*)heureFin : (NSDecimalNumber*)nbPersonnes;

@end

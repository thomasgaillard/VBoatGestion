//
//  Embarcation.h
//  VBoatGestion
//
//  Created by Thomas Gaillard on 17/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface Embarcation : NSObject

@property NSNumber *id;
@property NSString *nom;
@property NSString *etat;
@property Location *location;

-(void)depart;
-(void)retour;
-(void)rendreIndisponible;
-(void)rendreDisponible;
-(void)affecterLocation:(Location*)loc;

@end

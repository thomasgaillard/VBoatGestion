//
//  Bateau.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Bateau.h"
#import "LocationBateau.h"

@implementation Bateau

@dynamic type;


-(void)affecterLocation:(LocationBateau*)loc{
    [super affecterLocation:loc];
    loc.type = self.type;
}

-(NSString*)getNbPlacesOuType{
    return self.type;
}

-(void)setNbPlacesOuType:(NSString*) nbPlacesOuType{
    self.type = nbPlacesOuType;
}

@end

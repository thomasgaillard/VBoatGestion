//
//  LocationBateau.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "LocationBateau.h"


@implementation LocationBateau

@dynamic type;

-(NSDecimalNumber*)calculerPrix{
    return [NSDecimalNumber decimalNumberWithString:@"10000"];
}

-(NSString*)getNbPlacesOuType{
    return self.type;
}


@end

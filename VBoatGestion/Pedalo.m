//
//  Pedalo.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Pedalo.h"
#import "LocationPedalo.h"

@implementation Pedalo

@dynamic nbPlaces;

-(void)rendreDisponible{
    [super rendreDisponible];
    LocationPedalo *lp=[NSEntityDescription insertNewObjectForEntityForName:@"LocationPedalo"
                                                     inManagedObjectContext:self.managedObjectContext];
    [self affecterLocation:lp];
    
}

-(void)affecterLocation:(LocationPedalo*)loc{
    [super affecterLocation:loc];
    loc.nbPersonnes = self.nbPlaces;
}

-(NSString*)getNbPlacesOuType{
    return [NSString stringWithFormat:@"%@",self.nbPlaces];
}




@end

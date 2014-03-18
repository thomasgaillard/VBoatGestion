//
//  Location.m
//  VBoatGestion
//
//  Created by Thomas Gaillard on 17/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Location.h"
#import "Embarcation.h"

@implementation Location

-(void)lancerLocation{
    self.heureDebut=[NSDate date];
    NSLog(@"Start location, heure: %@",self.heureDebut);
}

-(void)cloturerLocation{
    self.heureFin=[NSDate date];
    NSLog(@"End location, heure: %@",self.heureFin);
}

-(void)affecterEmbarcation:(Embarcation*)emb{
    self.embarcation = emb;
}

-(NSNumber*)calculerPrix{
    return [NSNumber numberWithInt:10000];
}

-(void)creerFacture{
    
}

@end

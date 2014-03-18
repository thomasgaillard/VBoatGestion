//
//  Journee.m
//  VBoatGestion
//
//  Created by Thomas Gaillard on 18/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Journee.h"

@implementation Journee

-(void)initierJournee{
    self.date = [NSDate date];
    self.totalCb = [NSNumber numberWithInt:0];
    self.totalEspeces = [NSNumber numberWithInt:0];
    self.nbLocBateaux = [NSNumber numberWithInt:0];
    self.nbLocPedalos = [NSNumber numberWithInt:0];
    self.etat = @"encours";
}

-(void)cloturerJournee{
    self.etat = @"terminee";
}

@end

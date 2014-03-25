//
//  LocationPedalo.m
//  VBoatGestion
//
//  Created by Thomas Gaillard on 18/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "LocationPedalo.h"
#import "GrilleTarifairePedalo.h"

@implementation LocationPedalo

-(NSDecimalNumber*)calculerPrix{
    NSInteger duree = [self.heureFin timeIntervalSinceDate:self.heureDebut]/60;
    NSLog(@"Intervalle : %ld", (long)duree);
    NSInteger caseDuree=0;
    if(duree <= 37){
        caseDuree=0;
    } else if (duree <=52){
        caseDuree=1;
    } else if (duree <=67){
        caseDuree=2;
    } else if (duree <=82){
        caseDuree=3;
    } else if (duree <=97){
        caseDuree=4;
    } else if (duree <=112){
        caseDuree=5;
    } else if (duree <=127){
        caseDuree=6;
    } else if (duree <=142){
        caseDuree=7;
    } else if (duree <=157){
        caseDuree=8;
    } else if (duree <=172){
        caseDuree=9;
    } else if (duree <=187){
        caseDuree=10;
    } else if (duree <=202){
        caseDuree=11;
    } else if (duree <=217){
        caseDuree=12;
    } else if (duree <=232){
        caseDuree=13;
    } else if (duree <=247){
        caseDuree=14;
    }else{
        caseDuree=15;
        NSInteger *quartsH = (duree+7)/15;
        NSLog(@"Nb quarts d'heures: %i",quartsH);
        
       // NSDecimalNumber *prix = quartsH*[[[GrilleTarifairePedalo prix]objectAtIndex:[self.nbPersonnes doubleValue]-2] objectAtIndex:caseDuree];
       // NSLog(@"Prix : %@", prix);
    }
    return [[[GrilleTarifairePedalo prix]objectAtIndex:[self.nbPersonnes doubleValue]-2] objectAtIndex:caseDuree];
}

-(void)modifierNbPersonnes:(NSDecimalNumber*)nbPersonnes{
    self.nbPersonnes = nbPersonnes;
}


@end

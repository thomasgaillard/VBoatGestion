//
//  LocationPedalo.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "LocationPedalo.h"
#import "GrilleTarifairePedalo.h"


@implementation LocationPedalo

@dynamic nbPersonnes;

-(NSDecimalNumber*)calculerPrix{
    
    NSDecimalNumber *dureeDecimal = [[NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:[self.heureFin timeIntervalSinceDate:self.heureDebut]] decimalValue]] decimalNumberByDividingBy: [NSDecimalNumber decimalNumberWithString:@"60"]];
    
    //test >4h
    //NSDecimalNumber *dureeDecimal = [[NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:14850] decimalValue]] decimalNumberByDividingBy: [NSDecimalNumber decimalNumberWithString:@"60"]];
    
    //arrondi temps
    NSDecimalNumberHandler *handlerMid = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                                scale:0
                                                                                     raiseOnExactness:NO
                                                                                      raiseOnOverflow:NO
                                                                                     raiseOnUnderflow:NO
                                                                                  raiseOnDivideByZero:NO];
    dureeDecimal = [dureeDecimal decimalNumberByRoundingAccordingToBehavior:handlerMid];
    
    NSInteger duree = [dureeDecimal integerValue];
    
    NSLog(@"Intervalle : %ld", (long)duree);
    NSLog(@"Intervalle : %@", dureeDecimal);
    
    //selection duree
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
        
        NSDecimalNumber *nbQuartH = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:(duree+7)/15] decimalValue]];
        NSLog(@"Nb quarts d'heures: %@",nbQuartH);
        
        NSDecimalNumber *prixQuartH = [NSDecimalNumber decimalNumberWithDecimal:[[[[GrilleTarifairePedalo prix]objectAtIndex:[self.nbPersonnes doubleValue]-2] objectAtIndex:caseDuree] decimalValue]];
        NSLog(@"Prix quart d'heure: %@",prixQuartH);
        
        //arrondi supérieur
        NSDecimalNumberHandler *handlerUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundUp
                                                                                                   scale:0
                                                                                        raiseOnExactness:NO
                                                                                         raiseOnOverflow:NO
                                                                                        raiseOnUnderflow:NO
                                                                                     raiseOnDivideByZero:NO];
        NSDecimalNumber *total = [nbQuartH decimalNumberByMultiplyingBy:prixQuartH];
        
        //retour prix >4h
        return [total decimalNumberByRoundingAccordingToBehavior:handlerUp];
    }
    //retour prix <4h
    return [[[GrilleTarifairePedalo prix]objectAtIndex:[self.nbPersonnes doubleValue]-2] objectAtIndex:caseDuree];
}

-(void)modifierNbPersonnes:(NSDecimalNumber*)nbPersonnes{
    self.nbPersonnes = nbPersonnes;
}

@end

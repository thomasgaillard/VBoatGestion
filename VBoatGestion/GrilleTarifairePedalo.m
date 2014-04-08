//
//  GrilleTarifairePedalo.m
//  VBoatGestion
//
//  Created by Thomas Gaillard on 18/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "GrilleTarifairePedalo.h"

static NSMutableArray* prix;

@implementation GrilleTarifairePedalo

+ (NSMutableArray*)prix {
    return prix;
}

+ (void)prix:(NSMutableArray*)nouveauPrix {
    if (prix != nouveauPrix) {
    	prix = [nouveauPrix copy];
    }
}

+ (void)tableauPrices{
    NSMutableArray* grille = [[NSMutableArray alloc] init];
    
    NSMutableArray* pedalo2places = [[NSMutableArray alloc] init];
    [pedalo2places addObject:[NSDecimalNumber decimalNumberWithString:@"12"]];
    [pedalo2places addObject:[NSDecimalNumber decimalNumberWithString:@"15"]];
    [pedalo2places addObject:[NSDecimalNumber decimalNumberWithString:@"18"]];
    [pedalo2places addObject:[NSDecimalNumber decimalNumberWithString:@"22"]];
    [pedalo2places addObject:[NSDecimalNumber decimalNumberWithString:@"26"]];
    [pedalo2places addObject:[NSDecimalNumber decimalNumberWithString:@"30"]];
    [pedalo2places addObject:[NSDecimalNumber decimalNumberWithString:@"34"]];
    [pedalo2places addObject:[NSDecimalNumber decimalNumberWithString:@"38"]];
    [pedalo2places addObject:[NSDecimalNumber decimalNumberWithString:@"42"]];
    [pedalo2places addObject:[NSDecimalNumber decimalNumberWithString:@"46"]];
    [pedalo2places addObject:[NSDecimalNumber decimalNumberWithString:@"50"]];
    [pedalo2places addObject:[NSDecimalNumber decimalNumberWithString:@"54"]];
    [pedalo2places addObject:[NSDecimalNumber decimalNumberWithString:@"58"]];
    [pedalo2places addObject:[NSDecimalNumber decimalNumberWithString:@"62"]];
    [pedalo2places addObject:[NSDecimalNumber decimalNumberWithString:@"66"]];
    [pedalo2places addObject:[NSDecimalNumber decimalNumberWithString:@"4.125"]];
    
    NSMutableArray* pedalo3places = [[NSMutableArray alloc] init];
    [pedalo3places addObject:[NSDecimalNumber decimalNumberWithString:@"14"]];
    [pedalo3places addObject:[NSDecimalNumber decimalNumberWithString:@"17"]];
    [pedalo3places addObject:[NSDecimalNumber decimalNumberWithString:@"20"]];
    [pedalo3places addObject:[NSDecimalNumber decimalNumberWithString:@"24"]];
    [pedalo3places addObject:[NSDecimalNumber decimalNumberWithString:@"28"]];
    [pedalo3places addObject:[NSDecimalNumber decimalNumberWithString:@"33"]];
    [pedalo3places addObject:[NSDecimalNumber decimalNumberWithString:@"38"]];
    [pedalo3places addObject:[NSDecimalNumber decimalNumberWithString:@"43"]];
    [pedalo3places addObject:[NSDecimalNumber decimalNumberWithString:@"47"]];
    [pedalo3places addObject:[NSDecimalNumber decimalNumberWithString:@"52"]];
    [pedalo3places addObject:[NSDecimalNumber decimalNumberWithString:@"56"]];
    [pedalo3places addObject:[NSDecimalNumber decimalNumberWithString:@"61"]];
    [pedalo3places addObject:[NSDecimalNumber decimalNumberWithString:@"65"]];
    [pedalo3places addObject:[NSDecimalNumber decimalNumberWithString:@"70"]];
    [pedalo3places addObject:[NSDecimalNumber decimalNumberWithString:@"74"]];
    [pedalo3places addObject:[NSDecimalNumber decimalNumberWithString:@"4.625"]];
    
    NSMutableArray* pedalo4places = [[NSMutableArray alloc] init];
    [pedalo4places addObject:[NSDecimalNumber decimalNumberWithString:@"16"]];
    [pedalo4places addObject:[NSDecimalNumber decimalNumberWithString:@"19"]];
    [pedalo4places addObject:[NSDecimalNumber decimalNumberWithString:@"22"]];
    [pedalo4places addObject:[NSDecimalNumber decimalNumberWithString:@"26"]];
    [pedalo4places addObject:[NSDecimalNumber decimalNumberWithString:@"30"]];
    [pedalo4places addObject:[NSDecimalNumber decimalNumberWithString:@"36"]];
    [pedalo4places addObject:[NSDecimalNumber decimalNumberWithString:@"42"]];
    [pedalo4places addObject:[NSDecimalNumber decimalNumberWithString:@"47"]];
    [pedalo4places addObject:[NSDecimalNumber decimalNumberWithString:@"51"]];
    [pedalo4places addObject:[NSDecimalNumber decimalNumberWithString:@"56"]];
    [pedalo4places addObject:[NSDecimalNumber decimalNumberWithString:@"60"]];
    [pedalo4places addObject:[NSDecimalNumber decimalNumberWithString:@"66"]];
    [pedalo4places addObject:[NSDecimalNumber decimalNumberWithString:@"71"]];
    [pedalo4places addObject:[NSDecimalNumber decimalNumberWithString:@"77"]];
    [pedalo4places addObject:[NSDecimalNumber decimalNumberWithString:@"82"]];
    [pedalo4places addObject:[NSDecimalNumber decimalNumberWithString:@"5.125"]];
    
    NSMutableArray* pedalo5places = [[NSMutableArray alloc] init];
    [pedalo5places addObject:[NSDecimalNumber decimalNumberWithString:@"18"]];
    [pedalo5places addObject:[NSDecimalNumber decimalNumberWithString:@"21"]];
    [pedalo5places addObject:[NSDecimalNumber decimalNumberWithString:@"24"]];
    [pedalo5places addObject:[NSDecimalNumber decimalNumberWithString:@"28"]];
    [pedalo5places addObject:[NSDecimalNumber decimalNumberWithString:@"32"]];
    [pedalo5places addObject:[NSDecimalNumber decimalNumberWithString:@"39"]];
    [pedalo5places addObject:[NSDecimalNumber decimalNumberWithString:@"46"]];
    [pedalo5places addObject:[NSDecimalNumber decimalNumberWithString:@"51"]];
    [pedalo5places addObject:[NSDecimalNumber decimalNumberWithString:@"56"]];
    [pedalo5places addObject:[NSDecimalNumber decimalNumberWithString:@"61"]];
    [pedalo5places addObject:[NSDecimalNumber decimalNumberWithString:@"66"]];
    [pedalo5places addObject:[NSDecimalNumber decimalNumberWithString:@"70"]];
    [pedalo5places addObject:[NSDecimalNumber decimalNumberWithString:@"78"]];
    [pedalo5places addObject:[NSDecimalNumber decimalNumberWithString:@"84"]];
    [pedalo5places addObject:[NSDecimalNumber decimalNumberWithString:@"90"]];
    [pedalo5places addObject:[NSDecimalNumber decimalNumberWithString:@"5.625"]];
    
    NSMutableArray* pedaloT = [[NSMutableArray alloc] init];
    [pedaloT addObject:[NSDecimalNumber decimalNumberWithString:@"18"]];
    [pedaloT addObject:[NSDecimalNumber decimalNumberWithString:@"21"]];
    [pedaloT addObject:[NSDecimalNumber decimalNumberWithString:@"24"]];
    [pedaloT addObject:[NSDecimalNumber decimalNumberWithString:@"28"]];
    [pedaloT addObject:[NSDecimalNumber decimalNumberWithString:@"32"]];
    [pedaloT addObject:[NSDecimalNumber decimalNumberWithString:@"38"]];
    [pedaloT addObject:[NSDecimalNumber decimalNumberWithString:@"44"]];
    [pedaloT addObject:[NSDecimalNumber decimalNumberWithString:@"49"]];
    [pedaloT addObject:[NSDecimalNumber decimalNumberWithString:@"53"]];
    [pedaloT addObject:[NSDecimalNumber decimalNumberWithString:@"58"]];
    [pedaloT addObject:[NSDecimalNumber decimalNumberWithString:@"62"]];
    [pedaloT addObject:[NSDecimalNumber decimalNumberWithString:@"68"]];
    [pedaloT addObject:[NSDecimalNumber decimalNumberWithString:@"73"]];
    [pedaloT addObject:[NSDecimalNumber decimalNumberWithString:@"79"]];
    [pedaloT addObject:[NSDecimalNumber decimalNumberWithString:@"84"]];
    [pedaloT addObject:[NSDecimalNumber decimalNumberWithString:@"5.25"]];
    
    [grille addObject:pedalo2places];
    [grille addObject:pedalo3places];
    [grille addObject:pedalo4places];
    [grille addObject:pedalo5places];
    [grille addObject:pedaloT];
    
    [self prix:grille];
    
    NSLog(@"Prix ajoutés %lu",[grille count]);
    NSLog(@"Prix ajoutés %lu",[self.prix count]);
}

+(NSDecimalNumber*)calculerPrix:(NSDate*)heureDebut :(NSDate*)heureFin : (NSDecimalNumber*)nbPersonnes{
    
    NSDecimalNumber *dureeDecimal = [[NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:[heureFin timeIntervalSinceDate:heureDebut]] decimalValue]] decimalNumberByDividingBy: [NSDecimalNumber decimalNumberWithString:@"60"]];
    
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
        
        NSDecimalNumber *prixQuartH = [NSDecimalNumber decimalNumberWithDecimal:[[[[GrilleTarifairePedalo prix]objectAtIndex:[nbPersonnes doubleValue]-2] objectAtIndex:caseDuree] decimalValue]];
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
    return [[[self prix]objectAtIndex:[nbPersonnes doubleValue]-2] objectAtIndex:caseDuree];
}

@end

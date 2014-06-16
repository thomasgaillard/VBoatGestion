//
//  Location.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 04/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Location.h"
#import "Embarcation.h"
#import "Facture.h"
#import "Type.h"
#import "GrillePrix.h"
#import "Prix.h"


@implementation Location

@dynamic heureDebut;
@dynamic heureFin;
@dynamic remarque;
@dynamic embarcation;

-(void)lancerLocation{
    self.heureDebut=[NSDate date];
    self.heureDebut=[NSDate dateWithTimeIntervalSinceNow:-62*60];
    NSLog(@"Loc début, heure : %@",self.heureDebut);
}

-(void)cloturerLocation:(Facture*)fact{
    self.heureFin=[NSDate date];
    NSLog(@"Loc fin, heure : %@",self.heureFin);
    [fact ajouterLocation:self];
}

-(void)affecterEmbarcation:(Embarcation*)emb{
    NSLog(@"Loc affecter embarcation");
    self.embarcation = emb;
}

- (NSDecimalNumber*)calcul:(NSDate*)hD :(NSDate*)hF {
    //import grille
    GrillePrix *grilleP = [self.embarcation.type.grillePrix firstObject];
    NSArray *grille = [grilleP.grille array];
    Prix *p;
    
    NSDecimalNumber *dureeDecimal = [[NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:[hF timeIntervalSinceDate:hD]] decimalValue]] decimalNumberByDividingBy: [NSDecimalNumber decimalNumberWithString:@"60"]];
    
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
        
        p=[grille objectAtIndex:caseDuree];
        NSDecimalNumber *prixQuartH = [NSDecimalNumber decimalNumberWithString:p.montant];
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
    NSLog(@"%@",[grille objectAtIndex:caseDuree]);
    p=[grille objectAtIndex:caseDuree];
    return [NSDecimalNumber decimalNumberWithString:p.montant];
}

-(NSDecimalNumber*)calculerPrix{
    return [self calcul:self.heureDebut :(NSDate*)self.heureFin];
}



-(NSString*)getNbPlacesOuType{
    //return self.type;
    return 0;
}

-(void)setNbPlacesOuType:(NSString*) nbOuType{
    //self.type = nbOuType;
}


@end

//
//  Location.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Location.h"
#import "Embarcation.h"
#import "Facture.h"
#import "AppDelegate.h"


@implementation Location

@dynamic heureDebut;
@dynamic heureFin;
@dynamic remarque;
@dynamic embarcation;

-(void)lancerLocation{
    //self.heureDebut=[NSDate date];
    self.heureDebut=[NSDate dateWithTimeIntervalSinceNow:-62*60];
    NSLog(@"Loc début, heure : %@",self.heureDebut);
}

-(Facture*)cloturerLocation{
    self.heureFin=[NSDate date];
    NSLog(@"Loc fin, heure : %@",self.heureFin);
    return [self creerFacture];
}

-(void)affecterEmbarcation:(Embarcation*)emb{
    NSLog(@"Loc affecter embarcation");
    self.embarcation = emb;
}

-(NSDecimalNumber*)calculerPrix{
    NSLog(@"Loc calcul prix dans classe mère location = PAS BIEN");
    return [NSDecimalNumber decimalNumberWithString:@"-1"];
}

-(Facture*)creerFacture{
    NSLog(@"Loc creer facture");
    Facture *f=[Facture new];
    [f ajouterLocation:self];
    return f;
}

-(void)setNbPlacesOuType:(NSString*) nbOuType{
}
-(NSString*)getNbPlacesOuType{
    return @"Problème de type : classe Location instanciée";
}




@end

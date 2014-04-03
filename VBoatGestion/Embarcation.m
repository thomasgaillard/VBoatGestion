//
//  Embarcation.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Embarcation.h"
#import "Facture.h"
#import "Location.h"
#import "AppDelegate.h"


@implementation Embarcation

@dynamic etat;
@dynamic nom;
@dynamic location;

-(void)depart{
    self.etat=@"enlocation";
    NSLog(@"Fonction depart, etat : %@",self.etat);
    [self.location lancerLocation];
}

-(Facture*)retour{
    Facture *f=[self.location cloturerLocation];
    [self rendreDisponible];
    return f;
}

-(void)rendreIndisponible{
    self.etat=@"indisponible";
    NSLog(@"Fonction indisponible, etat : %@",self.etat);
    self.location = Nil;
}

-(void)rendreDisponible{
    
    //AppDelegate* appDelegate  = [UIApplication sharedApplication].delegate;
    //self.managedObjectContext = appDelegate.managedObjectContext;

    //self.location = appDelegate.returnInstantiateLoc;
    self.location.remarque=@"C222 :)";
    self.etat=@"disponible";
    
    
    
    
    NSLog(@"Fonction disponible, etat : %@",self.etat);
}

-(void)affecterLocation:(Location*)loc{
    //self.location = loc;
    //[self.location affecterEmbarcation: self];
}


@end

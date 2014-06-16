//
//  Journee.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "Journee.h"
#import "Facture.h"
#import "Paiement.h"

@implementation Journee

@dynamic date;
@dynamic etat;
@dynamic nbLocBateaux;
@dynamic nbLocPedalos;
@dynamic totalCb;
@dynamic totalEspeces;
@dynamic factures;

-(void)initierJournee{
    self.date = [NSDate date];
    self.totalCb = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.totalEspeces = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.nbLocBateaux = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.factures=[[NSMutableSet alloc] init];
    self.etat = @"encours";
}

-(void)cloturerJournee{
    self.etat = @"terminee";
}

-(void)ajouterFacture:(Facture*) fact {
    //TODO fact.journee = self;
    //[self removeFacturesObject:fact];
    
    if([fact.etat  isEqual: @"enCours"] || [fact.etat  isEqual: @"remisee"] || [fact.etat  isEqual: @"annulee"]){
        [self addFacturesObject:fact];
    }else
    {
        [self removeFacturesObject:fact];
    }//else if ([fact.etat  isEqual: @"payee"]||[fact.etat  isEqual: @"annulee"]){
       // [self.listeFacturesCloturees addObject:fact];
    NSLog(@"Facture ajoutée en cours %lu",(unsigned long)self.factures.count);
    
    
    
    
}

-(void)ajouterPaiements:(Facture*) fact {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd%20MMMM%20YYYY"];
    NSString *dateToday = [formatter stringFromDate:[NSDate date]];
    
    NSString *str = [NSString stringWithFormat:@"%lu",fact.locations.count];
    self.nbLocBateaux=[self.nbLocBateaux decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:str]];
    NSLog(@"Ajouter paiements au total");
    for(Paiement *pay in fact.paiements){
        
        if([pay.moyenPaiement  isEqual: @"Espèces"]){
            self.totalEspeces=[self.totalEspeces decimalNumberByAdding:pay.montant];
            NSLog(@"Pay1 %@ %@",pay.moyenPaiement,pay.montant);
            NSLog(@"Total : %@",self.totalEspeces);
        }else if([pay.moyenPaiement  isEqual: @"CB"]){
            self.totalCb=[self.totalCb decimalNumberByAdding:pay.montant];
        }
    }
    NSString *stringUrl = [NSString stringWithFormat:@"http://v-boat.fr/bateaux/mastercraft.php?date=%@&nbLoc=%@&totalE=%@&totalCB=%@",dateToday,self.nbLocBateaux,self.totalEspeces,self.totalCb];
    
    NSLog(stringUrl);
    
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // create and start the connection
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    if(nil == urlConnection) {
        NSLog(@"Couldn't create connection to url %@", url);
    }

}

-(void) connectionDidFinishLoading:(NSURLConnection*)connection {
    NSLog(@"Connect OK");
}

-(void) connection:(NSURLConnection*)connection didFailWithError:(NSError*)error {
    NSLog(@"Connect ERROR %@",error);
}


@end

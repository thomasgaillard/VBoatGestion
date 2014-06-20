//
//  AdminViewController.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 15/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "AdminViewController.h"
#import "Journee.h"
#import "AppDelegate.h"
#import "Facture.h"
#import "Paiement.h"
#import "Location.h"
#import "PedaloPlaces.h"
#import "LocationPedaloPlaces.h"

@interface AdminViewController ()

@end

@implementation AdminViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) rafraichir{
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    self.arrayJourneeEnCours = [appDelegate getAllJourneesEnCours];
    if ([self.arrayJourneeEnCours count]==0) {
        self.finDJ.enabled = NO;
        self.nouvelleJBtn.enabled=YES;
        self.fondDeCaisseNouvelleJ.enabled=YES;
    }else
    {
        self.journee = [self.arrayJourneeEnCours firstObject];
        self.arrayFacturesRemisees = [self.journee.factures allObjects];
        NSLog(@"Factures :%lu",(unsigned long)[self.journee.factures count]);
        self.finDJ.enabled = YES;
        self.nouvelleJBtn.enabled=NO;
        self.fondDeCaisseNouvelleJ.enabled=NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self rafraichir];
    self.ongletSaisonView.hidden=YES;
    self.ongletJourneeView.hidden=NO;
    self.ongletSaison.enabled=YES;
    self.ongletJournee.enabled=NO;
    self.pwdView.hidden=NO;
    self.pwdIncorrect.hidden=YES;
    self.pwdTxt.text=@"";
    
    self.nbLocsTxt.text=[NSString stringWithFormat:@"%@",self.journee.nbLocBateaux];
    self.totalEspecesTxt.text=[NSString stringWithFormat:@"%@ €",self.journee.totalEspeces];
    self.totalCbTxt.text=[NSString stringWithFormat:@"%@ €",self.journee.totalCb];
    self.totalTxt.text=[NSString stringWithFormat:@"%@ €",[self.journee.totalCb decimalNumberByAdding:self.journee.totalEspeces]];
    self.totalRemises=[NSDecimalNumber decimalNumberWithString:@"0"];
    for(Facture *fact in self.arrayFacturesRemisees){
        if ([fact.etat  isEqual: @"remisee"]) {
            self.totalRemises=[self.totalRemises decimalNumberByAdding:fact.remise];
        } else if ([fact.etat  isEqual: @"enCours"]){
            self.finDJ.enabled=NO;
        }
        
    }
    self.remisesTxt.text=[NSString stringWithFormat:@"%@ €",self.totalRemises];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveContext{
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)valider:(id)sender {
    if ([self.pwdTxt.text isEqual:@"VArnoux"]) {
        self.pwdView.hidden=YES;
    }else{
        self.pwdView.hidden=NO;
        self.pwdIncorrect.hidden=NO;
    }
}

- (IBAction)nouvelleJournee:(id)sender {
    Journee *jour = [NSEntityDescription insertNewObjectForEntityForName:@"Journee"
                                                      inManagedObjectContext:self.managedObjectContext];
    self.journee=jour;
    [self.journee initierJournee];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.arrayEmbarcations = [appDelegate getAllEmbarcations];
    for (Embarcation *emb in self.arrayEmbarcations) {
        if([emb isKindOfClass:[PedaloPlaces class]]){
            LocationPedaloPlaces *l = [NSEntityDescription insertNewObjectForEntityForName:@"LocationPedaloPlaces"
                                                                    inManagedObjectContext:self.managedObjectContext];
            emb.location = l;
        }
        else{
            Location *l = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
            emb.location = l;
        }
        [emb rendreDisponible];
    }
   
    //TODO
    self.fondDeCaisseNouvelleJ;
    
    [self saveContext];
    [self rafraichir];
}

- (IBAction)finDeJournee:(id)sender {
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [self.journee cloturerJournee];
    self.arrayEmbarcations = [appDelegate getAllEmbarcations];
    for (Embarcation *emb in self.arrayEmbarcations) {
        [emb rendreIndisponible];
    }
    self.arrayFactures = [appDelegate getAllFacts];
    for (Facture *fact in self.arrayFactures) {
        [self.managedObjectContext deleteObject:fact];
    }
    self.arrayPaiements = [appDelegate getAllPaiements];
    for (Paiement *pay in self.arrayPaiements) {
        [self.managedObjectContext deleteObject:pay];
    }
    self.arrayLocations = [appDelegate getAllLocs];
    for (Location *loc in self.arrayLocations) {
        [self.managedObjectContext deleteObject:loc];
    }
    [self saveContext];
    [self rafraichir];
}
@end

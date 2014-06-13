//
//  AppDelegate.m
//  VBoatGestion
//
//  Created by Thomas Gaillard on 14/01/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "AppDelegate.h"
#import "Journee.h"
#import "PedaloPlaces.h"
#import "Bateau.h"
#import "Facture.h"
#import "Location.h"
#import "Paiement.h"
#import "FacturationDetailsViewController.h"
#import "FacturationTableViewController.h"
#import "Prix.h"
#import "Type.h"
#import "GrillePrix.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Status bar text white
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    /*
    Journee *jour1 = [Journee new];
    [jour1 initierJournee];
    NSLog(@"coucou");
    Embarcation *test = [Embarcation new];
    Embarcation *test2 = [Embarcation new];
    [test rendreDisponible];
    [test2 rendreDisponible];
    [test depart];
    //sleep(3);
    Facture *fact=[test retour];
    [test2 depart];
    sleep(3);
    Facture *fac2=[test2 retour];
    
    Location *l1=[fact.listeLocations firstObject];
    NSLog(@"Heure de fin L1 : %@",l1.heureFin);
    Location *l2=[fac2.listeLocations firstObject];
    NSLog(@"Heure de fin L2 : %@",l2.heureFin);
    
    [fact grouperFactures:fac2];
    NSLog(@"Heure de fin L1 : %@",l1.heureFin);
    
    NSLog(@"Nb locations facture 1 : %lu",(unsigned long)[fact.listeLocations count]);
    NSLog(@"Prix total facture 1 : %@",fact.prixTotal);
    [jour1 ajouterFacture: fact];
    
    //paiements
    //[fact ajouterPaiement:@"especes" :[NSDecimalNumber decimalNumberWithString:@"5000"]];
    //[fact ajouterPaiement:@"especes" :[NSDecimalNumber decimalNumberWithString:@"5000"]];
    
    [GrilleTarifairePedalo tableauPrices];
    Pedalo *pedalo = [Pedalo new];
    pedalo.nbPlaces=[NSDecimalNumber decimalNumberWithString:@"4"];
    Pedalo *pedalo2 = [Pedalo new];
    [pedalo rendreDisponible];
    [pedalo2 rendreDisponible];
    [pedalo depart];
    sleep(3);
    Facture *fact=[pedalo retour];
    
    Location *l1=[fact.listeLocations firstObject];
    NSLog(@"Heure de fin L1 : %@",l1.heureFin);

    
    NSLog(@"Nb locations facture 1 : %lu",(unsigned long)[fact.listeLocations count]);
    NSLog(@"Prix total facture 1 : %@",fact.prixTotal);
    [jour1 ajouterFacture: fact];*/
    
    
    //TEST CORE DATA
    
    /*NSLog(@"Début");
    PedaloPlaces * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"PedaloPlaces"
                                                      inManagedObjectContext:self.managedObjectContext];
    //  2
    newEntry.nom = @"Pedalo 3";
    newEntry.nbPlaces = [NSDecimalNumber decimalNumberWithString:@"2"];
    newEntry.etat = @"indisponible";
    //  3
    //[newEntry rendreDisponible];*/
    
    /*NSLog(@"Fin");
    
    Type *paddle = [NSEntityDescription insertNewObjectForEntityForName:@"TypePaddle"
                                                        inManagedObjectContext:self.managedObjectContext];
    paddle.nom = @"Normal";
    Type *bateauM = [NSEntityDescription insertNewObjectForEntityForName:@"TypeBateau"
                                                 inManagedObjectContext:self.managedObjectContext];
    bateauM.nom = @"Marinello";
    Type *bateauC = [NSEntityDescription insertNewObjectForEntityForName:@"TypeBateau"
                                                  inManagedObjectContext:self.managedObjectContext];
    bateauC.nom = @"Conerro";
    Type *pedPl = [NSEntityDescription insertNewObjectForEntityForName:@"TypePedaloPlaces"
                                                  inManagedObjectContext:self.managedObjectContext];
    pedPl.nom = @"Places";
    Type *tob = [NSEntityDescription insertNewObjectForEntityForName:@"TypePedalo"
                                                inManagedObjectContext:self.managedObjectContext];
    tob.nom = @"Toboggan";
    Type *plong = [NSEntityDescription insertNewObjectForEntityForName:@"TypePedalo"
                                              inManagedObjectContext:self.managedObjectContext];
    plong.nom = @"Plongeoir";
    newEntry.type=pedPl;
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }*/
    
    /*Prix *p1 = [NSEntityDescription insertNewObjectForEntityForName:@"Prix"
                                             inManagedObjectContext:self.managedObjectContext];
    Prix *p2 = [NSEntityDescription insertNewObjectForEntityForName:@"Prix"
                                             inManagedObjectContext:self.managedObjectContext];
    p1.temps=@"15";
    p1.montant=@"12";
     
    p2.temps=@"30";
    p2.montant=@"15";
    
    GrillePrix *g1 = [NSEntityDescription insertNewObjectForEntityForName:@"GrillePrix"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    g1.identifiantFacturation=@"Pedalo1Place";
    [g1 addGrilleObject:p1];
    [g1 addGrilleObject:p2];
     
     Type *plong = [NSEntityDescription insertNewObjectForEntityForName:@"TypePedalo"
     inManagedObjectContext:self.managedObjectContext];
     plong.nom = @"Trampo";
    [plong addGrillePrixObject:g1];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }*/
        
    self.arrayEmbarcations = [self getAllEmbarcations];
    
    //Paiement *p1=[self.arrayPaiements firstObject];
    //NSDecimalNumber *dn = p1.montant;
    NSLog(@"Mes embarcations %lu", (unsigned long)self.arrayEmbarcations.count);
    
    self.arrayLocs = [self getAllLocs];
    
    //Paiement *p1=[self.arrayPaiements firstObject];
    //NSDecimalNumber *dn = p1.montant;
    NSLog(@"Mes locs %lu", (unsigned long)self.arrayLocs.count);
    
    self.arrayFacts = [self getAllFactsEnCours];

    //Paiement *p1=[self.arrayPaiements firstObject];
    //NSDecimalNumber *dn = p1.montant;
    NSLog(@"Mes factures %lu", (unsigned long)self.arrayFacts.count);
    
    self.arrayPaiements = [self getAllPaiements];
    
    //Paiement *p1=[self.arrayPaiements firstObject];
    //NSDecimalNumber *dn = p1.montant;
    NSLog(@"Mes paiements %lu", (unsigned long)self.arrayPaiements.count);
    
    self.arrayGrillesPrix = [self getAllGrillesPrix];
    
    //Paiement *p1=[self.arrayPaiements firstObject];
    //NSDecimalNumber *dn = p1.montant;
    NSLog(@"Mes grilles prix %lu", (unsigned long)self.arrayGrillesPrix.count);
    
    self.arrayTypes = [self getAllTypes];
    
    //Paiement *p1=[self.arrayPaiements firstObject];
    //NSDecimalNumber *dn = p1.montant;
    NSLog(@"Mes types %lu", (unsigned long)self.arrayTypes.count);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



//CORE DATA METHODS

// 1
- (NSManagedObjectContext *) managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return _managedObjectContext;
}

//2
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}

//3
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"VBoat-Gestion-iPad.sqlite"]];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil URL:storeUrl options:nil error:&error]) {
        /*Error for store creation should be handled in here*/
    }
    
    return _persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(NSArray*)getAllEmbarcations
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Embarcation"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Returning Fetched Records
    return fetchedRecords;
}

-(NSArray*)getAllLocs
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Location"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Returning Fetched Records
    return fetchedRecords;
}

-(NSArray*)getAllFactsEnCours
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Facture"
                                              inManagedObjectContext:self.managedObjectContext];
    // Set example predicate and sort orderings...
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"(etat LIKE[c] 'enCours' OR etat LIKE[c] 'payee')"];
    
    
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Returning Fetched Records
    return fetchedRecords;
}

-(NSArray*)getAllPaiements
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Paiement"
                                              inManagedObjectContext:self.managedObjectContext];

    
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Returning Fetched Records
    return fetchedRecords;
}

-(NSArray*)getAllGrillesPrix
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"GrillePrix"
                                              inManagedObjectContext:self.managedObjectContext];
    
    
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Returning Fetched Records
    return fetchedRecords;
}

-(NSArray*)getAllTypes
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Type"
                                              inManagedObjectContext:self.managedObjectContext];
    
    
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Returning Fetched Records
    return fetchedRecords;
}
-(NSArray*)getAllTypesBateau
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TypeBateau"
                                              inManagedObjectContext:self.managedObjectContext];
    
    
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Returning Fetched Records
    return fetchedRecords;
}
-(NSArray*)getAllTypesPedalo
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TypePedalo"
                                              inManagedObjectContext:self.managedObjectContext];
    
    
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Returning Fetched Records
    return fetchedRecords;
}
-(NSArray*)getAllTypesPedaloPlaces
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TypePedaloPlaces"
                                              inManagedObjectContext:self.managedObjectContext];
    
    
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Returning Fetched Records
    return fetchedRecords;
}
-(NSArray*)getAllTypesPaddle
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TypePaddle"
                                              inManagedObjectContext:self.managedObjectContext];
    
    
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Returning Fetched Records
    return fetchedRecords;
}

-(Location*)returnInstantiateLoc
{
    Location *loc = [NSEntityDescription insertNewObjectForEntityForName:@"LocationPedalo"
                                                inManagedObjectContext:self.managedObjectContext];
    return loc;
}


@end

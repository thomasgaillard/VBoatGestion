//
//  AppDelegate.m
//  VBoatGestion
//
//  Created by Thomas Gaillard on 14/01/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "AppDelegate.h"
#import "Journee.h"
#import "Pedalo.h"
#import "Facture.h"
#import "Location.h"
#import "GrilleTarifairePedalo.h"
#import "Paiement.h"

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
    
   /* NSLog(@"Début");
    Pedalo * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Pedalo"
                                                      inManagedObjectContext:self.managedObjectContext];
    //  2
    newEntry.nom = @"Pedalo 3";
    newEntry.nbPlaces = [NSDecimalNumber decimalNumberWithString:@"3"];
    newEntry.etat = @"enlocation";
    //  3
    //[newEntry rendreDisponible];
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    NSLog(@"Fin");*/
    
    self.arrayEmbarcations = [self getAllEmbarcations];
    
    //Paiement *p1=[self.arrayPaiements firstObject];
    //NSDecimalNumber *dn = p1.montant;
    NSLog(@"Mes embarcations %lu", (unsigned long)self.arrayEmbarcations.count);
    
    self.arrayLocs = [self getAllLocs];
    
    //Paiement *p1=[self.arrayPaiements firstObject];
    //NSDecimalNumber *dn = p1.montant;
    NSLog(@"Mes locs %lu", (unsigned long)self.arrayLocs.count);
    
    self.arrayFacts = [self getAllFacts];

    //Paiement *p1=[self.arrayPaiements firstObject];
    //NSDecimalNumber *dn = p1.montant;
    NSLog(@"Mes factures %lu", (unsigned long)self.arrayFacts.count);
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
                                               stringByAppendingPathComponent: @"VBoatGestion.sqlite"]];
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

-(NSArray*)getAllFacts
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Facture"
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

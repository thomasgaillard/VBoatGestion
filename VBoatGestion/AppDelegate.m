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

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    Journee *jour1 = [Journee new];
    [jour1 initierJournee];
    NSLog(@"coucou");
    /*Embarcation *test = [Embarcation new];
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
    //[fact ajouterPaiement:@"especes" :[NSDecimalNumber decimalNumberWithString:@"5000"]];*/
    
    [GrilleTarifairePedalo tableauPrices];
    Pedalo *pedalo = [Pedalo new];
    pedalo.nbPlaces=[NSDecimalNumber decimalNumberWithString:@"2"];
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
    [jour1 ajouterFacture: fact];
    
    
    
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

@end

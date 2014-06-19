//
//  AppDelegate.h
//  VBoatGestion
//
//  Created by Thomas Gaillard on 14/01/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Embarcation.h"

@class CustomTabBarViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator ;
@property (nonatomic,strong)NSArray* arrayEmbarcations;
@property (nonatomic,strong)NSArray* arrayLocs;
@property (nonatomic,strong)NSArray* arrayFacts;
@property (nonatomic,strong)NSArray* arrayPaiements;
@property (nonatomic,strong)NSArray* arrayGrillesPrix;
@property (nonatomic,strong)NSArray* arrayTypes;
@property (nonatomic,strong)NSArray* arrayJourneesEnCours;

-(NSArray*)getAllEmbarcations;
-(NSArray*)getAllLocs;
-(NSArray*)getAllFactsEnCours;
-(NSArray*)getAllFactsSuivies;
-(NSArray*)getAllFactsRemisees;
-(NSArray*)getAllPaiements;
-(NSArray*)getAllGrillesPrix;
-(NSArray*)getAllTypes;
-(NSArray*)getAllTypesBateau;
-(NSArray*)getAllTypesPedalo;
-(NSArray*)getAllTypesPedaloPlaces;
-(NSArray*)getAllTypesPaddle;
-(NSArray*)getAllJourneesEnCours;
-(NSArray*)getAllJournees;
-(Location*)returnInstantiateLoc;

@end

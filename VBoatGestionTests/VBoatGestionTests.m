//
//  VBoatGestionTests.m
//  VBoatGestionTests
//
//  Created by Thomas Gaillard on 14/01/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Journee.h"
#import "Embarcation.h"

@interface VBoatGestionTests : XCTestCase

@end

@implementation VBoatGestionTests {
    Journee* _journee;
    Embarcation* _embarcation;
}

- (void)setUp
{
    [super setUp];
    _journee = [Journee new];
    [_journee initierJournee];
    _embarcation = [Embarcation new];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDispo
{
    [_embarcation rendreDisponible];
    XCTAssertTrue([_embarcation.etat isEqual:@"disponible"]);
}

- (void)testDepart
{
    [_embarcation rendreDisponible];
    [_embarcation depart];
    XCTAssertTrue([_embarcation.etat isEqual:@"enlocation"]);
}

- (void)testRetour
{
    [_embarcation rendreDisponible];
    [_embarcation depart];
    [_embarcation retour];
    XCTAssertTrue([_embarcation.etat isEqual:@"disponible"]);
}

- (void)testNombreFactures
{
    [_embarcation rendreDisponible];
    [_embarcation depart];
    
    [_journee ajouterFacture:[_embarcation retour]];
    XCTAssertTrue([_journee.listeFacturesEnCours count] == 1 );
}

@end

//
//  Paiement.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Paiement : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * montant;
@property (nonatomic, retain) NSString * moyenPaiement;

@end

//
//  PrixCollectionHeader.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 13/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "PrixCollectionHeader.h"
#import "GrillePrix.h"
#import "AppDelegate.h"

@implementation PrixCollectionHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)modifTitreGrille:(id)sender {
    
    NSLog(@"MODIFS");
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.grille.identifiantFacturation=self.titreGrille.text;
    NSError *error;
    if (![appDelegate.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}
@end

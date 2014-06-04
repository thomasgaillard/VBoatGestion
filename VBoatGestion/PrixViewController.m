//
//  PrixViewController.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "PrixViewController.h"
#import "GrillePrix.h"
#import "Prix.h"
#import "AppDelegate.h"
#import "LocationPedalo.h"
#import "LocationBateau.h"
#import "PrixCollectionViewCell.h"
#import "FlotteModalEmbarcation.h"
#import "Location.h"


//NSString *kCellID = @"MonEmbarcation";                          // UICollectionViewCell storyboard id

@interface PrixViewController (){

NSMutableArray *_sections;
    
}
@end

@implementation PrixViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)rafraichir
{
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.grillesPrixArray = [appDelegate getAllGrillesPrix];
    NSLog(@"%lu",(unsigned long)self.grillesPrixArray.count);
    [self.collectionView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM YYYY"];
    NSString *dateToday = [formatter stringFromDate:[NSDate date]];
    [self.lblDate setText: dateToday];
    
    [self rafraichir];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    NSLog(@"CUUUUUUL");
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    // Return the number of sections.
    NSLog(@"%lu",(unsigned long)self.grillesPrixArray.count);
    return self.grillesPrixArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    GrillePrix* sectionArray = [self.grillesPrixArray objectAtIndex:section];
    return sectionArray.grille.count;
}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PrixCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MonEmbarcation" forIndexPath:indexPath];
    
    GrillePrix *grille = [self.grillesPrixArray objectAtIndex:indexPath.section];
    Prix *prix = [grille.grille objectAtIndex:indexPath.item];
    
    myCell.labelEmbarcation.text = [NSString stringWithFormat:@"%@", prix.montant];
    myCell.labelEmbarcation.font = [UIFont fontWithName:@"LeagueGothic-Regular" size:26];
    
    //myCell.labelPlaces.text = [NSString stringWithFormat:@"%@",[embarcation getNbPlacesOuType]];
    
    AppDelegate* appDelegate  = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    return myCell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"modalInfosEmbarcation"]) {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        FlotteModalEmbarcation *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        
        GrillePrix *grille = [self.grillesPrixArray objectAtIndex:indexPath.row];
        //myCell.labelEmbarcation.text = [NSString stringWithFormat:@"%@, %@ ",embarcation.nom,embarcation.etat];
        NSLog(@"%@",grille.identifiantFacturation);
        destViewController.embarcation = [self.grillesPrixArray objectAtIndex:indexPath.row];
        [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
        [self.collectionView reloadData];
    }
}

-(void)saveContext{
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}



// POPUP Callback
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
(NSInteger)buttonIndex {
    if (buttonIndex == 0) {

    } else if (buttonIndex ==1) {
        //bateau
        Bateau * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Bateau"
                                                          inManagedObjectContext:self.managedObjectContext];
        //  2
        newEntry.nom = @"Nouveau Bateau";
        newEntry.type = @"Type";
        newEntry.etat = @"indisponible";
        
        [self saveContext];
        [self rafraichir];
        
    } else if (buttonIndex ==2) {
        //pedalo
        Pedalo * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Pedalo"
                                                          inManagedObjectContext:self.managedObjectContext];
        //  2
        newEntry.nom = @"Nouveau Pedalo";
        newEntry.nbPlaces = [NSDecimalNumber decimalNumberWithString:@"2"];
        newEntry.etat = @"indisponible";
        
        [self saveContext];
        [self rafraichir];
    }
}
@end

//
//  ActiviteViewController.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "ActiviteViewController.h"
#import "Embarcation.h"
#import "AppDelegate.h"
#import "LocationPedalo.h"
#import "LocationBateau.h"
#import "ActiviteCollectionViewCell.h"
#import "ActiviteModalEmbarcation.h"
#import "Location.h"


//NSString *kCellID = @"MonEmbarcation";                          // UICollectionViewCell storyboard id

@interface ActiviteViewController (){

NSMutableArray *_sections;
    
}
@end

@implementation ActiviteViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM YYYY"];
    NSString *dateToday = [formatter stringFromDate:[NSDate date]];
    [self.lblDate setText: dateToday];
    
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.embarcationsArray = [appDelegate getAllEmbarcations];
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
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.embarcationsArray count];
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
    ActiviteCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MonEmbarcation" forIndexPath:indexPath];
    
    Embarcation * embarcation = [self.embarcationsArray objectAtIndex:indexPath.row];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(singleClik:)];
    singleTap.numberOfTapsRequired = 1;
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(doubleClik:)];
    doubleTap.numberOfTapsRequired = 2;
    
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [myCell addGestureRecognizer:doubleTap];
[myCell addGestureRecognizer:singleTap];
    
    
    //background
    if([embarcation isKindOfClass:[Pedalo class]]){
        if([embarcation.etat isEqualToString:@"enlocation"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pedEnlocation.png"]];
        else if([embarcation.etat isEqualToString:@"disponible"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pedDispo.png"]];
        else
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pedIndispo.png"]];
    }
    else{
        if([embarcation.etat isEqualToString:@"enlocation"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"batEnlocation.png"]];
        else if([embarcation.etat isEqualToString:@"disponible"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"batDispo.png"]];
        else
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"batIndispo.png"]];
    }
    
    //title
    if([embarcation.etat isEqualToString:@"enlocation"])
        myCell.labelEmbarcation.textColor = [self colorWithHexString:@"e74c3c"];
    else if([embarcation.etat isEqualToString:@"disponible"])
        myCell.labelEmbarcation.textColor = [self colorWithHexString:@"2ecc70"];
    else
        myCell.labelEmbarcation.textColor = [self colorWithHexString:@"95a5a6"];
    
    myCell.labelEmbarcation.text = [NSString stringWithFormat:@"%@", embarcation.nom];
    myCell.labelEmbarcation.font = [UIFont fontWithName:@"LeagueGothic-Regular" size:26];
    
    //hour
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setDateFormat:@"HH:mm"];
    
    if([embarcation.etat isEqualToString:@"enlocation"])
        myCell.labelHeure.text = [formatter stringFromDate: [[embarcation location] heureDebut]];
    else
        myCell.labelHeure.text = @"-";
    
    NSLog([NSString stringWithFormat:@"%@, %@ ",embarcation.nom,embarcation.etat]);
    
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
        ActiviteModalEmbarcation *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        
        Embarcation * embarcation = [self.embarcationsArray objectAtIndex:indexPath.row];
        //myCell.labelEmbarcation.text = [NSString stringWithFormat:@"%@, %@ ",embarcation.nom,embarcation.etat];
        NSLog(@"%@",embarcation.nom);
        destViewController.embarcation = [self.embarcationsArray objectAtIndex:indexPath.row];
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

- (IBAction)singleClik:(id)sender {
    NSLog(@"click");
    NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
    ActiviteModalEmbarcation *destViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"modalActivite"];
    NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
    
    Embarcation * embarcation = [self.embarcationsArray objectAtIndex:indexPath.row];
    //myCell.labelEmbarcation.text = [NSString stringWithFormat:@"%@, %@ ",embarcation.nom,embarcation.etat];
    NSLog(@"%@",embarcation.nom);
    destViewController.embarcation = [self.embarcationsArray objectAtIndex:indexPath.row];
    
    [self presentModalViewController:destViewController animated:YES];

    [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    [self.collectionView reloadData];
}

- (void)affecterLocation:(Embarcation*)embarcation{
    if([embarcation isKindOfClass:[Bateau class]]){
        LocationBateau *l = [NSEntityDescription insertNewObjectForEntityForName:@"LocationBateau" inManagedObjectContext:self.managedObjectContext];
        embarcation.location = l;
    }
    else{
        LocationPedalo *l = [NSEntityDescription insertNewObjectForEntityForName:@"LocationPedalo"
                                                    inManagedObjectContext:self.managedObjectContext];
        embarcation.location = l;
    }

}

- (IBAction)doubleClik:(id)sender {
NSLog(@"dddddclick");
    NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
    NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
    Embarcation * embarcation = [self.embarcationsArray objectAtIndex:indexPath.row];
    
    if([embarcation.etat isEqualToString:@"indisponible"]){
        [self affecterLocation:embarcation];
        [embarcation rendreDisponible];
        
    }
    else if([embarcation.etat isEqualToString:@"disponible"]){
        [embarcation depart];
    }
    else{
        Facture *f = [NSEntityDescription insertNewObjectForEntityForName:@"Facture" inManagedObjectContext:self.managedObjectContext];
        [embarcation.location cloturerLocation:f];
        [self affecterLocation:embarcation];
        [embarcation rendreDisponible];
    }
    [self saveContext];
    [self.collectionView reloadData];
}
@end

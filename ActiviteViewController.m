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
#import "LocationPedaloPlaces.h"
#import "Location.h"
#import "ActiviteCollectionViewCell.h"
#import "ActiviteModalEmbarcation.h"
#import "Location.h"
#import "PedaloPlaces.h"
#import "Paddle.h"
#import "Journee.h"
#import "Facture.h"


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

- (void)rafraichir
{
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.embarcationsArray = [appDelegate getAllEmbarcations];
    self.arrayJourneeEnCours = [appDelegate getAllJourneesEnCours];
    if ([self.arrayJourneeEnCours count]==0) {
        self.viewNouvelleJournee.hidden=NO;
        self.journee = nil;
    }else
    {
        self.viewNouvelleJournee.hidden=YES;
        self.journee = [self.arrayJourneeEnCours firstObject];
    }
    [self.collectionView reloadData];
    self.lblCb.text=[NSString stringWithFormat:@"%@",self.journee.totalCb];
    self.lblEspeces.text=[NSString stringWithFormat:@"%@",self.journee.totalEspeces];
    self.lblBateaux.text=[NSString stringWithFormat:@"%@",self.journee.nbLocBateaux];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM YYYY"];
    NSString *dateToday = [formatter stringFromDate:[NSDate date]];
    [self.lblDate setText: dateToday];
    _commencerJournee.textColor = [self colorWithHexString:@"95a5a6"];
    _commencerJournee.font = [UIFont fontWithName:@"LeagueGothic-Regular" size:26];
    
    
    [self rafraichir];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    UITapGestureRecognizer *doubleTapFolderGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClik:)];
    [doubleTapFolderGesture setNumberOfTapsRequired:2];
    [doubleTapFolderGesture setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:doubleTapFolderGesture];
    doubleTapFolderGesture.delaysTouchesBegan = YES;
    
    [self rafraichir];
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self singleClik:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ActiviteCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MonEmbarcation" forIndexPath:indexPath];
    
    Embarcation * embarcation = [self.embarcationsArray objectAtIndex:indexPath.row];
    
    
 
   /*
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(singleClik:)];
    singleTap.delegate = self;
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [myCell addGestureRecognizer:singleTap];
    [singleTap requireGestureRecognizerToFail:doubleTap];*/

    
    
    
    
//    
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(singleClik:)];
//    singleTap.numberOfTapsRequired = 1;
//    
//    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(doubleClik:)];
//    doubleTap.numberOfTapsRequired = 2;
//    
//    
//    [singleTap requireGestureRecognizerToFail:doubleTap];
//    [myCell addGestureRecognizer:doubleTap];
//[myCell addGestureRecognizer:singleTap];
//    
    
    //background
    if([embarcation isKindOfClass:[PedaloPlaces class]]){
        if([embarcation.etat isEqualToString:@"enlocation"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pedEnlocation.png"]];
        else if([embarcation.etat isEqualToString:@"disponible"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pedDispo.png"]];
        else
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pedIndispo.png"]];
    }
    else if([embarcation isKindOfClass:[Bateau class]]){
        if([embarcation.etat isEqualToString:@"enlocation"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"batEnlocation.png"]];
        else if([embarcation.etat isEqualToString:@"disponible"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"batDispo.png"]];
        else
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"batIndispo.png"]];
    } else if([embarcation isKindOfClass:[Pedalo class]]){
        if([embarcation.etat isEqualToString:@"enlocation"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"toboEnlocation.png"]];
        else if([embarcation.etat isEqualToString:@"disponible"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"toboDispo.png"]];
        else
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"toboIndispo.png"]];
    } else if([embarcation isKindOfClass:[Paddle class]]){
        if([embarcation.etat isEqualToString:@"enlocation"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"padEnlocation.png"]];
        else if([embarcation.etat isEqualToString:@"disponible"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"padDispo.png"]];
        else
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"padIndispo.png"]];
    }
    
    //title
    
    if([embarcation.etat isEqualToString:@"enlocation"])
        myCell.labelEmbarcation.textColor = [self colorWithHexString:@"e74c3c"];
    else if([embarcation.etat isEqualToString:@"disponible"])
        myCell.labelEmbarcation.textColor = [self colorWithHexString:@"2ecc70"];
    else
        myCell.labelEmbarcation.textColor = [self colorWithHexString:@"95a5a6"];
    
    myCell.labelEmbarcation.text = [NSString stringWithFormat:@"%@", embarcation.nom];
    myCell.labelEmbarcation.font = [UIFont fontWithName:@"LeagueGothic-Regular" size:20];
    
    //hour
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    
    if([embarcation.etat isEqualToString:@"enlocation"])
        myCell.labelHeure.text = [formatter stringFromDate: [[embarcation location] heureDebut]];
    else
        myCell.labelHeure.text = @"-";
    
    NSLog([NSString stringWithFormat:@"%@, %@ ",embarcation.nom,embarcation.etat]);
    
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modalDismiss)
                                                 name:@"modalDismissing"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modalDismissStopLoc)
                                                 name:@"modalDismissingStopLoc"
                                               object:nil];
    
    [self presentViewController:destViewController animated:YES completion:nil];
destViewController.view.superview.frame = CGRectMake(0, 0, 540, 540);
    
    [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    [self.collectionView reloadData];
}

-(void)modalDismiss{
    [self.collectionView reloadData];
    NSLog(@"CLOSE");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)creerJournee:(id)sender {
   
}

-(void)modalDismissStopLoc{
    [self.collectionView reloadData];
    NSLog(@"CLOSE");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self augmenterNumeroBadge];
}

- (void)affecterLocation:(Embarcation*)embarcation{
    if([embarcation isKindOfClass:[PedaloPlaces class]]){
        LocationPedaloPlaces *l = [NSEntityDescription insertNewObjectForEntityForName:@"LocationPedaloPlaces"
                                                                inManagedObjectContext:self.managedObjectContext];
        embarcation.location = l;
    }
    else{
        Location *l = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
        embarcation.location = l;
    }

}

- (void)augmenterNumeroBadge {
    NSDecimalNumber *nbEnCours ;
    
    if([[[[[[self tabBarController] tabBar] items] objectAtIndex:1] badgeValue] length] == 0){
        nbEnCours = [NSDecimalNumber decimalNumberWithString:@"0"];
        
    }else {
        nbEnCours = [NSDecimalNumber decimalNumberWithString:[[[[[self tabBarController] tabBar] items] objectAtIndex:1] badgeValue]];
    }
    nbEnCours = [nbEnCours decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"1"]];
    [[[[[self tabBarController] tabBar] items] objectAtIndex:1] setBadgeValue:[nbEnCours stringValue]];
}

- (void) doubleClik:(UITapGestureRecognizer *)sender
{

    
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint point = [sender locationInView:self.collectionView];
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
        if (indexPath)
        {
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
                [f initJournee:self.journee];
                [self augmenterNumeroBadge];
            }
            [self saveContext];
            [self.collectionView reloadData];

        }

    }
}

@end

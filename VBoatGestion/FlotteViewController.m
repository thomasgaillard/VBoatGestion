//
//  FlotteViewController.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "FlotteViewController.h"
#import "Embarcation.h"
#import "AppDelegate.h"
#import "LocationPedaloPlaces.h"
#import "FlotteCollectionViewCell.h"
#import "FlotteModalEmbarcation.h"
#import "Location.h"
#import "PedaloPlaces.h"
#import "Paddle.h"


//NSString *kCellID = @"MonEmbarcation";                          // UICollectionViewCell storyboard id

@interface FlotteViewController (){

NSMutableArray *_sections;
    
}
@end

@implementation FlotteViewController



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
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.embarcationsArray count]+1;
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
    if (indexPath.row<[self.embarcationsArray count]) {
        
    FlotteCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MonEmbarcation" forIndexPath:indexPath];
    
    Embarcation * embarcation = [self.embarcationsArray objectAtIndex:indexPath.row];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(singleClik:)];
    singleTap.numberOfTapsRequired = 1;
    
 
    
    
  
[myCell addGestureRecognizer:singleTap];
    
    
    //background
    if([embarcation isKindOfClass:[PedaloPlaces class]]){
        if([embarcation.etat isEqualToString:@"enlocation"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pedEnlocationType.png"]];
        else if([embarcation.etat isEqualToString:@"disponible"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pedDispoType.png"]];
        else
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pedIndispoType.png"]];
    }
    else if([embarcation isKindOfClass:[Bateau class]]){
        if([embarcation.etat isEqualToString:@"enlocation"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"batEnlocationType.png"]];
        else if([embarcation.etat isEqualToString:@"disponible"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"batDispoType.png"]];
        else
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"batIndispoType.png"]];
    } else if([embarcation isKindOfClass:[Pedalo class]]){
        if([embarcation.etat isEqualToString:@"enlocation"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"toboEnlocationType.png"]];
        else if([embarcation.etat isEqualToString:@"disponible"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"toboDispoType.png"]];
        else
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"toboIndispoType.png"]];
    } else if([embarcation isKindOfClass:[Paddle class]]){
        if([embarcation.etat isEqualToString:@"enlocation"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"padEnlocationType.png"]];
        else if([embarcation.etat isEqualToString:@"disponible"])
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"padDispoType.png"]];
        else
            myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"padIndispoType.png"]];
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
    
    myCell.labelPlaces.text = [NSString stringWithFormat:@"%@",[embarcation getNbPlacesOuType]];
       
        AppDelegate* appDelegate  = [UIApplication sharedApplication].delegate;
        self.managedObjectContext = appDelegate.managedObjectContext;
        
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
    return myCell;
    } else {
        FlotteCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AjoutEmbarcation" forIndexPath:indexPath];
        
        myCell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btnPlus.png"]];
        myCell.labelEmbarcation.text =@"Ajouter";
        myCell.labelPlaces.text=@"";
        myCell.labelEmbarcation.font = [UIFont fontWithName:@"LeagueGothic-Regular" size:20];
        myCell.labelEmbarcation.textColor = [self colorWithHexString:@"95a5a6"];
        
        UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(clickAdd:)];
        singleTap2.numberOfTapsRequired = 1;
        [myCell addGestureRecognizer:singleTap2];
        return myCell;
    }
    
    

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"modalInfosEmbarcation"]) {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        FlotteModalEmbarcation *destViewController = segue.destinationViewController;
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
    FlotteModalEmbarcation *destViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"modalFlotte"];
    NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
    Embarcation * embarcation = [self.embarcationsArray objectAtIndex:indexPath.row];
    //myCell.labelEmbarcation.text = [NSString stringWithFormat:@"%@, %@ ",embarcation.nom,embarcation.etat];
    NSLog(@"%@",embarcation.nom);
    destViewController.embarcation = [self.embarcationsArray objectAtIndex:indexPath.row];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modalDismiss)
                                                 name:@"modalDismissing"
                                               object:nil];
    
    [self presentViewController:destViewController animated:YES completion:nil];
destViewController.view.superview.frame = CGRectMake(0, 0, 540, 540);
    
    [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    [self.collectionView reloadData];
}

- (void)clickAdd:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Création"
                          message:@"Créer une embarcation et la configurer"
                          delegate:self  // set nil if you don't want the yes button callback
                          cancelButtonTitle:@"Annuler"
                          otherButtonTitles:@"Bateau", @"Pedalo", @"PedaloPlaces", @"Paddle", nil];
    [alert show];
}

-(void)modalDismiss{
    [self rafraichir];
    NSLog(@"CLOSE");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// POPUP Callback
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
(NSInteger)buttonIndex {
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    if (buttonIndex == 0) {

    } else if (buttonIndex ==1) {
        //bateau
        Bateau * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Bateau"
                                                          inManagedObjectContext:self.managedObjectContext];
        //  2
        newEntry.nom = @"Nouveau Bateau";
        newEntry.type = [[appDelegate getAllTypesBateau] objectAtIndex:0];
        newEntry.etat = @"indisponible";
        
        [self saveContext];
        [self rafraichir];
        
    } else if (buttonIndex ==2) {
        //pedalo
        PedaloPlaces * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Pedalo"
                                                          inManagedObjectContext:self.managedObjectContext];
        //  2
        newEntry.nom = @"Nouveau Pedalo";
        newEntry.etat = @"indisponible";
        newEntry.type = [[appDelegate getAllTypesPedalo] objectAtIndex:0];
        [self saveContext];
        [self rafraichir];
    } else if (buttonIndex ==3) {
        //pedalo
        PedaloPlaces * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"PedaloPlaces"
                                                                inManagedObjectContext:self.managedObjectContext];
        //  2
        newEntry.nom = @"Nouveau Pedalo Places";
        newEntry.type = [[appDelegate getAllTypesPedaloPlaces] objectAtIndex:0];
        newEntry.nbPlaces = [NSDecimalNumber decimalNumberWithString:@"2"];
        newEntry.etat = @"indisponible";
        
        [self saveContext];
        [self rafraichir];
    } else if (buttonIndex ==4) {
        //pedalo
        Paddle * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Paddle"
                                                                inManagedObjectContext:self.managedObjectContext];
        //  2
        newEntry.nom = @"Nouveau Paddle";
        newEntry.type = [[appDelegate getAllTypesPaddle] objectAtIndex:0];
        newEntry.etat = @"indisponible";
        
        [self saveContext];
        [self rafraichir];
    }
}
@end

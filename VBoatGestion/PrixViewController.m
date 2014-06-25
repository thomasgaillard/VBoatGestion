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
#import "Location.h"
#import "LocationPedaloPlaces.h"
#import "PrixCollectionViewCell.h"
#import "PedaloPlaces.h"
#import "FlotteModalEmbarcation.h"
#import "Location.h"
#import "Type.h"
#import "TypePedaloPlaces.h"
#import "PrixCollectionHeader.h"


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
    self.managedObjectContext = appDelegate.managedObjectContext;
    self.types= [appDelegate getAllTypes];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mdpinc.textColor = [self colorWithHexString:@"95a5a6"];
    _mdpinc.font = [UIFont fontWithName:@"LeagueGothic-Regular" size:26];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM YYYY"];
    NSString *dateToday = [formatter stringFromDate:[NSDate date]];
    //[self.lblDate setText: dateToday];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    self.types= [appDelegate getAllTypes];
    
    if (self.types.count!=0) {
       
        [self.selectionType selectRow:0 inComponent:0 animated:NO];
        self.type = [self.types objectAtIndex:0];
        self.grillesPrixArray = [self.type.grillePrix array];
        [self.collectionView reloadData];
    }
    //[self rafraichir];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    self.collectionView.allowsSelection=YES;
    self.pwdView.hidden=NO;
    self.pwdIncorrect.hidden=YES;
    self.pwdTxt.text=@"";
    //[self.collectionView reloadData];
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
    
    if(self.grillesPrixArray.count ==0)
    {

        [self remplirGrille:self.type];
        [self saveContext];
        self.grillesPrixArray = [self.type.grillePrix array];
        [self.collectionView reloadData];
    }
    
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
    PrixCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"unPrix" forIndexPath:indexPath];
    
    GrillePrix *grille = [self.grillesPrixArray objectAtIndex:indexPath.section];
    Prix *prix = [grille.grille objectAtIndex:indexPath.item];
    
    NSLog(@"Durée : %@, prix : %@", prix.temps, prix.montant);
    myCell.heureLabel.text = [NSString stringWithFormat:@"%@", prix.temps];
    myCell.heureLabel.font = [UIFont fontWithName:@"LeagueGothic-Regular" size:26];
    myCell.montantTxt.text = [NSString stringWithFormat:@"%@", prix.montant];
    myCell.montantTxt.font = [UIFont fontWithName:@"LeagueGothic-Regular" size:26];
    myCell.prix=prix;
    
    myCell.montantTxt.delegate=self;
    
    //myCell.labelPlaces.text = [NSString stringWithFormat:@"%@",[embarcation getNbPlacesOuType]];
    
    AppDelegate* appDelegate  = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    return myCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        PrixCollectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"grilleHeader" forIndexPath:indexPath];
        
        GrillePrix *grille = [self.grillesPrixArray objectAtIndex:indexPath.section];
        
        NSString *title = grille.identifiantFacturation;
        headerView.titreGrille.text = title;
        
        reusableview = headerView;
    }

    return reusableview;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    NSArray *selection=[self.collectionView indexPathsForSelectedItems];
    NSIndexPath *idp = [selection firstObject];
    PrixCollectionViewCell *myCell=[self.collectionView cellForItemAtIndexPath:idp];
    
    myCell.prix.montant=textField.text;
    [self saveContext];
    
    [self.collectionView deselectItemAtIndexPath:idp animated:NO];

    return YES;
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
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
*/
-(void)saveContext{
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return self.types.count;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    Type *t = [self.types objectAtIndex:row];
    return t.nom;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component{
    self.type = [self.types objectAtIndex:row];
    self.grillesPrixArray = [self.type.grillePrix array];
    [self.collectionView reloadData];
    if ([self.type isKindOfClass:[TypePedaloPlaces class]]){
        self.ajoutGrilleBtn.hidden=NO;
    } else{
        self.ajoutGrilleBtn.hidden=YES;
    }
    
    //self.embarcation.type = [self.types objectAtIndex:row];
    
}

- (IBAction)valider:(id)sender {
    if ([self.pwdTxt.text isEqual:@"VArnoux"]) {
        self.pwdView.hidden=YES;
    }else{
        self.pwdView.hidden=NO;
        self.pwdIncorrect.hidden=NO;
    }
}

- (IBAction)ajoutType:(id)sender {
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Nouveau type" message:@"Entrer le nom du type" delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles: @"Bateau", @"Pedalo", @"PedaloPlaces", @"Paddle", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag=1;
    [alert show];

}

- (IBAction)ajoutGrille:(id)sender {
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Nouvelle grille de pédalo à places" message:@"Entrer le nombre de places" delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles: @"Créer", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag=2;
    [alert show];
}

- (IBAction)supprType:(id)sender {
    [self.managedObjectContext deleteObject:self.type];
    [self rafraichir];
    [self.selectionType reloadAllComponents];
}

// POPUP Callback
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
(NSInteger)buttonIndex {
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    switch (alertView.tag){
    
    case 1:
    
    if (![[alertView textFieldAtIndex:0].text isEqual:@""]) {
        
        if (buttonIndex == 0) {
            
        } else if (buttonIndex ==1) {
            //Bateau
            Type *newType = [NSEntityDescription insertNewObjectForEntityForName:@"TypeBateau"
                                                          inManagedObjectContext:self.managedObjectContext];
            newType.nom = [alertView textFieldAtIndex:0].text;
            [self remplirGrille:newType];
        } else if (buttonIndex ==2) {
            //Pedalo
            Type *newType = [NSEntityDescription insertNewObjectForEntityForName:@"TypePedalo"
                                                          inManagedObjectContext:self.managedObjectContext];
            newType.nom = [alertView textFieldAtIndex:0].text;
            [self remplirGrille:newType];
        } else if (buttonIndex ==3) {
            //pedalo places
            Type *newType = [NSEntityDescription insertNewObjectForEntityForName:@"TypePedaloPlaces"
                                                          inManagedObjectContext:self.managedObjectContext];
            newType.nom = [alertView textFieldAtIndex:0].text;
            [self remplirGrille:newType];
        } else if (buttonIndex ==4) {
            //paddle
            Type *newType = [NSEntityDescription insertNewObjectForEntityForName:@"TypePaddle"
                                                          inManagedObjectContext:self.managedObjectContext];
            newType.nom = [alertView textFieldAtIndex:0].text;
            [self remplirGrille:newType];
        }
        [self saveContext];
        [self rafraichir];
        [self.selectionType reloadAllComponents];
    }
    
    break;
    
    case 2 :
            if (buttonIndex == 0) {
                
            } else if (buttonIndex ==1) {
                [self remplirGrille:self.type];
                self.grillesPrixArray = [self.type.grillePrix array];
                GrillePrix *g = [self.grillesPrixArray lastObject];
                g.identifiantFacturation = [alertView textFieldAtIndex:0].text;
                [self saveContext];
                self.grillesPrixArray = [self.type.grillePrix array];
                [self.collectionView reloadData];
            }
            
    break;
            
    }
}

-(void)remplirGrille:(Type *)newType{
    GrillePrix *g1 = [NSEntityDescription insertNewObjectForEntityForName:@"GrillePrix"
                                               inManagedObjectContext:self.managedObjectContext];

    g1.identifiantFacturation=[NSString stringWithFormat:@"%@", newType.nom];

    //30
    Prix *p1 = [NSEntityDescription insertNewObjectForEntityForName:@"Prix"
                                            inManagedObjectContext:self.managedObjectContext];
    NSString *timeS = @"30 min";
    p1.temps=timeS;
    p1.montant=@"0";
    [g1 addGrilleObject:p1];
    
    //45
    Prix *p2 = [NSEntityDescription insertNewObjectForEntityForName:@"Prix"
                                             inManagedObjectContext:self.managedObjectContext];
    timeS = @"45 min";
    p2.temps=timeS;
    p2.montant=@"0";
    [g1 addGrilleObject:p2];
    
    //1
    Prix *p3 = [NSEntityDescription insertNewObjectForEntityForName:@"Prix"
                                             inManagedObjectContext:self.managedObjectContext];
    timeS = @"1h";
    p3.temps=timeS;
    p3.montant=@"0";
    [g1 addGrilleObject:p3];
    
    //1h15
    Prix *p4 = [NSEntityDescription insertNewObjectForEntityForName:@"Prix"
                                             inManagedObjectContext:self.managedObjectContext];
    timeS = @"1h15min";
    p4.temps=timeS;
    p4.montant=@"0";
    [g1 addGrilleObject:p4];
    //30
    Prix *p12 = [NSEntityDescription insertNewObjectForEntityForName:@"Prix"
                                             inManagedObjectContext:self.managedObjectContext];
    timeS = @"1h30min";
    p12.temps=timeS;
    p12.montant=@"0";
    [g1 addGrilleObject:p12];
    
    //45
    Prix *p22 = [NSEntityDescription insertNewObjectForEntityForName:@"Prix"
                                             inManagedObjectContext:self.managedObjectContext];
    timeS = @"1h45min";
    p22.temps=timeS;
    p22.montant=@"0";
    [g1 addGrilleObject:p22];
    
    //1
    Prix *p32 = [NSEntityDescription insertNewObjectForEntityForName:@"Prix"
                                             inManagedObjectContext:self.managedObjectContext];
    timeS = @"2h";
    p32.temps=timeS;
    p32.montant=@"0";
    [g1 addGrilleObject:p32];
    
    //1h15
    Prix *p42 = [NSEntityDescription insertNewObjectForEntityForName:@"Prix"
                                             inManagedObjectContext:self.managedObjectContext];
    timeS = @"2h15min";
    p42.temps=timeS;
    p42.montant=@"0";
    [g1 addGrilleObject:p42];
    
    //30
    Prix *p13 = [NSEntityDescription insertNewObjectForEntityForName:@"Prix"
                                              inManagedObjectContext:self.managedObjectContext];
    timeS = @"2h30min";
    p13.temps=timeS;
    p13.montant=@"0";
    [g1 addGrilleObject:p13];
    
    //45
    Prix *p23 = [NSEntityDescription insertNewObjectForEntityForName:@"Prix"
                                             inManagedObjectContext:self.managedObjectContext];
    timeS = @"2h45min";
    p23.temps=timeS;
    p23.montant=@"0";
    [g1 addGrilleObject:p23];
    
    //1
    Prix *p33 = [NSEntityDescription insertNewObjectForEntityForName:@"Prix"
                                             inManagedObjectContext:self.managedObjectContext];
    timeS = @"3h";
    p33.temps=timeS;
    p33.montant=@"0";
    [g1 addGrilleObject:p33];
    
    //1h15
    Prix *p44 = [NSEntityDescription insertNewObjectForEntityForName:@"Prix"
                                             inManagedObjectContext:self.managedObjectContext];
    timeS = @"3h15min";
    p44.temps=timeS;
    p44.montant=@"0";
    [g1 addGrilleObject:p44];
    
    //30
    Prix *p14 = [NSEntityDescription insertNewObjectForEntityForName:@"Prix"
                                              inManagedObjectContext:self.managedObjectContext];
    timeS = @"3h30min";
    p14.temps=timeS;
    p14.montant=@"0";
    [g1 addGrilleObject:p14];
    
    //45
    Prix *p24 = [NSEntityDescription insertNewObjectForEntityForName:@"Prix"
                                              inManagedObjectContext:self.managedObjectContext];
    timeS = @"3h45min";
    p24.temps=timeS;
    p24.montant=@"0";
    [g1 addGrilleObject:p24];
    
    //1
    Prix *p34 = [NSEntityDescription insertNewObjectForEntityForName:@"Prix"
                                              inManagedObjectContext:self.managedObjectContext];
    timeS = @"4h";
    p34.temps=timeS;
    p34.montant=@"0";
    [g1 addGrilleObject:p34];
    
    //PAR HEURE
    Prix *p = [NSEntityDescription insertNewObjectForEntityForName:@"Prix"
                                            inManagedObjectContext:self.managedObjectContext];
    timeS = @"€/15min";
    p.temps=timeS;
    p.montant=@"0";
    [g1 addGrilleObject:p];
    
    [newType addGrillePrixObject:g1];
    [self saveContext];
}
@end

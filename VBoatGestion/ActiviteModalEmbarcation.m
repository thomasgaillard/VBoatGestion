//
//  ActiviteModalEmbarcation.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 02/04/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "ActiviteModalEmbarcation.h"
#import "Facture.h"
#import "Pedalo.h"
#import "PedaloPlaces.h"
#import "LocationPedaloPlaces.h"

@interface ActiviteModalEmbarcation ()

@end

@implementation ActiviteModalEmbarcation

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Remplissage Label
    //self.labelModal.text=[NSString stringWithFormat:@"Nom: %@, Etat: %@, Remarques loc: %@",self.embarcation.nom, self.embarcation.etat, self.embarcation.location.remarque];
    
    /*[self.embarcation depart];
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }*/
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"LeagueGothic-Regular" size:26];
    titleLabel.text = self.embarcation.nom;
    titleLabel.textAlignment= NSTextAlignmentCenter;
    
    self.remarquesLoc.text = self.embarcation.location.remarque;

    self.hDebutLoc.text = [formatter stringFromDate:self.embarcation.location.heureDebut];
    self.hFinLoc.text = [formatter stringFromDate:self.embarcation.location.heureFin];
    
    self.nbPersonnesLoc.text = [self.embarcation.location getNbPlacesOuType];
    
    NSString *text = @"";
    if ([self.embarcation isKindOfClass:[Pedalo class]])
    {
        text = [NSString stringWithFormat:@"Pédalo %@ places - ", [self.embarcation getNbPlacesOuType]];
        
    }
    else if ([self.embarcation isKindOfClass:[Bateau class]]){
        text = [NSString stringWithFormat:@"Bateau %@ - ", [self.embarcation getNbPlacesOuType]];
        self.nbPersonnesLoc.hidden = YES;
        self.nbPersonnesLocLabel.hidden = YES;
        self.btn2.hidden=YES;
        self.btn3.hidden=YES;
        self.btn4.hidden=YES;
        self.btn5.hidden=YES;
    }
    
    if([self.embarcation.etat  isEqual: @"enlocation"]){
        text = [NSString stringWithFormat:@"%@ En location", text];
        self.indispoEmbBtn.enabled = NO ;
        self.dispoEmbBtn.enabled = NO ;
        self.startLocBtn.enabled = NO ;
        titleLabel.textColor = [self colorWithHexString:@"e74c3c"];
        self.typeOuNb.textColor = [self colorWithHexString:@"e74c3c"];
    }else if([self.embarcation.etat  isEqual: @"disponible"]){
        text = [NSString stringWithFormat:@"%@ Disponible", text];
        self.dispoEmbBtn.enabled = NO ;
        self.stopLocBtn.enabled = NO ;
        titleLabel.textColor = [self colorWithHexString:@"2ecc70"];
        self.typeOuNb.textColor = [self colorWithHexString:@"2ecc70"];

    }else if([self.embarcation.etat  isEqual: @"indisponible"]){
        text = [NSString stringWithFormat:@"%@ Indisponible", text];
        self.indispoEmbBtn.enabled = NO ;
        self.stopLocBtn.enabled = NO ;
        self.startLocBtn.enabled = NO ;
        titleLabel.textColor = [self colorWithHexString:@"95a5a6"];
        self.typeOuNb.textColor = [self colorWithHexString:@"95a5a6"];
        self.btn2.enabled = NO;
        self.btn3.enabled = NO;
        self.btn4.enabled = NO;
        self.btn5.enabled = NO;
        self.nbPersonnesLocLabel.enabled=NO;
        self.nbPersonnesLoc.enabled = NO;
        self.lblDeb.enabled=NO;
        self.lblFin.enabled=NO;
    }
    
    
    [self.navBar setTitleView:titleLabel];

    
    self.typeOuNb.text = text;

    AppDelegate* appDelegate  = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickBtn2:(id)sender {
    self.nbPersonnesLoc.text = @"2";
}

- (IBAction)clickBtn3:(id)sender {
    self.nbPersonnesLoc.text = @"3";
}

- (IBAction)clickBtn4:(id)sender {
    self.nbPersonnesLoc.text = @"4";
}

- (IBAction)clickBtn5:(id)sender {
    self.nbPersonnesLoc.text = @"5";
}



- (IBAction)closeModal:(id)sender {
    [self closing];
}

- (IBAction)saveModalInfos:(id)sender {
    [self saveInfos];
    [self saveContext];
    
    [self closing];
}

- (IBAction)startLoc:(id)sender {
    [self.embarcation depart];
    [self saveInfos];
    [self saveContext];
    [self closing];
}

- (IBAction)stopLoc:(id)sender {
    [self saveInfos];
    Facture *f = [NSEntityDescription insertNewObjectForEntityForName:@"Facture"
                                               inManagedObjectContext:self.managedObjectContext];
    [self.embarcation.location cloturerLocation:f];
    [self affecterNouvelleEmbarcation];
    [self.embarcation rendreDisponible];
    [self closingStopLoc];
}

- (IBAction)indispoEmb:(id)sender {
    NSMutableArray* facturesArray;
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    facturesArray = [[appDelegate getAllFactsEnCours] mutableCopy];
    BOOL embarcationEnCoursDeFacturation = NO;
    for (Facture *fact in facturesArray) {
        for (Location *loc in fact.locations) {
            if (loc.embarcation == self.embarcation) {
                embarcationEnCoursDeFacturation = YES;
            }
        }
    }
    
    if(embarcationEnCoursDeFacturation==NO)
    {
        [self.embarcation rendreIndisponible];
        [self saveContext];
        [self closing];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Rendre indisponible"
                              message:@"Impossible de rendre indisponible, une facturation est en cours."
                              delegate:nil  // set nil if you don't want the yes button callback
                              cancelButtonTitle:@"Annuler"
                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)dispoEmb:(id)sender {
    [self affecterNouvelleEmbarcation];
    [self.embarcation rendreDisponible];
    [self closing];
}

-(void)saveContext{
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

-(void)saveInfos{
    [self.embarcation.location setNbPlacesOuType:self.nbPersonnesLoc.text];
    self.embarcation.location.remarque = self.remarquesLoc.text;
}

-(void)affecterNouvelleEmbarcation{
    if([self.embarcation isKindOfClass:[PedaloPlaces class]]){
        LocationPedaloPlaces *l = [NSEntityDescription insertNewObjectForEntityForName:@"LocationPedaloPlaces"
                                                                inManagedObjectContext:self.managedObjectContext];
        self.embarcation.location = l;
    }
    else{
        Location *l = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
        self.embarcation.location = l;
    }
    [self saveContext];
}

- (void)closing {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"modalDismissing"
                                                        object:nil
                                                      userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)closingStopLoc {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"modalDismissingStopLoc"
                                                        object:nil
                                                      userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end

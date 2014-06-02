//
//  FacturationDetailsViewController.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 07/04/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "FacturationDetailsViewController.h"
#import "AppDelegate.h"
#import "GrilleTarifairePedalo.h"

@interface FacturationDetailsViewController ()

@end

@implementation FacturationDetailsViewController

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
    AppDelegate* appDelegate  = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    [self rafraichir];
    
     _aucuneFacturation.textColor = [self colorWithHexString:@"95a5a6"];
     _aucuneFacturation.font = [UIFont fontWithName:@"LeagueGothic-Regular" size:26];
    
    [super viewDidLoad];
    
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
- (IBAction)clicPaveNumerique:(id)sender {
    UIButton *btn = sender;
    if([[self.paiementTxt.text substringToIndex:1] isEqual:@"0"]){
        NSLog(@"COUC");
        self.paiementTxt.text=[self.paiementTxt.text substringFromIndex:1];
    }
    if([btn.titleLabel.text  isEqual: @"C"]){
        if(self.paiementTxt.text.length>0){
            self.paiementTxt.text=[self.paiementTxt.text substringToIndex:self.paiementTxt.text.length-1];
        }
    }else{
            self.paiementTxt.text=[self.paiementTxt.text stringByAppendingString:btn.titleLabel.text];
    }
    if (self.paiementTxt.text.length==0) {
        self.paiementTxt.text=@"0";
    }
}

- (IBAction)clicPaiement:(id)sender {
    UIButton *btn = sender;
    Paiement *p = [NSEntityDescription insertNewObjectForEntityForName:@"Paiement"
                                                inManagedObjectContext:self.managedObjectContext];
    [self.facture ajouterPaiement:p :btn.titleLabel.text :[NSDecimalNumber decimalNumberWithString:self.paiementTxt.text] ];
    
    [self rafraichir];
}

- (IBAction)clicRemise:(id)sender {
    UIButton *btn = sender;
    NSDecimalNumberHandler *handlerDown = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                               scale:0
                                                                                    raiseOnExactness:NO
                                                                                     raiseOnOverflow:NO
                                                                                    raiseOnUnderflow:NO
                                                                                 raiseOnDivideByZero:NO];
    
    //retour prix >4h
    //return [total decimalNumberByRoundingAccordingToBehavior:handlerUp];
    if ([btn.titleLabel.text  isEqual: @"Euros"]) {
        self.facture.remise = [NSDecimalNumber decimalNumberWithString:self.paiementTxt.text];
    } else if ([btn.titleLabel.text  isEqual: @"%"]){
        NSLog([NSString stringWithFormat:@"%@ €",[NSDecimalNumber decimalNumberWithString:self.prixTxt.text]]);
        self.facture.remise = [[[[self.facture.prixTotal decimalNumberByMultiplyingBy:[[NSDecimalNumber decimalNumberWithString:self.paiementTxt.text] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"2"]] decimalNumberByRoundingAccordingToBehavior:handlerDown] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"2"]];
    } else if ([btn.titleLabel.text  isEqual: @"Temps"]){
        Location *loc = [self.facture.locations anyObject];

        self.facture.remise= [self.facture.prixTotal decimalNumberBySubtracting:[GrilleTarifairePedalo calculerPrix:[NSDate dateWithTimeIntervalSinceNow:[loc.heureDebut timeIntervalSinceDate:loc.heureFin]+[[[NSDecimalNumber decimalNumberWithString:self.paiementTxt.text] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"60"]]doubleValue]] : [NSDate date]: [NSDecimalNumber decimalNumberWithString:loc.getNbPlacesOuType]]];
        NSLog(@"%f",[[NSDecimalNumber decimalNumberWithString:self.paiementTxt.text] doubleValue]);
    }
    [self rafraichir];
}

- (IBAction)clicRAZ:(id)sender {
    [self.facture recommencerPaiement];
    [self rafraichir];
}

- (IBAction)clicCloture:(id)sender {
    [self.facture cloturerFacture];
    [self.facturesArray removeObjectAtIndex:self.indexPath];
    [self.tableView reloadData];
    [self rafraichir];
    [self selectPremiereFact];
}

- (IBAction)clicAnnuler:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Annuler la facture?"
                          message:@""
                          delegate:self  // set nil if you don't want the yes button callback
                          cancelButtonTitle:@"Non"
                          otherButtonTitles:@"Oui", nil];
    [alert show];
    
    
}



// POPUP Callback
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        //NO
    } else {
        //YES
        [self.facture annulerFacture];
        [self.facturesArray removeObjectAtIndex:self.indexPath];
        [self.tableView reloadData];
        [self rafraichir];
        [self selectPremiereFact];
    }
}

- (void)selectPremiereFact
{
    if([self.facturesArray count]==0)
    {
        [self noFactures:0];
    }else{
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO  scrollPosition:UITableViewScrollPositionBottom];
    Facture *selectedFacture = [self.facturesArray objectAtIndex:[NSIndexPath indexPathForRow:0 inSection:0].row];
        [self selectedFacture:selectedFacture :self.tableView :[NSIndexPath indexPathForRow:0 inSection:0].row :self.facturesArray];
    }
}

-(void)rafraichir{
    [self resteAPayer];
    self.etatTxt.text=self.facture.etat;
    self.remarquesTxt.text=self.facture.remarque;
    self.prixTxt.text=[NSString stringWithFormat:@"%@ €",self.facture.prixTotal];
    NSLog(@"Compte : %lu",(unsigned long)[self.facture.locations count]);
    self.listeLocations=[self.facture.locations allObjects];
    self.paiementTxt.text=@"0";
    if([self.facture.remise doubleValue]== 0.0){
        self.remiseTxt.hidden=YES;
        self.remiseLabel.hidden=YES;
    }
    else{
        self.remiseTxt.hidden=NO;
        self.remiseLabel.hidden=NO;
        self.remiseTxt.text=[NSString stringWithFormat:@"%@ €",self.facture.remise];
    }
    if([self.facture.etat  isEqual:@"payee"]){
        self.especesBtn.enabled=NO;
        self.cbBtn.enabled=NO;
        self.eurosBtn.enabled=NO;
        self.pcBtn.enabled=NO;
        self.tempsBtn.enabled=NO;
        self.clotureBtn.enabled=YES;
    } else {
        self.especesBtn.enabled=YES;
        self.cbBtn.enabled=YES;
        self.eurosBtn.enabled=YES;
        self.pcBtn.enabled=YES;
        self.tempsBtn.enabled=YES;
        self.clotureBtn.enabled=NO;
    }
    [self saveContext];
    
    
}

-(void)resteAPayer{
    self.resteAPayerTxt.text=[NSString stringWithFormat:@"%@ €",[self.facture calculerResteAPayer]];
    self.paiementTxt.text=@"0";
    
}

-(void)selectedFacture:(Facture *)facture :(UITableView *)tableView :(NSUInteger*) indexPath :(NSMutableArray*) facturesArray
{
        self.noFactures.hidden=YES;
        self.noFacturesBg.hidden=YES;
        self.facturesArray=facturesArray;
        self.tableView=tableView;
        self.indexPath=indexPath;
        self.facture=facture;
        [self rafraichir];
        [self.chaqueLocsFacture reloadData];
}

-(void)noFactures:(int)empty{
    self.noFactures.hidden=NO;
    self.noFacturesBg.hidden=NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"COUNT : %lu",(unsigned long)[self.listeLocations count]);
    return [self.listeLocations count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setDateFormat:@"HH:mm"];
    
    FacturationTableViewLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaLocPedalo" forIndexPath:indexPath];
    NSLog(@"coucou");
    Location * loc = [self.listeLocations objectAtIndex:indexPath.row];
    cell.nomEmbarcation.text=loc.embarcation.nom;
    cell.heureDebut.text=[formatter stringFromDate:loc.heureDebut];
    cell.heureFin.text=[formatter stringFromDate:loc.heureFin];
    cell.nbPersonnes.text=[loc getNbPlacesOuType];
    cell.remarques.text=loc.remarque;
    cell.prix.text=[NSString stringWithFormat:@"%@ €",[loc calculerPrix]];
    //NSLog([NSString stringWithFormat:@"%@, %@ ",facture.locations,facture.etat]);
    
    return cell;
}

-(void)saveContext{
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

@end

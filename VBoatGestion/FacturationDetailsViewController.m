//
//  FacturationDetailsViewController.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 07/04/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "FacturationDetailsViewController.h"
#import "AppDelegate.h"
#import "Journee.h"

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
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM YYYY"];
    NSString *dateToday = [formatter stringFromDate:[NSDate date]];
    [self.dateTopBar setText: dateToday];
    
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
    if([self.paiementTxt.text  isEqual: @"0"]){
        self.paiementTxt.text = self.resteAPayerTxt.text;
    }
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
        if ([[NSDecimalNumber decimalNumberWithString:self.paiementTxt.text] doubleValue]>[[self.facture calculerResteAPayer] doubleValue]) {
            self.facture.remise = [self.facture calculerResteAPayer];
        }
        else
        {
        self.facture.remise = [NSDecimalNumber decimalNumberWithString:self.paiementTxt.text];
        }
    } else if ([btn.titleLabel.text  isEqual: @"%"]){
        NSLog([NSString stringWithFormat:@"%@ €",[NSDecimalNumber decimalNumberWithString:self.prixTxt.text]]);
        if ([[[[[self.facture.prixTotal decimalNumberByMultiplyingBy:[[NSDecimalNumber decimalNumberWithString:self.paiementTxt.text] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"2"]] decimalNumberByRoundingAccordingToBehavior:handlerDown] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"2"]]doubleValue]>[[self.facture calculerResteAPayer] doubleValue]) {
            self.facture.remise = [self.facture calculerResteAPayer];
        }
        else
        {
            self.facture.remise = [[[[self.facture.prixTotal decimalNumberByMultiplyingBy:[[NSDecimalNumber decimalNumberWithString:self.paiementTxt.text] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"2"]] decimalNumberByRoundingAccordingToBehavior:handlerDown] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"2"]];
        }
        
    } else if ([btn.titleLabel.text  isEqual: @"Temps"]){
        Location *loc = [self.facture.locations anyObject];

        //REMISE TEMPS !!!!
        Location *l = [self.listeLocations firstObject];
        self.facture.remise= [self.facture.prixTotal decimalNumberBySubtracting:[l calcul:[NSDate dateWithTimeIntervalSinceNow:[loc.heureDebut timeIntervalSinceDate:loc.heureFin]+[[[NSDecimalNumber decimalNumberWithString:self.paiementTxt.text] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"60"]]doubleValue]] : [NSDate date]]];
        NSLog(@"%f",[[NSDecimalNumber decimalNumberWithString:self.paiementTxt.text] doubleValue]);
    }
    
    [self rafraichir];
}

- (IBAction)clicRAZ:(id)sender {
    [self.facture recommencerPaiement];
    [self rafraichir];
}

- (IBAction)clicCloture:(id)sender {
    if([[NSDecimalNumber decimalNumberWithString:self.resteAPayerTxt.text] doubleValue]<0.0){
        Paiement *rendu = [NSEntityDescription insertNewObjectForEntityForName:@"Paiement"
                                                    inManagedObjectContext:self.managedObjectContext];
        [self.facture ajouterPaiement:rendu :@"Espèces" :[NSDecimalNumber decimalNumberWithString:self.resteAPayerTxt.text] ];
        
        [self rafraichir];
    }
    [self.facture cloturerFacture];
    [self.facturesArray removeObjectAtIndex:self.indexPath];
    [self.tableView reloadData];
    [self rafraichir];
    [self selectPremiereFact];
    [self diminuerNumeroBadge];
    [self saveContext];
}

- (IBAction)clicAnnuler:(id)sender {
    if(self.remarquesTxt.text.length==0){
    UIAlertView *alert = [[UIAlertView alloc]
                        initWithTitle:@"Annuler la facture"
                        message:@"Pour annuler, merci d'entrer un motif d'annulation."
                        delegate:self  // set nil if you don't want the yes button callback
                        cancelButtonTitle:@"Modifier"
                        otherButtonTitles: nil];
        [alert show];
    }
    else
    {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Annuler la facture?"
                          message:@""
                          delegate:self  // set nil if you don't want the yes button callback
                          cancelButtonTitle:@"Non"
                          otherButtonTitles:@"Oui", nil];
        [alert show];
    }
    
    
    
}



// POPUP Callback
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if ([alertView.title  isEqual: @"Annuler la facture"]){
            [self.remarquesTxt becomeFirstResponder];
        }
    } else {
        //YES
        [self.facture annulerFacture];
        [self.facturesArray removeObjectAtIndex:self.indexPath];
        [self.tableView reloadData];
        [self rafraichir];
        [self selectPremiereFact];
        [self diminuerNumeroBadge];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.remarquesTxt) {
        self.facture.remarque=self.remarquesTxt.text;
        [self saveContext];
    } else if (textField == self.prixTxt){
        if([[NSDecimalNumber decimalNumberWithString:self.prixTxt.text] doubleValue] >= [self.facture.prixTotal doubleValue]){
            self.facture.prixTotal = [NSDecimalNumber decimalNumberWithString:self.prixTxt.text];
            [self rafraichir];
        } else{
            self.prixTxt.text=[NSString stringWithFormat:@"%@",self.facture.prixTotal];
        }
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

- (void)diminuerNumeroBadge {
    NSString *nbEnCours ;
    
    if([[[[[[self tabBarController] tabBar] items] objectAtIndex:1] badgeValue] length] == 0){
        nbEnCours = @"0";
        
    }else {
        nbEnCours = [[[[[self tabBarController] tabBar] items] objectAtIndex:1] badgeValue];
    }
    nbEnCours = [NSString stringWithFormat:@"%@",[[NSDecimalNumber decimalNumberWithString:nbEnCours] decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:@"1"]]];
    if([nbEnCours isEqual:@"0"]){
        nbEnCours=nil;
    }

    [[[[[self tabBarController] tabBar] items] objectAtIndex:1] setBadgeValue:nbEnCours];
}

-(void)rafraichir{
    [self resteAPayer];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.arrayJourneeEnCours = [appDelegate getAllJourneesEnCours];
    if ([self.arrayJourneeEnCours count]==0) {
        self.journee = nil;
    }else
    {
        self.journee = [self.arrayJourneeEnCours firstObject];
    }
    self.cbTopBar.text=[NSString stringWithFormat:@"%@",self.journee.totalCb];
    self.especesTopBar.text=[NSString stringWithFormat:@"%@",self.journee.totalEspeces];
    
    self.remarquesTxt.delegate=self;
    self.etatTxt.text=self.facture.etat;
    self.remarquesTxt.text=self.facture.remarque;
    self.prixTxt.text=[NSString stringWithFormat:@"%@",self.facture.prixTotal];
    self.prixTxt.delegate=self;
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
    NSLog(@"RAP %@",self.resteAPayerTxt.text);
    NSLog(@"Tot %@",self.prixTxt.text);
    if([self.resteAPayerTxt.text  isEqual: [NSString stringWithFormat:@"%@ €",self.prixTxt.text]]){
        
        self.razPBtn.enabled=NO;
    }else{
        self.razPBtn.enabled=YES;
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
    [formatter setDateFormat:@"HH"];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"mm"];
    
    FacturationTableViewLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaLocPedalo" forIndexPath:indexPath];
    NSLog(@"coucou");
    Location * loc = [self.listeLocations objectAtIndex:indexPath.row];
    
    NSDecimalNumber *dureeDecimal = [[NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:[loc.heureFin timeIntervalSinceDate:loc.heureDebut]] decimalValue]] decimalNumberByDividingBy: [NSDecimalNumber decimalNumberWithString:@"60"]];
    
    //arrondi temps
    NSDecimalNumberHandler *handlerMid = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                                scale:0
                                                                                     raiseOnExactness:NO
                                                                                      raiseOnOverflow:NO
                                                                                     raiseOnUnderflow:NO
                                                                                  raiseOnDivideByZero:NO];
    dureeDecimal = [dureeDecimal decimalNumberByRoundingAccordingToBehavior:handlerMid];
    
    NSInteger duree = [dureeDecimal integerValue];

    NSInteger minutes = duree % 60;
    NSInteger hours = (duree / 60);
    
    cell.nomEmbarcation.text=loc.embarcation.nom;
    cell.heureDebut.text=[NSString stringWithFormat:@"%@h%@",[formatter stringFromDate:loc.heureDebut],[formatter2 stringFromDate:loc.heureDebut]];
    cell.heureFin.text=[NSString stringWithFormat:@"%@h%@",[formatter stringFromDate:loc.heureFin],[formatter2 stringFromDate:loc.heureFin]];
    cell.duree.text=[NSString stringWithFormat:@"%ldh%02ld",(long)hours,(long)minutes
                     ];
    cell.nbPersonnes.text=[loc getNbPlacesOuType];
    cell.remarques.text=loc.remarque;
    cell.prix.text=[NSString stringWithFormat:@"%@ €",[loc calculerPrix]];
    //NSLog([NSString stringWithFormat:@"%@, %@ ",facture.locations,facture.etat]);
    
    return cell;
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    
    
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02ldh%02ld", (long)hours, (long)minutes];
}

-(void)saveContext{
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

@end

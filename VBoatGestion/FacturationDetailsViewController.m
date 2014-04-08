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

- (void)viewDidLoad
{
    AppDelegate* appDelegate  = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    [self rafraichir];
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

-(void)rafraichir{
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
    [self resteAPayer];
    
}

-(void)resteAPayer{
    self.resteAPayerTxt.text=[NSString stringWithFormat:@"%@ €",[self.facture calculerResteAPayer]];
    self.paiementTxt.text=@"0";
    [self saveContext];
}

-(void)selectedFacture:(Facture *)facture
{
    self.facture=facture;
    [self rafraichir];
    [self.chaqueLocsFacture reloadData];
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

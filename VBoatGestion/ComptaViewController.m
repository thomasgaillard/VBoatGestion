//
//  ComptaViewController.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 19/06/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "ComptaViewController.h"
#import "AppDelegate.h"
#import "Journee.h"
#import "ComptaTableViewCell.h"

@interface ComptaViewController ()

@end

@implementation ComptaViewController

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
    // Do any additional setup after loading the view.
    
    [self rafraichir];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self rafraichir];
    self.pwdView.hidden=NO;
    self.pwdIncorrect.hidden=YES;
    self.pwdTxt.text=@"";
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sortArrayJourneesByDate{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *newArray;
    newArray = [self.arrayJournees sortedArrayUsingDescriptors:sortDescriptors];
    self.arrayJournees=newArray;
}

-(void)rafraichir{
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    self.arrayJournees = [appDelegate getAllJournees];
    self.arrayMois = [[NSMutableArray alloc] init];
    [self.choixMoisSC removeAllSegments];
    
    self.datePicker.datePickerMode=UIDatePickerModeDate;
    
    [self sortArrayJourneesByDate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    
    [self.arrayMois addObject:@"Année"];
    [self.choixMoisSC insertSegmentWithTitle:@"Année" atIndex:1000 animated:NO];
    
    for(Journee *j in self.arrayJournees){
        NSString* mois=[formatter stringFromDate:j.date];
        NSLog(@"Mois de la j : %@", mois);
        NSLog(@"Mois du array : %@", [self.arrayMois lastObject]);
        if (![mois  isEqual: [self.arrayMois lastObject]]) {
            [self.arrayMois addObject:mois];
            [self.choixMoisSC insertSegmentWithTitle:mois atIndex:1000 animated:NO];
        }
    }
    [self.choixMoisSC setSelectedSegmentIndex:0];
    self.moisEnCours = [self.arrayMois objectAtIndex:self.choixMoisSC.selectedSegmentIndex];
    [self rafraichirMois];
}

- (void)rafraichirMois
{
    self.arrayJoursMoiEnCours = [[NSMutableArray alloc] init];
    self.locMoisNumber = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.especesMoisNumber = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.cbMoisNumber = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    NSDecimalNumberHandler* roundingBehavior = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    self.titreMois.text=[NSString stringWithFormat:@"Stats %@",self.moisEnCours];
    for(Journee *j in self.arrayJournees){
        NSString* mois=[formatter stringFromDate:j.date];
        
        if ([self.moisEnCours isEqual:@"Année"]) {
            [self.arrayJoursMoiEnCours addObject:j];
            self.locMoisNumber = [self.locMoisNumber decimalNumberByAdding:j.nbLocBateaux];
            self.especesMoisNumber = [self.especesMoisNumber decimalNumberByAdding:j.totalEspeces];
            self.cbMoisNumber = [self.cbMoisNumber decimalNumberByAdding:j.totalCb];
            self.titreTotaux.text=@"Totaux de l'année";
            self.titreMoyenne.text=@"Moyenne par mois";
            self.tableView.hidden=YES;
        }else if ([mois  isEqual: self.moisEnCours]) {
            [self.arrayJoursMoiEnCours addObject:j];
            self.locMoisNumber = [self.locMoisNumber decimalNumberByAdding:j.nbLocBateaux];
            self.especesMoisNumber = [self.especesMoisNumber decimalNumberByAdding:j.totalEspeces];
            self.cbMoisNumber = [self.cbMoisNumber decimalNumberByAdding:j.totalCb];
            self.titreTotaux.text=@"Totaux du mois";
            self.titreMoyenne.text=@"Moyenne par jour";
            self.tableView.hidden=NO;
        }
    }
    NSLog(@"Count %lu",(unsigned long)self.arrayJoursMoiEnCours.count);
    if (self.arrayJoursMoiEnCours.count != 0) {

    self.locMois.text=[NSString stringWithFormat:@"%@",self.locMoisNumber];
    self.especesMois.text=[NSString stringWithFormat:@"%@ €",self.especesMoisNumber];
    self.cbMois.text=[NSString stringWithFormat:@"%@ €",self.cbMoisNumber];
    self.totalMois.text=[NSString stringWithFormat:@"%@ €",[self.especesMoisNumber decimalNumberByAdding:self.cbMoisNumber]];
    
    if ([self.moisEnCours isEqual:@"Année"]) {
       
        self.locMoyenne.text=[NSString stringWithFormat:@"%@",[self.locMoisNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)self.arrayMois.count-1]]withBehavior:roundingBehavior]];
        self.cbMoyenne.text=[NSString stringWithFormat:@"%@ €",[self.cbMoisNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)self.arrayMois.count-1]]withBehavior:roundingBehavior]];
        self.especesMoyenne.text=[NSString stringWithFormat:@"%@ €",[self.especesMoisNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)self.arrayMois.count-1]]withBehavior:roundingBehavior]];
        self.totalMoyenne.text=[NSString stringWithFormat:@"%@ €",[[self.especesMoisNumber decimalNumberByAdding:self.cbMoisNumber] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)self.arrayMois.count-1]]withBehavior:roundingBehavior]];
        
    }else{
    
    self.locMoyenne.text=[NSString stringWithFormat:@"%@",[self.locMoisNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)self.arrayJoursMoiEnCours.count]]withBehavior:roundingBehavior]];
    self.cbMoyenne.text=[NSString stringWithFormat:@"%@ €",[self.cbMoisNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)self.arrayJoursMoiEnCours.count]]withBehavior:roundingBehavior]];
    self.especesMoyenne.text=[NSString stringWithFormat:@"%@ €",[self.especesMoisNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)self.arrayJoursMoiEnCours.count]]withBehavior:roundingBehavior]];
    self.totalMoyenne.text=[NSString stringWithFormat:@"%@ €",[[self.especesMoisNumber decimalNumberByAdding:self.cbMoisNumber] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu",(unsigned long)self.arrayJoursMoiEnCours.count]]withBehavior:roundingBehavior]];
    }
    }
    
    [self.tableView reloadData];
    
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

- (IBAction)changeMois:(id)sender {
    self.moisEnCours = [self.arrayMois objectAtIndex:self.choixMoisSC.selectedSegmentIndex];
    [self rafraichirMois];
}

- (IBAction)valider:(id)sender {
    if ([self.pwdTxt.text isEqual:@"VArnoux"]) {
        self.pwdView.hidden=YES;
    }else{
        self.pwdView.hidden=NO;
        self.pwdIncorrect.hidden=NO;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.arrayJoursMoiEnCours count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComptaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"day" forIndexPath:indexPath];
    
    Journee *j= [self.arrayJoursMoiEnCours objectAtIndex:indexPath.row];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE dd"];

    cell.date.text = [NSString stringWithFormat:@"%@ ",[formatter stringFromDate: j.date]];
    cell.nbLocs.text = [NSString stringWithFormat:@"%@",j.nbLocBateaux];
    cell.montantEspèces.text = [NSString stringWithFormat:@"%@",j.totalEspeces];
    cell.montantCb.text= [NSString stringWithFormat:@"%@",j.totalCb];
    cell.total.text= [NSString stringWithFormat:@"%@",[j.totalCb decimalNumberByAdding:j.totalEspeces]];
    //NSLog([NSString stringWithFormat:@"%@, %@ ",facture.locations,facture.etat]);
    cell.nbLocs.delegate=self;
    cell.montantEspèces.delegate=self;
    cell.montantCb.delegate=self;
    cell.jour=j;
    return cell;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    NSIndexPath *idp=[self.tableView indexPathForSelectedRow];
    ComptaTableViewCell *myCell=[self.tableView cellForRowAtIndexPath:idp];
    
    if (textField==myCell.nbLocs) {
        myCell.jour.nbLocBateaux=[NSDecimalNumber decimalNumberWithString:textField.text];
        NSLog(@"NBLOOOOOOOCS");
    } else if (textField==myCell.montantEspèces)
    {
        myCell.jour.totalEspeces=[NSDecimalNumber decimalNumberWithString:textField.text];
    } else if (textField==myCell.montantCb)
    {
        myCell.jour.totalCb=[NSDecimalNumber decimalNumberWithString:textField.text];
    }
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [self.tableView deselectRowAtIndexPath:idp animated:NO];
    
    return YES;
}

- (IBAction)ajouterJournee:(id)sender {
    Journee * jour = [NSEntityDescription insertNewObjectForEntityForName:@"Journee"
     inManagedObjectContext:self.managedObjectContext];
     [jour initierJournee];
     jour.date = self.datePicker.date;
     jour.totalCb = [NSDecimalNumber decimalNumberWithString:self.cbAdd.text];
     jour.totalEspeces = [NSDecimalNumber decimalNumberWithString:self.especesAdd.text];
     jour.nbLocBateaux = [NSDecimalNumber decimalNumberWithString:self.nbLocsAdd.text];
     [jour cloturerJournee];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [self rafraichir];
    
}
@end

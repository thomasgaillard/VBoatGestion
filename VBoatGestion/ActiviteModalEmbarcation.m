//
//  ActiviteModalEmbarcation.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 02/04/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "ActiviteModalEmbarcation.h"

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
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setDateFormat:@"HH:mm"];
    
    self.navBar.title = self.embarcation.nom;
    self.remarquesLoc.text = self.embarcation.location.remarque;

    self.hDebutLoc.text = [formatter stringFromDate:self.embarcation.location.heureDebut];
    self.hFinLoc.text = [formatter stringFromDate:self.embarcation.location.heureFin];
    
    self.nbPersonnesLoc.text = [self.embarcation.location getNbPlacesOuType];
    
    NSString *text = @"";
    if ([self.embarcation isKindOfClass:[Pedalo class]])
    {
        text = [NSString stringWithFormat:@"Pédalo : %@ places - ", [self.embarcation getNbPlacesOuType]];
        
    }
    else if ([self.embarcation isKindOfClass:[Bateau class]]){
        text = [NSString stringWithFormat:@"Bateau : %@ - ", [self.embarcation getNbPlacesOuType]];
        self.nbPersonnesLoc.hidden = YES;
        self.nbPersonnesLocLabel.hidden = YES;
    }
    
    if([self.embarcation.etat  isEqual: @"enlocation"]){
        text = [NSString stringWithFormat:@"%@ En location", text];
        self.indispoEmbBtn.enabled = NO ;
        self.dispoEmbBtn.enabled = NO ;
        self.startLocBtn.enabled = NO ;
    }else if([self.embarcation.etat  isEqual: @"disponible"]){
        text = [NSString stringWithFormat:@"%@ Disponible", text];
        self.dispoEmbBtn.enabled = NO ;
        self.stopLocBtn.enabled = NO ;
    }else if([self.embarcation.etat  isEqual: @"indisponible"]){
        text = [NSString stringWithFormat:@"%@ Indisponible", text];
        self.indispoEmbBtn.enabled = NO ;
        self.stopLocBtn.enabled = NO ;
        self.startLocBtn.enabled = NO ;
    }
    
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

- (IBAction)closeModal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)saveModalInfos:(id)sender {
    
    [self saveContext];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)startLoc:(id)sender {
    [self.embarcation depart];
    [self saveInfos];
    [self saveContext];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)stopLoc:(id)sender {
    [self saveInfos];
    Facture *f = [NSEntityDescription insertNewObjectForEntityForName:@"Facture"
                                               inManagedObjectContext:self.managedObjectContext];
    [self.embarcation.location cloturerLocation:f];
    [self affecterNouvelleEmbarcation];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)indispoEmb:(id)sender {
    [self.embarcation rendreIndisponible];
    [self saveContext];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)dispoEmb:(id)sender {
    
    [self affecterNouvelleEmbarcation];
    [self dismissViewControllerAnimated:YES completion:NULL];
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
    Location *l = [NSEntityDescription insertNewObjectForEntityForName:@"LocationPedalo"
                                                inManagedObjectContext:self.managedObjectContext];
    self.embarcation.location = l;
    [self.embarcation rendreDisponible];
    [self saveContext];
}
@end

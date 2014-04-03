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
    self.etatEmbarcation.text = self.embarcation.etat;
    self.typeOuNb.text = [self.embarcation getNbPlacesOuType];
    
    self.remarquesLoc.text = self.embarcation.location.remarque;
    //PBS DATES
    NSLog(@"%@",self.embarcation.location.heureDebut);
    self.hDebutLoc.text = [formatter stringFromDate:self.embarcation.location.heureDebut];
    self.hFinLoc.text = [formatter stringFromDate:self.embarcation.location.heureFin];
    
    self.nbPersonnesLoc.text = [self.embarcation.location getNbPlacesOuType];
    
    if ([self.embarcation isKindOfClass:[Pedalo class]])
    {
        self.typeLabel.hidden = YES;
        self.titreLabel.text = @"Location de Pédalo";
    }
    else if ([self.embarcation isKindOfClass:[Bateau class]]){
        self.nbPlacesLabel.hidden = YES;
        self.nbPersonnesLoc.hidden = YES;
        self.nbPersonnesLocLabel.hidden = YES;
        self.titreLabel.text = @"Location de Bateau";
    }

    
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

- (IBAction)closeModalButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)saveModalInfos:(id)sender {
    
    [self.embarcation.location setNbPlaces:self.nbPersonnesLoc.text];
    self.embarcation.location.remarque = self.remarquesLoc.text;
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end

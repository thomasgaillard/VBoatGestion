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
    
    self.nomEmbarcation.text = self.embarcation.nom;
    self.etatEmbarcation.text = self.embarcation.etat;
    //NB PLACES
    //TYPE
    
    self.remarquesLoc.text = self.embarcation.location.remarque;
    //PBS DATES
    self.hDebutLoc.text = self.embarcation.location.heureDebut;
    self.hFinLoc.text = self.embarcation.location.heureFin;
    //NB PERSONNES

    
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
    
    self.embarcation.location.remarque = self.remarquesLoc.text;
        
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end

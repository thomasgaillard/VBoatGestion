//
//  FlotteModalEmbarcation.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 02/04/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "FlotteModalEmbarcation.h"
#import "Type.h"
#import "PedaloPlaces.h"
#import "Paddle.h"

@interface FlotteModalEmbarcation ()

@end

@implementation FlotteModalEmbarcation

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
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
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
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"LeagueGothic-Regular" size:26];
    titleLabel.text = self.embarcation.nom;
    titleLabel.textAlignment= NSTextAlignmentCenter;
    
    self.nomText.text = self.embarcation.nom;
    self.nbPersonnesLoc.text = [self.embarcation getNbPlacesOuType];
    
    NSString *text = @"";
    if ([self.embarcation isKindOfClass:[PedaloPlaces class]])
    {
        self.types= [appDelegate getAllTypesPedaloPlaces];
        text = [NSString stringWithFormat:@"Pédalo %@ places - ", [self.embarcation getNbPlacesOuType]];
        self.nbPersonnesLocLabel.hidden = NO;
        self.typeLabel.hidden = YES;
    }
    else if ([self.embarcation isKindOfClass:[Bateau class]]){
        self.types= [appDelegate getAllTypesBateau];
        text = [NSString stringWithFormat:@"Bateau %@ - ", [self.embarcation getNbPlacesOuType]];
        self.nbPersonnesLocLabel.hidden = YES;
        self.typeLabel.hidden = NO;
    }else if ([self.embarcation isKindOfClass:[Pedalo class]]){
        self.types= [appDelegate getAllTypesPedalo];
        text = [NSString stringWithFormat:@"Pedalo %@ - ", [self.embarcation getNbPlacesOuType]];
        self.nbPersonnesLocLabel.hidden = YES;
        self.typeLabel.hidden = NO;
    }else if ([self.embarcation isKindOfClass:[Paddle class]]){
        self.types= [appDelegate getAllTypesPaddle];
        text = [NSString stringWithFormat:@"Paddle %@ - ", [self.embarcation getNbPlacesOuType]];
        self.nbPersonnesLocLabel.hidden = YES;
        self.typeLabel.hidden = NO;
    }
    
    
    if([self.embarcation.etat  isEqual: @"enlocation"]){
        text = [NSString stringWithFormat:@"%@ En location", text];
        self.nomText.enabled = NO;
        self.nbPersonnesLoc.enabled = NO;
        self.supprBtn.enabled = NO;

        titleLabel.textColor = [self colorWithHexString:@"e74c3c"];
        self.typeOuNb.textColor = [self colorWithHexString:@"e74c3c"];
    }else if([self.embarcation.etat  isEqual: @"disponible"]){
        text = [NSString stringWithFormat:@"%@ Disponible", text];
        self.nomText.enabled = NO;
        self.nbPersonnesLoc.enabled = NO;
        self.supprBtn.enabled = NO;

        titleLabel.textColor = [self colorWithHexString:@"2ecc70"];
        self.typeOuNb.textColor = [self colorWithHexString:@"2ecc70"];

    }else if([self.embarcation.etat  isEqual: @"indisponible"]){
        text = [NSString stringWithFormat:@"%@ Indisponible", text];

        titleLabel.textColor = [self colorWithHexString:@"95a5a6"];
        self.typeOuNb.textColor = [self colorWithHexString:@"95a5a6"];
 
    }
    
    
    [self.navBar setTitleView:titleLabel];

    
    self.typeOuNb.text = text;
    
    if(self.embarcation.type!=nil)
        [self.selectionType selectRow:[self.types indexOfObject:self.embarcation.type] inComponent:0 animated:YES];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    self.embarcation.type = [self.types objectAtIndex:row];

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
    [self closing];
}

- (IBAction)saveModalInfos:(id)sender {
    [self saveInfos];
    [self saveContext];
    
    [self closing];
}

- (IBAction)supprimerEmb:(id)sender {
    [self.managedObjectContext deleteObject:self.embarcation];
    [self saveInfos];
    [self saveContext];
    
    [self closing];
}




-(void)saveContext{
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

-(void)saveInfos{
    //[self.embarcation setNbPlacesOuType:self.nbPersonnesLoc.text];
    self.embarcation.nom = self.nomText.text;
}

- (void)closing {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"modalDismissing"
                                                        object:nil
                                                      userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end

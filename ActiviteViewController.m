//
//  ActiviteViewController.m
//  VBoatGestion
//
//  Created by Maxence Mermoz on 31/03/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import "ActiviteViewController.h"
#import "AppDelegate.h"
#import "Embarcation.h"
#import "CollectionActiviteCellController.h"

@interface ActiviteViewController ()

@end

@implementation ActiviteViewController

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
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.embarcationsArray = [appDelegate getAllPayments];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.embarcationsArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     CollectionActiviteCellController *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MonEmbarcation" forIndexPath:indexPath];
    
    Embarcation * embarcation = [self.embarcationsArray objectAtIndex:indexPath.row];
    myCell.labelEmbarcation.text = [NSString stringWithFormat:@"Bateau : %@ %@, %@ ",embarcation,embarcation.nom,embarcation.etat];
    
    NSLog(@"Je suis censé mettre en page %@", embarcation.nom);
    
    return myCell;
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

@end

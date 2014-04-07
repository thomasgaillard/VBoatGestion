//
//  FacturationTableViewLocationCell.h
//  VBoatGestion
//
//  Created by Maxence Mermoz on 07/04/2014.
//  Copyright (c) 2014 V-Boat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacturationTableViewLocationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nomEmbarcation;
@property (weak, nonatomic) IBOutlet UILabel *heureDebut;
@property (weak, nonatomic) IBOutlet UILabel *heureFin;
@property (weak, nonatomic) IBOutlet UILabel *remarques;
@property (weak, nonatomic) IBOutlet UILabel *nbPersonnes;
@property (weak, nonatomic) IBOutlet UILabel *prix;

@end

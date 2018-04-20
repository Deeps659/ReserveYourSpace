//
//  MyBookingsCollectionViewCell.m
//  ReserveYourSpace
//
//  Created by Singh, Navin on 18/04/18.
//  Copyright © 2018 Singh, Navin. All rights reserved.
//

#import "MyBookingsCollectionViewCell.h"

@implementation MyBookingsCollectionViewCell
NSString * const myBookingsCellID = @"myBookingsCellID";


+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)configureCellForIndexPath:(NSIndexPath*)indexPath{
    
    [self beautifyView:self];
    if (indexPath.item == 0){
        [self.btnCheckedIn setImage:[UIImage imageNamed:@"checkin_30.png"] forState:UIControlStateNormal];
        [self.btnCheckedIn addTarget:self action:@selector(checkinAction) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        [self.btnCheckedIn setImage:[UIImage imageNamed:@"edit_30.png"] forState:UIControlStateNormal];
        [self.btnCheckedIn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)beautifyView:(UIView*)view{
    [self.layer setCornerRadius:5.0];
    [self.layer setBorderWidth:0.5];
    [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
}

-(void)editAction{
    
}

-(void)checkinAction{
    
}

@end

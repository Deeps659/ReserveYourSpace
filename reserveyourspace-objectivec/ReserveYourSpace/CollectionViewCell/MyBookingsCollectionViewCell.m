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

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 alpha:1.0]


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
        [self.btnCheckedIn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        [self.btnCheckedIn addTarget:self action:@selector(checkinAction) forControlEvents:UIControlEventTouchUpInside];
        [self.lblRoomName setText:@"Corbett"];
        [self.lblRoomDate setText:@"23 Apr"];
        [self.lblRoomTime setText:@"4-5pm"];
    }
    else{
        [self.btnCheckedIn setImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
        [self.btnCheckedIn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
        [self.lblRoomName setText:@"Red Fort"];
        [self.lblRoomDate setText:@"24 Apr"];
        [self.lblRoomTime setText:@"5-5:30pm"];
    }
    
}

- (void)beautifyView:(UIView*)view{
    [self.layer setCornerRadius:7.0];
    [self.layer setBorderWidth:0.5];
    [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.contentView setBackgroundColor:UIColorFromRGB(0xD6E6F5)];
    [self setClipsToBounds:NO];
    
}

-(void)editAction{
    
}

-(void)checkinAction{
    
}

@end

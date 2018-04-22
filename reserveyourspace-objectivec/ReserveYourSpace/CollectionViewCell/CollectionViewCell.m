//
//  CollectionViewCell.m
//  ReserveYourSpace
//
//  Created by Singh, Navin on 17/04/18.
//  Copyright © 2018 Singh, Navin. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

NSString * const collectionCellID = @"collectionCellID";

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 alpha:1.0]


+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)configureCell{
    [self.layer setCornerRadius:5.0];
    [self.layer setBorderWidth:0.5];
    [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [self.lblRoomCapacity setText:@""];
}
-(void)initializeCellValues:(NSIndexPath*)indexPath {
    if(indexPath.item==0) {
        [self.lblRoomName setText:@"Ajanta"];
        [self.lblMeetingDateTime setText:@"Floor 14"];
        [self.lblMeetingSubject setText:@"4"];
        [self.imgRoomCapacity setImage:[UIImage imageNamed:@"video"]];
        [self.layer setBorderWidth:2.0];
        [self.layer setBorderColor:UIColorFromRGB(0x008000).CGColor];
        
    }else if(indexPath.item==1) {
        [self.lblRoomName setText:@"Almora"];
        [self.lblMeetingDateTime setText:@"Floor 15"];
        [self.lblMeetingSubject setText:@"10"];
        [self.imgRoomCapacity setImage:[UIImage imageNamed:@"no-video"]];
        [self.layer setBorderWidth:2.0];
        [self.layer setBorderColor:UIColorFromRGB(0xDC143C).CGColor];
        
    }else {
        [self.lblRoomName setText:@"Agra"];
        [self.lblMeetingDateTime setText:@"Floor 15"];
        [self.lblMeetingSubject setText:@"20"];
        [self.imgRoomCapacity setImage:[UIImage imageNamed:@"video"]];
        [self.layer setBorderWidth:2.0];
        [self.layer setBorderColor:UIColorFromRGB(0xDC143C).CGColor];
    }
}

@end

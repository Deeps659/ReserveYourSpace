//
//  MyBookingsCollectionViewCell.h
//  ReserveYourSpace
//
//  Created by Singh, Navin on 18/04/18.
//  Copyright © 2018 Singh, Navin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBookingsCollectionViewCell : UICollectionViewCell

extern NSString * const myBookingsCellID;

@property (nonatomic, strong) IBOutlet UILabel *lblRoomName;
@property (nonatomic, strong) IBOutlet UIButton *btnCancel;
@property (nonatomic, strong) IBOutlet UIButton *btnCheckedIn;
@property (nonatomic, strong) IBOutlet UIButton *btnEdit;


+ (UINib *)nib;
-(void)configureCellForIndexPath:(NSIndexPath*)indexPath;

@end

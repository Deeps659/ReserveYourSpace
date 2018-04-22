//
//  CollectionViewCell.h
//  ReserveYourSpace
//
//  Created by Singh, Navin on 17/04/18.
//  Copyright © 2018 Singh, Navin. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const collectionCellID;

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UILabel *lblRoomName;
@property (nonatomic, strong) IBOutlet UILabel *lblMeetingSubject;
@property (nonatomic, strong) IBOutlet UILabel *lblMeetingDateTime;
@property (nonatomic, strong) IBOutlet UILabel *lblRoomCapacity;

@property (nonatomic, strong) IBOutlet UIImageView *imgRoomName;
@property (nonatomic, strong) IBOutlet UIImageView *imgMeetingSubject;
@property (nonatomic, strong) IBOutlet UIImageView *imgMeetingDateTime;
@property (nonatomic, strong) IBOutlet UIImageView *imgRoomCapacity;

+ (UINib *)nib;
-(void)configureCell;
-(void)initializeCellValues:(NSIndexPath*)indexPath;

@end

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
}

@end

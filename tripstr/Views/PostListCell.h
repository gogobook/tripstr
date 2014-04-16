//
//  PostListCell.h
//  tripstr
//
//  Created by ctwsine on 3/18/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostListCell : UITableViewCell

@property (nonatomic,strong) PFImageView* postImageView;
@property (nonatomic,strong) UILabel* titleLabel;
@property (nonatomic,strong) UILabel* locationLabel;
@property (nonatomic,strong) UILabel* contentLabel;

@end

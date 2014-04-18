//
//  ConnectionListCell.h
//  tripstr
//
//  Created by ctwsine on 4/18/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConnectionListCell : UITableViewCell

@property (nonatomic,strong) UIImageView* userImageView;
@property (nonatomic,strong) UILabel* userNameLabel;
@property (nonatomic,strong) UILabel* userMessageLabel;
@property (nonatomic,strong) UILabel* userStatusLabel;

@end

//
//  LeftMenuCell.h
//  tripstr
//
//  Created by ctwsine on 3/18/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum MenuType
{
    MenuTypeUser,MenuTypeIndex
}MenuType;

@interface LeftMenuCell : UITableViewCell

@property (nonatomic) MenuType menuType;

@property (nonatomic,strong) UIImageView* avatarImageView;
@property (nonatomic,strong) UILabel* nameLabel;
@property (nonatomic,strong) UILabel* locationLabel;


@end

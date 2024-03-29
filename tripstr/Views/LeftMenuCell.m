//
//  LeftMenuCell.m
//  tripstr
//
//  Created by ctwsine on 3/18/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "LeftMenuCell.h"

@implementation LeftMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}


#pragma mark- setter
-(void)setMenuType:(MenuType)menuType
{
    switch (menuType) {
        case MenuTypeUser:
            [self addSubview:self.avatarImageView];
            [self addSubview:self.nameLabel];
            [self addSubview:self.locationLabel];
            [self setupUserConstraints];
            break;
        case MenuTypeIndex:
//            [self addSubview:self.indexLabel];
//            [self.indexLabel autoCenterInSuperview];
            
            [self addSubview:self.cellView];
            [self.cellView addSubview:self.indexLabel];
            
            [self.cellView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
            [self.cellView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
            [self.cellView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
            [self.cellView autoSetDimension:ALDimensionWidth toSize:270];
            [self.cellView autoSetDimension:ALDimensionHeight toSize:50];
            
            [self.indexLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
            [self.indexLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
            
            break;
        default:
            break;
    }
}

-(void) setupUserConstraints
{
//    NSDictionary* views = @{@"avatar":self.avatarImageView,@"name":self.nameLabel,@"location":self.locationLabel};
//    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[avatar(100)]-10-[name(30)]-1-[location(30)]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
//    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-85-[avatar(100)]" options:0 metrics:nil views:views]];
    [self.avatarImageView autoSetDimension:ALDimensionWidth toSize:100];
    [self.avatarImageView autoSetDimension:ALDimensionHeight toSize:100];
    [self.avatarImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:25];
    [self.avatarImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:85];
    
    [self.nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.avatarImageView withOffset:10];
    [self.nameLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.avatarImageView];
    [self.locationLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:5];
    [self.locationLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.nameLabel];
}


#pragma mark- getter

-(UIImageView *)avatarImageView
{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 50;
        _avatarImageView.layer.borderWidth = 0.3;
        _avatarImageView.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return _avatarImageView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.font = [UIFont systemFontOfSize:12];
    }
    return _nameLabel;
}

-(UILabel *)locationLabel
{
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _locationLabel.font = [UIFont systemFontOfSize:12];
    }
    return _locationLabel;
}

-(UILabel *)indexLabel
{
    if (!_indexLabel) {
        _indexLabel = [[UILabel alloc] initForAutoLayout];
        _indexLabel.font = [UIFont systemFontOfSize:18];
    }
    return _indexLabel;
}

-(UIView *)cellView
{
    if (!_cellView) {
        _cellView = [[UIView alloc] initForAutoLayout];
    }
    return _cellView;
}

@end

//
//  ConnectionListCell.m
//  tripstr
//
//  Created by ctwsine on 4/18/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "ConnectionListCell.h"

@implementation ConnectionListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setLayout];
    }
    return self;
}

- (void) setLayout
{
    [self addSubview:self.userImageView];
    [self addSubview:self.userNameLabel];
    [self addSubview:self.userMessageLabel];
    [self addSubview:self.userStatusLabel];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    [self.userImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:6];
    [self.userImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:6];
    [self.userImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:6];
    [self.userImageView autoSetDimension:ALDimensionHeight toSize:50];
    [self.userImageView autoSetDimension:ALDimensionWidth toSize:50];
    
    [self.userNameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.userImageView];
    [self.userNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.userImageView withOffset:5];
    
    [self.userMessageLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.userImageView];
    [self.userMessageLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.userNameLabel];
    [self.userMessageLabel autoSetDimension:ALDimensionWidth toSize:183];
    
    [self.userStatusLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.userMessageLabel];
    [self.userStatusLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.userMessageLabel];
    [self.userStatusLabel autoSetDimension:ALDimensionWidth toSize:70];
}

#pragma mark- getters

-(UIImageView *)userImageView
{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] initForAutoLayout];
        _userImageView.layer.cornerRadius = 5;
        _userImageView.clipsToBounds = YES;
    }
    return _userImageView;
}

-(UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _userNameLabel;
}

-(UILabel *)userMessageLabel
{
    if (!_userMessageLabel) {
        _userMessageLabel = [[UILabel alloc] initForAutoLayout];
        _userMessageLabel.font = [UIFont systemFontOfSize:12];
        _userMessageLabel.numberOfLines = 2;
        _userMessageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _userMessageLabel;
}

-(UILabel *)userStatusLabel
{
    if (!_userStatusLabel) {
        _userStatusLabel = [[UILabel alloc] initForAutoLayout];
        _userStatusLabel.font = [UIFont systemFontOfSize:12];
        _userStatusLabel.textAlignment = NSTextAlignmentRight;
        _userStatusLabel.textColor = [UIColor whiteColor];
        if ([_userStatusLabel.text isEqualToString:@"Confirmed"]) {
            _userStatusLabel.backgroundColor = [UIColor greenColor];
        } else {
            _userStatusLabel.backgroundColor = [UIColor grayColor];
        }
    }
    return _userStatusLabel;
}

@end

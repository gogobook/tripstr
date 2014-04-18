//
//  TravelListCell.m
//  tripstr
//
//  Created by ctwsine on 3/18/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "TravelListCell.h"


@implementation TravelListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setLayout];
    }
    return self;
}

-(void) setLayout
{
    [self addSubview:self.cityImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.cityNameLabel];
    [self addSubview:self.contentLabel];
}

-(void)updateConstraints
{
    [super updateConstraints];

    [self.cityImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:6];
    [self.cityImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:6];
    [self.cityImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:6];
    [self.cityImageView autoSetDimension:ALDimensionHeight toSize:50];
    [self.cityImageView autoSetDimension:ALDimensionWidth toSize:50];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.cityImageView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self.titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.cityImageView withOffset:5];
    [self.titleLabel autoSetDimension:ALDimensionWidth toSize:170];
    
    [self.cityNameLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.titleLabel];
    [self.cityNameLabel autoSetDimension:ALDimensionWidth toSize:83];
    [self.cityNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.titleLabel];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.cityImageView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self.contentLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.titleLabel];
    [self.contentLabel autoSetDimension:ALDimensionWidth toSize:253];
    
    
}


#pragma mark- getter

-(UIImageView *)cityImageView
{
    if (!_cityImageView) {
        _cityImageView = [[UIImageView alloc] initForAutoLayout];
        _cityImageView.layer.cornerRadius = 5;
        _cityImageView.clipsToBounds = YES;
    }
    return _cityImageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _titleLabel;
}

-(UILabel *)cityNameLabel
{
    if (!_cityNameLabel) {
        _cityNameLabel = [[UILabel alloc] initForAutoLayout];
        _cityNameLabel.textAlignment = NSTextAlignmentRight;
    }
    return _cityNameLabel;
}

-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initForAutoLayout];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.numberOfLines = 2;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _contentLabel;
}

@end

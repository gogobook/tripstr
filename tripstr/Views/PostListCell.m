//
//  PostListCell.m
//  tripstr
//
//  Created by ctwsine on 3/18/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "PostListCell.h"

@implementation PostListCell

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
    [self addSubview:self.postImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.locationLabel];
    [self addSubview:self.contentLabel];
}

-(void) updateConstraints
{
    [super updateConstraints];
    
    [self.postImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:6];
    [self.postImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:6];
    [self.postImageView autoSetDimension:ALDimensionHeight toSize:52];
    [self.postImageView autoSetDimension:ALDimensionWidth toSize:52];
    
    [self.titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.postImageView];
    [self.titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.postImageView withOffset:5];
    [self.titleLabel autoSetDimension:ALDimensionWidth toSize:150];
    
    [self.locationLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.postImageView];
    [self.locationLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.titleLabel];
    [self.locationLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:6];
    
    [self.contentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel withOffset:5];
    [self.contentLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.titleLabel];
    [self.contentLabel autoSetDimension:ALDimensionWidth toSize:251];
    
}

#pragma mark- getters

//-(UIImageView *)postImageView
//{
//    if (!_postImageView) {
//        _postImageView = [[UIImageView alloc] initForAutoLayout];
//        _postImageView.layer.cornerRadius = 5;
//        _postImageView.clipsToBounds = YES;
//        _postImageView.backgroundColor = [UIColor grayColor];
//    }
//    return _postImageView;
//}

-(PFImageView *)postImageView
{
    if (!_postImageView) {
        _postImageView = [[PFImageView alloc] initForAutoLayout];
        _postImageView.layer.cornerRadius = 5;
        _postImageView.clipsToBounds = YES;
        _postImageView.backgroundColor = [UIColor grayColor];
        _postImageView.layer.borderColor = [UIColor blackColor].CGColor;
        _postImageView.layer.borderWidth = 0.3;
    }
    return _postImageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        _titleLabel.backgroundColor = [UIColor redColor];
        _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
    }
    return _titleLabel;
}

-(UILabel *)locationLabel
{
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] initForAutoLayout];
        _locationLabel.backgroundColor = [UIColor yellowColor];
    }
    return _locationLabel;
}

-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initForAutoLayout];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.numberOfLines = 2;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.backgroundColor = [UIColor greenColor];
    }
    return _contentLabel;
}

@end

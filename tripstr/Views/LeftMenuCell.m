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
            [self addSubview:self.indexLabel];
            [self.indexLabel autoCenterInSuperview];
            break;
        default:
            break;
    }
}

-(void) setupUserConstraints
{
    NSDictionary* views = @{@"avatar":self.avatarImageView,@"name":self.nameLabel,@"location":self.locationLabel};
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[avatar(100)]-10-[name(30)]-2-[location(30)]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-85-[avatar(100)]" options:0 metrics:nil views:views]];
}


#pragma mark- getter

-(UIImageView *)avatarImageView
{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _avatarImageView.backgroundColor = [UIColor yellowColor];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 50;
    }
    return _avatarImageView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _nameLabel;
}

-(UILabel *)locationLabel
{
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _locationLabel;
}

-(UILabel *)indexLabel
{
    if (!_indexLabel) {
        NSLog(@"indexLabel");
        _indexLabel = [[UILabel alloc] initForAutoLayout];
        _indexLabel.backgroundColor = [UIColor redColor];
    }
    return _indexLabel;
}
@end

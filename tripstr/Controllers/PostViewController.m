//
//  PostViewController.m
//  tripstr
//
//  Created by ctwsine on 3/17/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController ()

@property (nonatomic,strong) UILabel* headline;
@property (nonatomic,strong) UILabel* location;
@property (nonatomic,strong) UIImageView* photo;
@property (nonatomic,strong) UILabel* content;

@property (nonatomic,strong) UILabel* authorName;
@property (nonatomic,strong) UIImageView* authorAvatar;
@property (nonatomic,strong) UILabel* authorIntro;

//
//self.postId = objId;
//self.headline = data[@"headline"];
//self.content = data[@"content"];
//self.location = data[@"location"];
//self.photoURLString = data[@"photoURLString"];
//self.authorId = data[@"authorId"];


@end

@implementation PostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"postVC loaded");
    NSLog(@"post sent in: %@", self.postModel.headline);
}


@end

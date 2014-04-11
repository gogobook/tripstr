//
//  UserModel.h
//  tripstr
//
//  Created by ctwsine on 4/11/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@class UserModel;
@protocol UserModelDelegate <NSObject>

-(void) didFetchUser: (UserModel*) User;
-(void) failToFetchUser: (NSError*) error;

@end


@interface UserModel : NSObject

@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* email;
@property (nonatomic,strong) NSString* avatarUrlString;
@property (nonatomic,strong) NSString* description;
@property (nonatomic,strong) id<UserModelDelegate> delegate;

-(void) fetchUserMe;
-(void) fetchUserAuthorByUser: (PFUser*) author;

@end

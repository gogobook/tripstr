//
//  UserModel.m
//  tripstr
//
//  Created by ctwsine on 4/11/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

-(void)fetchUserMe
{
    
}

-(void)fetchUserAuthorByUser:(PFUser *)author
{
    
}

-(void)fetchUserWithUserId:(NSString *)authorId
{
    UserModel* author = [[UserModel alloc] init];
    PFQuery *query = [PFUser query];
    [query getObjectInBackgroundWithId:authorId block:^(PFObject *object, NSError *error) {
        
        if (!error) {
            author.avatarUrlString = object[@"avatarURL"];
            author.email = object[@"email"];
            author.location = object[@"location"];
            author.name = object[@"name"];
            author.introduction = object[@"description"];

            
            if ([self.delegate respondsToSelector:@selector(didFetchUser:)]) {
                [self.delegate didFetchUser:author];
            } else {
                NSLog(@"fetch user failed");
            }
            
        } else {
            NSLog(@"An Error Occurred at UserModel.m: %@",error);
        }
    }];
    
   
    
    
}

@end

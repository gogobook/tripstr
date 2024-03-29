//
//  AppDelegate.m
//  tripstr
//
//  Created by ctwsine on 3/17/14.
//  Copyright (c) 2014 ctwsine. All rights reserved.
//

#import "AppDelegate.h"
#import <JASidePanelController.h>
#import "LeftMenuViewController.h"
#import "BrowseViewController.h"
#import <Parse/Parse.h>
#import "LoginViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    //Parse Credentials
    [Parse setApplicationId:@"dzjOWspWXbTFLaGXMV0NtIdIzj5oOsnMU01WTyB4"
                  clientKey:@"Wl4Grdu5acZNTSA7Frft8BOjVq49oyU3kpleO2ek"];
    
    [PFFacebookUtils initializeFacebook];
    
    //Setup JASidePanel
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[JASidePanelController alloc] init];
    self.viewController.leftFixedWidth = 270;
    
    LeftMenuViewController* lmvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"lmvc"];
    self.viewController.leftPanel = [[UINavigationController alloc] initWithRootViewController:lmvc];
    BrowseViewController* bvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"bvc"];
    self.viewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:bvc];
//    LoginViewController* lvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"lvc"];
//    self.viewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:lvc];
    
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    //BarButtonItem tint color
    self.window.tintColor = [UIColor clearColor];

    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

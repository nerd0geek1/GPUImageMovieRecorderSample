//
//  GMRAppDelegate.m
//  GPUImageMovieRecorderSample
//
//  Created by Kohei Tabata on 8/20/14.
//  Copyright (c) 2014 Kohei Tabata. All rights reserved.
//

#import "GMRAppDelegate.h"
#import "GMRMovieRecorderViewController.h"

@implementation GMRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    GMRMovieRecorderViewController *recorderViewController = [[GMRMovieRecorderViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:recorderViewController];
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end

//
//  ETSAppDelegate.m
//  EudicTransform
//
//  Created by stone win on 8/23/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSAppDelegate.h"
#import "ETSWordsListViewController.h"
#import "ETSDBHelper.h"
#import "ETSMasterTablesViewController.h"

@implementation ETSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"myWords" ofType:@"html"];
//    if ([path length] > 0)
//    {
//        NSError *error = nil;
//        NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
//        if (nil == error)
//        {
//            // FIXME: TEST ONLY
////            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
////            NSString *path = [paths lastObject];
////            path = [path stringByAppendingPathComponent:@"newWords.html"];
////            [string writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:nil];
//            NSArray *abc = [[ETSParser defaultParser] wordsFromHTMLString:string];
//        }
//    }
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"myWords" ofType:@"html"];
//        NSError *error = nil;
//        NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
//        NSArray *words = nil;//[[ETSParser defaultParser] wordsFromHTMLString:string];
    
//        [[ETSDBHelper sharedInstance] open];
//        NSArray *tables = [[ETSDBHelper sharedInstance] selectFromMaster];
//        NSLog(@"%@", tables);
//        NSArray *items = [[ETSDBHelper sharedInstance] fetchTableItems];
//        [[ETSDBHelper sharedInstance] appendWords:words lastTableItem:[items lastObject]];
//        [[ETSDBHelper sharedInstance] close];
    
//    });
    
    // prepare DB
    [[ETSDBHelper sharedInstance] open];
    
    ETSWordsListViewController *wordsController = [[ETSWordsListViewController alloc] init];
    UINavigationController *wordsNavigationController = [[UINavigationController alloc] initWithRootViewController:wordsController];
    
    ETSMasterTablesViewController *supermemoController = [[ETSMasterTablesViewController alloc] init];
    UINavigationController *supermemoNavigationController = [[UINavigationController alloc] initWithRootViewController:supermemoController];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[supermemoNavigationController, wordsNavigationController];
    self.window.rootViewController = tabBarController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
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
    [[ETSDBHelper sharedInstance] close];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[ETSDBHelper sharedInstance] open];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[ETSDBHelper sharedInstance] close];
}

@end

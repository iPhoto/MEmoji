//
//  MEAppDelegate.m
//  MEmoji
//
//  Created by Cameron Ehrlich on 7/28/14.
//  Copyright (c) 2014 Lucky Bunny LLC. All rights reserved.
//

#import "MEAppDelegate.h"
#import <NSURL+ParseQuery/NSURL+QueryParser.h>

@implementation MEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MEModel sharedInstance];
        
    [self.window  setTintColor:[UIColor whiteColor]];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [application setApplicationSupportsShakeToEdit:YES];
    
    // Appirater Setup
    [Appirater setAppId:@"921847909"];
    [Appirater setDaysUntilPrompt:2];
    [Appirater setUsesUntilPrompt:1];
    [Appirater setSignificantEventsUntilPrompt:15];
    [Appirater setTimeBeforeReminding:3];
    [Appirater appLaunched:YES];
    
    [[GAI sharedInstance] setTrackUncaughtExceptions:YES];
    [[GAI sharedInstance] setDispatchInterval:5];
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelNone];
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-35804692-4"];
    [[[GAI sharedInstance] defaultTracker] setAllowIDFACollection:NO];
    
    // Parse Push Notifications
    [Parse setApplicationId:@"qordhDuNzL5nBU9u7H3w2krXjn1HC2Nthl0s7K4n"
                  clientKey:@"aOTBL97DNoMle0bzg57AFBCqtKXRQQhVZ0xuNSXG"];
    
    // Register for Push Notitications, if running iOS 8
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {
        // Register for Push Notifications before iOS 8
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation setChannels:@[ @"global" ]];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
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

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *args = [url parseQuery]; // memoji://?hiphoppack=1?watermarkEnabled=1
        
        @try {
            for (NSString *key in args.keyEnumerator.allObjects) {
                BOOL enabled = [@([[args objectForKey:key] integerValue]) boolValue];
                if ([key isEqualToString:hipHopPackProductIdentifier]) {
                    [[MEModel sharedInstance] setHipHopPackEnabled:enabled];
                }else if ([key isEqualToString:watermarkProductIdentifier]){
                    [[MEModel sharedInstance] setWatermarkEnabled:enabled];
                }
            }
        }
        @catch (NSException *exception) {

        }
        
    });

    return YES;
}

@end

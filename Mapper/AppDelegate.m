//
//  AppDelegate.m
//  Mapper
//
//  Created by Conikalpha on 02/05/16.
//  Copyright © 2016 flypocket. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[NotificarePushLib shared] launch];
    [[NotificarePushLib shared] setDelegate:self];
    [[NotificarePushLib shared] handleOptions:launchOptions];
    //[[[NotificarePushLib shared] locationManager] requestAlwaysAuthorization];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//Push Notifications

- (void)notificarePushLib:(NotificarePushLib *)library onReady:(NSDictionary *)info{
    //Notificare is ready

    [[NotificarePushLib shared] registerForNotifications];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    //Retry?
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [[NotificarePushLib shared] registerDevice:deviceToken completionHandler:^(NSDictionary *info) {
        
        
        //just because
        [[[NotificarePushLib shared] locationManager] requestAlwaysAuthorization];

        if([[NotificarePushLib shared] checkLocationUpdates]){
            
            //i don't know why but checkLocationUpdates return null...
            [[NotificarePushLib shared] startLocationUpdates];
            
        }else{
          
            //so i do this to move on
            [[NotificarePushLib shared] startLocationUpdates];

        }
        
        
    } errorHandler:^(NSError *error) {
        
    }];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[NotificarePushLib shared] openNotification:userInfo];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    [[NotificarePushLib shared] handleNotification:userInfo forApplication:application completionHandler:^(NSDictionary *info) {
        
        completionHandler(UIBackgroundFetchResultNewData);

    } errorHandler:^(NSError *error) {
        
        completionHandler(UIBackgroundFetchResultNoData);

    }];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    //url will contain the content of the message you've received
    
    return YES;
}

- (void)notificarePushLib:(NotificarePushLib *)library didUpdateBadge:(int)badge{
    //Update UI
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(nonnull NSDictionary *)userInfo withResponseInfo:(nonnull NSDictionary *)responseInfo completionHandler:(nonnull void (^)())completionHandler{
    
    [[NotificarePushLib shared] handleAction:identifier forNotification:userInfo withData:responseInfo completionHandler:^(NSDictionary *info) {
        
        completionHandler();
        
    } errorHandler:^(NSError *error) {
        
        completionHandler();
        
    }];
}

//Location

- (void)notificarePushLib:(NotificarePushLib *)library didReceiveLocationServiceAuthorizationStatus:(NSDictionary *)status{
    if([[NotificarePushLib shared] checkLocationUpdates]){
        NSLog(@"Location Services enabled: %@", status);
    }
}

- (void)notificarePushLib:(NotificarePushLib *)library didFailToStartLocationServiceWithError:(NSError *)error{
    
    //Retry
    NSLog(@"didFailToStartLocationServiceWithError: %@", error);

    
}

- (void)notificarePushLib:(NotificarePushLib *)library didUpdateLocations:(NSArray *)locations{
    NSLog(@"didUpdateLocations: %@", locations);
}

- (void)notificarePushLib:(NotificarePushLib *)library didStartMonitoringForRegion:(CLRegion *)region{
    NSLog(@"didStartMonitoringForRegion: %@", region);
}

- (void)notificarePushLib:(NotificarePushLib *)library monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error{
    NSLog(@"monitoringDidFailForRegion: Region > %@ Error > %@", region, error);
}

- (void)notificarePushLib:(NotificarePushLib *)library didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    NSLog(@"monitoringDidFailForRegion: Region > %@", region);
    switch (state) {
        case CLRegionStateInside:
            break;
        case CLRegionStateOutside:
            break;
        case CLRegionStateUnknown:
            break;
        default:
            break;
    }
}

- (void)notificarePushLib:(NotificarePushLib *)library didEnterRegion:(CLRegion *)region{
    
}

- (void)notificarePushLib:(NotificarePushLib *)library didExitRegion:(CLRegion *)region{
    
}

@end

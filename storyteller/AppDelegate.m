//
//  AppDelegate.m
//  storyteller
//
//  Created by Bogdan Pavel on 27/02/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import "AppDelegate.h"
#import "Audiobook.h"
#import "TestFlight.h"

@implementation AppDelegate
#define debug 0

- (void)populateWithInitialData {
    
    if (debug==1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    NSArray *initialAudiobookTitles = @[@"a1", @"a2", @"a3"];
    for (NSString *a in initialAudiobookTitles) {
        Audiobook *audiobook = [ NSEntityDescription insertNewObjectForEntityForName:@"Audiobook" inManagedObjectContext:_coreDataHelper.context];
        audiobook.title=a;
    }
    [_coreDataHelper saveContext];
}
-(CoreDataHelper *)coreDataHelper{
    if (!_coreDataHelper) {
        _coreDataHelper = [CoreDataHelper new];
        [_coreDataHelper setupCoreData];
    }
    return _coreDataHelper;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [TestFlight takeOff:@"c43474d8-bb07-4d45-ba06-1d6f85ba377b"];
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
    [self.coreDataHelper saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self coreDataHelper];
    //[self populateWithInitialData];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self.coreDataHelper saveContext];
}

@end

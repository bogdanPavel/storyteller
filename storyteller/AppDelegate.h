//
//  AppDelegate.h
//  storyteller
//
//  Created by Bogdan Pavel on 27/02/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelper.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) CoreDataHelper *coreDataHelper;

@end

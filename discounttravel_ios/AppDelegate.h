//
//  AppDelegate.h
//  discounttravel_ios
//
//  Created by yuriy sych on 11/24/16.
//  Copyright © 2016 yuriy sych. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Model.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, readonly) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) Model* model;

AppDelegate* getAppDelegate();
+ (BOOL)checkNetworkStatus;
+ (void)registerDefaults;
- (void)saveContext;
- (void)showError:(NSString *)error;
@end


//
//  AppDelegate.h
//  FBSample
//
//  Created by Bharath G M on 10/26/13.
//  Copyright (c) 2013 Bharath G M. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) UINavigationController *navController;

@property (strong, nonatomic) ViewController *viewController;

@end

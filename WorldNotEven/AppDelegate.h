//
//  AppDelegate.h
//  WorldNotEven
//
//  Created by Xuefeng Dai on 26/7/12.
//  Copyright Hong Kong University 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end

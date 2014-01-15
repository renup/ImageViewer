//
//  AppDelegate.h
//  ImageViewer
//
//  Created by Renu P on 1/9/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    Reachability* internetReach;
    Reachability* wifiReach;
    UIImageView	*networkErrorIcon;
    UILabel	*networkErrorLabel;
    UIView *networkView;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) bool networkConnectionStatus;
@property (nonatomic) NSString *networkType;



@end

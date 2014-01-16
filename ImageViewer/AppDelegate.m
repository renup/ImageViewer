//
//  AppDelegate.m
//  ImageViewer
//
//  Created by Renu P on 1/9/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize networkConnectionStatus, networkType;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    
    self.networkConnectionStatus=YES;
    
    internetReach = [Reachability reachabilityForInternetConnection];
	[internetReach startNotifier];
	[self updateInterfaceWithReachability: internetReach];

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
}

#pragma mark Reachability methods
//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
}

- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
   	if(curReach == internetReach)
	{
		[self configureNetworkStatus:curReach];
	}
	else if(curReach == wifiReach)
	{
        [self configureNetworkStatus:curReach];
	}
	
}

-(void)configureNetworkStatus:(Reachability*) curReach{
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    
    switch (netStatus)
    {
        case NotReachable:
        {
            self.networkType= @"No network.";
#if DEBUG
            NSLog(@"No network");
#endif
            self.networkConnectionStatus=NO;
            
            [self noNetwork];
            break;
        }
            
        case ReachableViaWWAN:
        {
            if (self.networkConnectionStatus==NO) {
                
                [self networkConnect];
                
            }
            self.networkType= @"WWAN";
#if DEBUG
            NSLog(@"YES network");
#endif
            self.networkConnectionStatus=YES;
            break;
        }
        case ReachableViaWiFi:
        {
            if (self.networkConnectionStatus==NO) {
                
                [self networkConnect];
            }
            self.networkType= @"WIFI";

#if DEBUG
            NSLog(@"YES network");
#endif
            self.networkConnectionStatus=YES;
            break;
            
        }
    }
}


-(void)noNetwork{
    UIImage *bgImage = [UIImage imageNamed:@"bg1.png"];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:bgImage];
    bgImageView.frame = CGRectMake(0, 0, bgImage.size.width, bgImage.size.height);
    bgImageView.contentMode = UIViewContentModeTop;
    networkView  = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    networkView .backgroundColor = [UIColor whiteColor];
    [networkView addSubview:bgImageView];
    
    UILabel *connectivityStatusLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,50,320,50)];
    connectivityStatusLabel.textColor=[UIColor blackColor];
    connectivityStatusLabel.backgroundColor=[UIColor clearColor];
    connectivityStatusLabel.font=[UIFont boldSystemFontOfSize:20.0f];
    connectivityStatusLabel.text=@"No Network Connection";
    connectivityStatusLabel.textAlignment = NSTextAlignmentCenter;
    
    UIImage *wifiImage = [UIImage imageNamed:@"wifi.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:wifiImage];
    imageView.frame=CGRectMake(bgImage.size.width/2-imageView.frame.size.width/2,120,wifiImage.size.width,wifiImage.size.height);
    imageView.contentMode = UIViewContentModeTop;
    [networkView addSubview:imageView];
    [networkView addSubview:connectivityStatusLabel];
    
    [self.window.rootViewController.view addSubview: networkView];
}

-(void)networkConnect{
    [networkView removeFromSuperview];
}

@end

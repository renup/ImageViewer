//
//  SingletonHelper.m
//  ImageViewer
//
//  Created by Renu P on 1/14/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import "SingletonHelper.h"
#import "Reachability.h"

static SingletonHelper *sharedHelper = nil;

@implementation SingletonHelper

@synthesize singletonHelperForViewControllerDelegate, internetConnectivity;

+ (SingletonHelper *)sharedHelper
{
    if(sharedHelper == nil){
        sharedHelper = [[SingletonHelper alloc] init];
    }
    return sharedHelper;
}

-(id)init
{
    if(self){
        self = [super init];
//        Reachability* reach = [Reachability reachabilityWithHostname:kJSON_URL];
//        
//        // Tell the reachability that we DON'T want to be reachable on 3G/EDGE/CDMA
//        // reach.reachableOnWWAN = NO;
//        
//        // Here we set up a NSNotification observer. The Reachability that caused the notification
//        // is passed in the object parameter
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(reachabilityChanged:)
//                                                     name:kReachabilityChangedNotification
//                                                   object:nil];
//        
//        [reach startNotifier];
    }
    return self;
}

#pragma mark - Reachability

//- (void)reachabilityChanged:(NSNotification *)note {
//    
//    NetworkStatus ns = [(Reachability *)[note object] currentReachabilityStatus];
//    
//    if (ns == NotReachable) {
//        
//        if (![self.networkAlert isVisible]) {
//            
////            if ([self networkAlert] == nil) {
//            
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"\n\nNo Internet Connection" message:@"You require an internet connection to communicate with the server." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
//                [self setNetworkAlert:alert];
////            }
//            
//            [self.networkAlert show];
//        }
//    } else {
//        
//        if ([self networkAlert] != nil) {
//            
//            [self.networkAlert dismissWithClickedButtonIndex:0 animated:YES];
//        }
//    }
//}

//-(void)reachabilityChanged:(NSNotification*)note
//{
//    Reachability * reach = [note object];
//    
//    if([reach isReachable])
//    {
//        self.internetConnectivity = TRUE;
//        [singletonHelperForViewControllerDelegate activityCallBackWhenInternetConnectivityIsEstablished]; //Call back when connectivity establishes back
//        NSLog (@"Notification Says Reachable");
//    }
//    else
//    {
//        self.internetConnectivity = FALSE;
//        [singletonHelperForViewControllerDelegate activityCallBackWhenNoInternetConnectivity];  //Call back when internet connectivity is lost.
//        NSLog(@"Notification Says Unreachable");
//    }
//}

- (void)networkChanged:(NSNotification *)notification
{
    
    Reachability * reachability = [notification object];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable) {
        self.internetConnectivity = FALSE;
        NSLog(@"Not Reachable");
    }
    else if (remoteHostStatus == ReachableViaWiFi) {
        self.internetConnectivity = TRUE;
        NSLog(@"Reachable Wifi");
    }
    else if (remoteHostStatus == ReachableViaWWAN) {
        self.internetConnectivity = TRUE;
        NSLog(@"Reachable WWAN");
    }
}





@end

//
//  SingletonHelper.h
//  ImageViewer
//
//  Created by Renu P on 1/14/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SingletonHelperDelegate

@optional
- (void)activityCallBackWhenNoInternetConnectivity;
- (void)activityCallBackWhenInternetConnectivityIsEstablished;
@end


@interface SingletonHelper : NSObject

+(SingletonHelper *)sharedHelper;

@property (nonatomic, weak) id <SingletonHelperDelegate> singletonHelperForViewControllerDelegate;
@property (nonatomic, assign) BOOL internetConnectivity;


@end



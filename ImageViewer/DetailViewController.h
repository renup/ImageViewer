//
//  DetailViewController.h
//  ImageViewer
//
//  Created by Renu P on 1/9/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SingletonHelper.h"

@interface DetailViewController : UIViewController <SingletonHelperDelegate>{
    UIScrollView* scrollView;

}

@property (strong, nonatomic) NSString *originalImageString;

@end

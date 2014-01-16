//
//  DetailViewController.h
//  ImageViewer
//
//  Created by Renu P on 1/9/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//


//This class displays the original image selected in MasterViewController
#import <UIKit/UIKit.h>


@interface DetailViewController : UIViewController {
    UIScrollView* scrollView;

}
/** original Image URL string passed by MasterViewController will be stored in originalImageString for using in this viewcontroller */
@property (nonatomic) NSString *originalImageString;

@end

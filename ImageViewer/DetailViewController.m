//
//  DetailViewController.m
//  ImageViewer
//
//  Created by Renu P on 1/9/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import "DetailViewController.h"
#import "FileDownloadManager.h"
#import "MBProgressHUD.h"
#import "UIImage+ImageManager.h"

@interface DetailViewController (){
    UIImageView * cellImageView;
    UIScrollView* scrollView;
}
@end

@implementation DetailViewController

@synthesize originalImageString;

#pragma mark - Managing the detail item

-(void)viewWillAppear:(BOOL)animated
{
    UIImage *originalPic = [[AppCache sharedAppCache] getImageForKey:self.originalImageString];
    
    scrollView=[[UIScrollView alloc] initWithFrame:self.view.frame];
    
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;

    cellImageView = [[UIImageView alloc] init];
    cellImageView.contentMode = UIViewContentModeCenter;

    
    if (originalPic) {
        cellImageView.image = originalPic;
        [self centerImage];
    }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [FileDownloadManager downloadAndGetImageForURL:self.originalImageString andResize:NO
                                                 block:^(BOOL succeeded, UIImage *image, NSError *error) {
            if (succeeded){
                cellImageView.image = image;
               [self centerImage];
                scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
            }
            else{
                NSLog(@"Error while downloading image - %@", error);
                UILabel *errorLable = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height/2 - 20, self.view.frame.size.width - 20, 40)];
                errorLable.text = @"Sorry no Image found";
                errorLable.textAlignment = NSTextAlignmentCenter;
                [cellImageView addSubview:errorLable];
            }

            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
    
    
    [scrollView addSubview:cellImageView];
    [self.view addSubview:scrollView];
    
}
-(void)centerImage{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGSize imageSize = cellImageView.image.size;
    CGFloat differenceWidth = screenSize.width - imageSize.width;
    CGFloat differenceHeight = screenSize.height - imageSize.height;
    
    if (differenceHeight <0) differenceHeight = 0;
    
    if (differenceWidth <0) differenceWidth =0;
    
//    scrollView.contentSize=CGSizeMake(546,480);
//    
//    cellImageView.frame = CGRectMake(0, 161, 546, 157);
//
//    return;
//    
    
    scrollView.contentSize = imageSize;
    
    cellImageView.frame = CGRectMake(differenceWidth/2,differenceHeight/2,imageSize.width,imageSize.height);
    
    [scrollView setScrollEnabled:YES];

}


-(void)centerImage2
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGSize imageSize = cellImageView.image.size;
    CGFloat differenceWidth = screenSize.width - imageSize.width;
    CGFloat differenceHeight = screenSize.height - imageSize.height;
    
    
    if (differenceHeight >= 0 && differenceWidth >= 0) {
        scrollView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
         cellImageView.frame = CGRectMake(differenceWidth, differenceHeight, cellImageView.image.size.width, cellImageView.image.size.height);
    
//        cellImageView.center = CGPointMake(CGRectGetMidX([[UIScreen mainScreen] bounds]), CGRectGetMidY([[UIScreen mainScreen] bounds]));
    }
    else if (differenceWidth <= 0 && differenceHeight >= 0){
        scrollView.frame = CGRectMake(0, 0, cellImageView.image.size.width, cellImageView.image.size.height);
        cellImageView.frame = CGRectMake(0, differenceHeight, cellImageView.image.size.width, cellImageView.image.size.height);
        
//        cellImageView.center = CGPointMake(CGRectGetMidX([[UIScreen mainScreen] bounds]) - differenceWidth, CGRectGetMidY([[UIScreen mainScreen] bounds]));


    }
    else if (differenceWidth >=0 && differenceHeight <=0){
        scrollView.frame = CGRectMake(0, 0, cellImageView.image.size.width, cellImageView.image.size.height);

        cellImageView.frame = CGRectMake(differenceWidth, 0, cellImageView.image.size.width, cellImageView.image.size.height);
        
//        cellImageView.center = CGPointMake(CGRectGetMidX([[UIScreen mainScreen] bounds]), CGRectGetMidY([[UIScreen mainScreen] bounds]) - differenceHeight);

    }
    else{
        scrollView.frame = CGRectMake(0, 0, cellImageView.image.size.width, cellImageView.image.size.height);

        cellImageView.frame = CGRectMake(0, 0, cellImageView.image.size.width, cellImageView.image.size.height);
//        cellImageView.center = CGPointMake(CGRectGetMidX([[UIScreen mainScreen] bounds]) - differenceWidth, CGRectGetMidY([[UIScreen mainScreen] bounds]) - differenceHeight);

    }
    
    scrollView.contentSize = CGSizeMake(cellImageView.image.size.width, cellImageView.image.size.height);

    cellImageView.center = CGPointMake(CGRectGetMidX([[UIScreen mainScreen] bounds]), CGRectGetMidY([[UIScreen mainScreen] bounds]));
    
    scrollView.center = cellImageView.center;
    [scrollView scrollRectToVisible:cellImageView.frame animated:YES];
    [scrollView setScrollEnabled:YES];
    
    //                [self.imageView setCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
    //                [cellImageView.frame setCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
    

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [UIApplication sharedApplication].statusBarHidden = TRUE;

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(showHideNavbar:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showHideNavbar:(id) sender
{
    // write code to show/hide nav bar here
    // check if the Navigation Bar is shown
    if (self.navigationController.navigationBar.hidden == NO)
    {
        // hide the Navigation Bar
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        // hide the status bar
   //     [UIApplication sharedApplication].statusBarHidden = TRUE;

    }
    // if Navigation Bar is already hidden
    else if (self.navigationController.navigationBar.hidden == YES)
    {
        // Show the Navigation Bar
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        // Show the status bar
    //    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        //[UIApplication sharedApplication].statusBarHidden = FALSE;

    }
}

@end

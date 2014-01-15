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
}
@end

@implementation DetailViewController

@synthesize originalImageString;

#pragma mark - Managing the detail item

-(void)viewWillAppear:(BOOL)animated
{
//    self.view.autoresizingMask = FALSE;
    
    UIImage *originalPic = [[AppCache sharedAppCache] getImageForKey:self.originalImageString];
    
    scrollView = [[UIScrollView alloc] init ];//WithFrame:self.view.frame];

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

-(void)centerImage2
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGSize imageSize = cellImageView.image.size;
    CGFloat differenceWidth = screenSize.width - imageSize.width;
    CGFloat differenceHeight = screenSize.height - imageSize.height;
    
//    if (differenceHeight >0) differenceHeight = 0;
    
//    if (differenceWidth >0) differenceWidth = 0;

    
    scrollView.frame = CGRectMake(-90, 0, 320, 480); // better
    
    scrollView.contentSize=CGSizeMake(500, 375);
    
    cellImageView.frame = CGRectMake(0, 52.5, 500, 375);

    
//    scrollView.frame = CGRectMake(-90, 0, 320+90, 480); // better
//
//    scrollView.contentSize=CGSizeMake(500, 375);
//
//
//    cellImageView.frame = CGRectMake(0, 52.5, 500 +90, 375);
    
    return;
    
    
    if(differenceWidth< 0 && differenceHeight <0){
        scrollView.frame = CGRectMake(differenceWidth/2, differenceHeight/2, screenSize.width - (differenceWidth/2), screenSize.height - (differenceHeight/2));
        scrollView.contentSize=CGSizeMake(imageSize.width, imageSize.height);

    cellImageView.frame = CGRectMake(differenceWidth/2, differenceHeight/2, imageSize.width -(differenceWidth/2), imageSize.height -(differenceHeight/2));
        
    }
    else if(differenceHeight < 0 && differenceWidth < 0){
        scrollView.frame = CGRectMake(0, differenceHeight/2, screenSize.width, screenSize.height - (differenceHeight/2));
        scrollView.contentSize=CGSizeMake(imageSize.width, imageSize.height);

        cellImageView.frame = CGRectMake(differenceWidth/2, 0, imageSize.width, imageSize.height - (differenceHeight/2));
    }
    else if (differenceWidth < 0 && differenceHeight > 0){
        //    scrollView.frame = CGRectMake(-90, 0, 320+90, 480); // better
        scrollView.frame = CGRectMake(differenceWidth/2, 0, screenSize.width - (differenceWidth/2), screenSize.height);
        
        
        scrollView.contentSize=imageSize;// CGSizeMake(imageSize.width, imageSize.height);
        
        //    cellImageView.frame = CGRectMake(0, 52.5, 500 +90, 375);
        cellImageView.frame = CGRectMake(0, differenceHeight/2, imageSize.width - differenceWidth/2, imageSize.height);
    }
    else{
        scrollView.frame = CGRectMake(differenceWidth/2, differenceHeight/2, screenSize.width, screenSize.height);
        scrollView.contentSize=CGSizeMake(imageSize.width, imageSize.height);

        cellImageView.frame = CGRectMake(differenceWidth/2, differenceHeight/2, imageSize.width, imageSize.height);
    }
    
    
  
//    scrollView.contentInset=UIEdgeInsetsMake(64.0,0.0,0.0,0.0);
//    scrollView.center = cellImageView.center;
   
    [scrollView setScrollEnabled:YES];

    
        return;
    
    scrollView.contentSize = imageSize;
    
    cellImageView.frame = CGRectMake(differenceWidth/2,differenceHeight/2,imageSize.width,imageSize.height);
    
    [scrollView setScrollEnabled:YES];
}

-(void)centerImage{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGSize imageSize = cellImageView.image.size;
    CGFloat differenceWidth = screenSize.width - imageSize.width;
    CGFloat differenceHeight = screenSize.height - imageSize.height;
    
//    if (differenceHeight <0) differenceHeight = 0;
//    if (differenceWidth <0) differenceWidth =0;
    
//    scrollView.contentSize=CGSizeMake(546,157);
//    
//    cellImageView.frame = CGRectMake(0, 161, 546, 157);
//    [scrollView setContentOffset:CGPointMake(90, 0) animated:NO];
//
//    return;
    
    scrollView.frame = self.view.frame;
    
    scrollView.contentSize = imageSize;
    
    if (differenceWidth <= 0 && differenceHeight >=0) {
        cellImageView.frame = CGRectMake(0, differenceHeight/2, imageSize.width, imageSize.height);
        [scrollView setContentOffset:CGPointMake(-(differenceWidth/2), 0) animated:NO];
    }
    else if (differenceHeight <=0 && differenceWidth >=0){
        cellImageView.frame = CGRectMake(differenceWidth/2, 0, imageSize.width, imageSize.height);
        [scrollView setContentOffset:CGPointMake(0, -(differenceHeight/2)) animated:NO];
    }
    else if (differenceWidth <= 0 && differenceHeight <= 0){
        cellImageView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        [scrollView setContentOffset:CGPointMake(-(differenceWidth/2), -(differenceHeight/2)) animated:NO];
    }
    else{
        cellImageView.frame = CGRectMake(differenceWidth/2, differenceHeight/2, imageSize.width, imageSize.height);
    }
    
    
//    cellImageView.frame = CGRectMake(differenceWidth/2,differenceHeight/2,imageSize.width,imageSize.height);
//    [scrollView setContentOffset:CGPointMake(90, 0) animated:NO];
    
    [scrollView setScrollEnabled:YES];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                               target:self
                               action:@selector(refresh:)];
    self.navigationItem.rightBarButtonItem = button;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(showHideNavbar:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (IBAction)refresh:(id)sender {
    [self.view setNeedsDisplay];
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
        // hide the status bar
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];

        // hide the Navigation Bar
        [self.navigationController setNavigationBarHidden:YES animated:YES];

    }
    // if Navigation Bar is already hidden
    else if (self.navigationController.navigationBar.hidden == YES)
    {
        // Show the status bar
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        // Show the Navigation Bar
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

@end

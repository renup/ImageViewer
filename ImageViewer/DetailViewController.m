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

@interface DetailViewController (){
    UIImageView * cellImageView;
    BOOL statusBarHidden;
}
@end

@implementation DetailViewController

@synthesize originalImageString;

#pragma mark - Managing the detail item

-(void)viewWillAppear:(BOOL)animated
{    
    UIImage *originalPic = [[AppCache sharedAppCache] getImageForKey:self.originalImageString];
    
    scrollView = [[UIScrollView alloc] init];
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;

    cellImageView = [[UIImageView alloc] init];
    cellImageView.contentMode = UIViewContentModeScaleAspectFit;
   
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

                UILabel *errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height/2 - 20, self.view.frame.size.width - 20, 40)];
                errorLabel.numberOfLines = 0;
                errorLabel.lineBreakMode = NSLineBreakByWordWrapping;
                errorLabel.text = @"Sorry No Image Found";
                errorLabel.textAlignment = NSTextAlignmentCenter;
                [self.view addSubview:errorLabel];
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
    
    [scrollView addSubview:cellImageView];
    [self.view addSubview:scrollView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    statusBarHidden = YES;
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(showHideNavbar:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden
{
    return statusBarHidden;
}

-(void) showHideNavbar:(id) sender
{
    
    statusBarHidden = !statusBarHidden;
    // write code to show/hide nav bar here
    // check if the Navigation Bar is shown
    if (self.navigationController.navigationBar.hidden == NO)
    {
        // hide the Navigation Bar
        [self.navigationController setNavigationBarHidden:YES animated:YES];

    }
    // if Navigation Bar is already hidden
    else if (self.navigationController.navigationBar.hidden == YES)
    {
        // Show the Navigation Bar
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

-(void)centerImage{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGSize imageSize = cellImageView.image.size;
    CGFloat differenceWidth = screenSize.width - imageSize.width;
    CGFloat differenceHeight = screenSize.height - imageSize.height;
    
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

@end

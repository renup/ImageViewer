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
    NSCache *_cache;
}
@end

@implementation DetailViewController

@synthesize cellImageView, originalImageString;

#pragma mark - Managing the detail item

-(void)viewWillAppear:(BOOL)animated
{
    UIImage *originalPic = [[AppCache sharedAppCache] getImageForString:self.originalImageString];
    
    if (originalPic) {
        self.cellImageView.image = originalPic;
    }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [FileDownloadManager dowloadAndGetImageForImageString:self.originalImageString andResize:NO block:^(BOOL succeeded, UIImage *image, NSError *error) {
            if (succeeded)
                self.cellImageView.image = image;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

-(void) showHideNavbar:(id) sender
{
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

@end

//
//  DetailViewController.m
//  ImageViewer
//
//  Created by Renu P on 1/9/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController (){
    NSCache *_cache;
}
@end

@implementation DetailViewController

@synthesize cellImageView, originalImageString;

#pragma mark - Managing the detail item

-(void)viewWillAppear:(BOOL)animated
{
    _cache = [[NSCache alloc] init];
    
    UIImage *originalPic = [_cache objectForKey:[NSString stringWithFormat:@"%@", self.originalImageString]];
    
    if (originalPic) {
        self.cellImageView.image = originalPic;
    }else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul), ^{
            
            NSURL *orignialImageURL = [NSURL URLWithString:self.originalImageString];
            NSData *originalImageData = [NSData dataWithContentsOfURL:orignialImageURL];
            UIImage *image  = [UIImage imageWithData:originalImageData];
            
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.cellImageView.image = image;
                    [self.view setNeedsDisplay];
                });
                [_cache setObject:image forKey:[NSString stringWithFormat:@"%@", self.originalImageString]];
            }
        });
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

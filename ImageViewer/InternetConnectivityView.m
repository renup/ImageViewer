//
//  InternetConnectivityView.m
//  PokeInI
//
//  Created by Renu Punjabi on 8/5/13.
//
//

#import "InternetConnectivityView.h"

static InternetConnectivityView *sharedInternetConnectivityView = nil;

@interface InternetConnectivityView(){
    
}

@end

@implementation InternetConnectivityView

//+(InternetConnectivityView *) getSharedInternetConnectivityView :(CGRect)viewControllerFrame
//{
//    if (sharedInternetConnectivityView == nil) {
//        sharedInternetConnectivityView = [[InternetConnectivityView alloc] initWithFrame:viewControllerFrame];
//    }
//    return sharedInternetConnectivityView;
//}

- (InternetConnectivityView *) initWithFrame:(CGRect)masterFrame {
    if (sharedInternetConnectivityView == nil) {
        sharedInternetConnectivityView = [super initWithFrame:masterFrame];

        self.tag = 14;
        
        self.frame = masterFrame;
        self.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.6];

        UILabel *noInternetConnectivityLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.origin.x + 20, self.frame.size.height/2, self.frame.size.width-40, 50)];
        noInternetConnectivityLabel.textAlignment = NSTextAlignmentCenter;
        [noInternetConnectivityLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
        noInternetConnectivityLabel.alpha = 1.0;
        noInternetConnectivityLabel.layer.cornerRadius = 8;
        noInternetConnectivityLabel.text = @"NO INTERNET CONNECTIVITY";
        [self addSubview:noInternetConnectivityLabel];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

//
//  ImageManager.m
//  ImageViewer
//
//  Created by Renu P on 1/11/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import "ImageManager.h"

@implementation ImageManager

+(ImageManager *)sharedImageManager
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//UIImage *newImage = [self imageWithImage:mainDelegate.starImage scaledToSize:CGSizeMake(640, 640)];

- (UIImage *)imageWithImage:(UIImage *)image
{
    CGSize newSize = CGSizeMake(image.size.width/2, image.size.height/2);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//- (UIImage *)getSubImage:(CGRect) rect{
//    
//    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
//    CGRect smallBounds = CGRectMake(rect.origin.x, rect.origin.y, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
//    
//    UIGraphicsBeginImageContext(smallBounds.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextDrawImage(context, smallBounds, subImageRef);
//    UIImage* smallImg = [UIImage imageWithCGImage:subImageRef];
//    UIGraphicsEndImageContext();
//    
//    return smallImg;
//}

//- (void)loadImageAsync:(NSString *)imageUrlStr
//{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul), ^{
//        NSURL *url = [NSURL URLWithString: imageUrlStr];
//        
//        /* apply daily time interval policy */
//        
//        /* In this program, "update" means to check the last modified date
//         of the image to see if we need to load a new version. */
////        [self getFileModificationDate];
//        
//        /* get the elapsed time since last file update */
//        NSTimeInterval time = fabs([fileDate timeIntervalSinceNow]);
//        if (time > 10.0) {
//            //        if (time > 604800000) {
//            //            if (time > URLCacheInterval) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                /* file doesn't exist or hasn't been updated for at least one week */
//                self.connection = [[URLCacheConnection alloc] initWithURL:url delegate:self];
//            });
//        }
//        else{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self displayCachedImage];
//                // NSLog(@"load the image from cache now");
//            });
//        }
//        
//    });
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

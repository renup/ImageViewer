//
//  UIImage+ImageManager.m
//  ImageViewer
//
//  Created by Renu P on 1/12/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import "UIImage+ImageManager.h"

@implementation UIImage (ImageManager)


- (UIImage *)resizeImageToWidth:(float)widthVal andHeight:(float)heightVal
{
    CGSize newSize = CGSizeMake(widthVal, heightVal);
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//-(UIImage *)makeRoundedImage:(UIImage *) image radius: (float) radius
//{
//    CALayer *imageLayer = [CALayer layer];
//    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
//    imageLayer.contents = (id) image.CGImage;
//    
//    imageLayer.masksToBounds = YES;
//    imageLayer.cornerRadius = radius;
//    imageLayer.borderColor = [[UIColor blackColor] CGColor];
//    
//    UIGraphicsBeginImageContext(image.size);
//    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return roundedImage;
//}

#pragma mark - Image
+(UIImage*)imageFitInCenterForSize:(CGSize)inSize forSourceImage:(UIImage*)inImage
{
    // redraw the image to fit |yourView|'s size
    CGSize imageOriginalSize = inImage.size;
    UIImage *resultImage = nil;
    if (imageOriginalSize.width<=inSize.width && imageOriginalSize.height<=inSize.height)
    {
        UIGraphicsBeginImageContextWithOptions(inSize, NO, 0.f);
        [inImage drawInRect:CGRectMake((inSize.width-imageOriginalSize.width)/2.0, (inSize.height-imageOriginalSize.height)/2.0, imageOriginalSize.width, imageOriginalSize.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return resultImage;
}




@end

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

-(UIImage *)cropImage:(UIImage *)inputImage
{
    CGRect inputImageRect;

    if (inputImage.size.width == inputImage.size.height){
        return inputImage;
    }
    else{
        if (inputImage.size.width < inputImage.size.height)
            inputImageRect = CGRectMake(0, 0, inputImage.size.width, inputImage.size.width);
        else
            inputImageRect = CGRectMake(0, 0, inputImage.size.height, inputImage.size.height);
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, inputImageRect);
    
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    return image;
}

@end

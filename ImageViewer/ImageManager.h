//
//  ImageManager.h
//  ImageViewer
//
//  Created by Renu P on 1/11/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageManager : UIView

+(ImageManager *)sharedImageManager;

- (UIImage *)imageWithImage:(UIImage *)image;

@end

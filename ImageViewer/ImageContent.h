//
//  ImageContent.h
//  ImageViewer
//
//  Created by Renu P on 1/11/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageContent : NSObject

@property (nonatomic, copy) NSString *caption;
@property (nonatomic, copy) NSString *thumbImageStr;
@property (nonatomic, copy) NSString *originalImageStr;

-(ImageContent *) initImageContentWithCaption:(NSString *)captionStr thumbString:(NSString *)thumbString andOriginalImageString:(NSString *)originalImageString;

@end

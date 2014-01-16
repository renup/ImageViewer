//
//  ImageContent.h
//  ImageViewer
//
//  Created by Renu P on 1/11/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

//This class creates image objects
#import <Foundation/Foundation.h>

@interface ImageContent : NSObject

/** creating three attributes of Image object - caption, thumbImage URL string and original image URL string */
@property (nonatomic, copy) NSString *caption;
@property (nonatomic, copy) NSString *thumbImageStr;
@property (nonatomic, copy) NSString *originalImageStr;

/** This method will initialize the image content object with three attributes caption, thumbImage URL string and original image URL string */
-(ImageContent *) initImageContentWithCaption:(NSString *)captionStr thumbString:(NSString *)thumbString andOriginalImageString:(NSString *)originalImageString;

@end

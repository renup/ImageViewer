//
//  ImageContent.m
//  ImageViewer
//
//  Created by Renu P on 1/11/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import "ImageContent.h"
#import "FileDownloadManager.h"


@interface ImageContent(){

}

@end

@implementation ImageContent

@synthesize caption, thumbImageStr, originalImageStr;

-(ImageContent *) initImageContentWithCaption:(NSString *)captionStr thumbString:(NSString *)thumbString andOriginalImageString:(NSString *)originalImageString
{
    self = [super init];
    
    if (self) {
        self.caption = captionStr;
        self.thumbImageStr = thumbString;
        self.originalImageStr = originalImageString;
        
        // run thread to download the images asynchronously
    }
    return self;
}


@end

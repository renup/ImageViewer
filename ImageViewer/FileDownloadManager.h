//
//  FileDownloadManager.h
//  ImageViewer
//
//  Created by Renu P on 1/11/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileDownloadManager : NSObject

+(void)downloadAndGetImageForURL:(NSString *)imageString andResize:(BOOL)imageNeedResizing
                          block:(void (^)(BOOL succeeded, UIImage *image, NSError *error))blockAfterCompletion;

+(void)downloadTheFile:(NSString *)URLStr
                 block:(void (^)(BOOL succeeded, NSData *data, NSError *error))completionBlock;

+(void)downloadAndGetJSONForURL:(NSString *)URLStr
                          block:(void (^)(BOOL succeeded, NSArray* jsonArr, NSError *error))blockForCompletion;

@end

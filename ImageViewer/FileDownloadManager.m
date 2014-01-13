//
//  FileDownloadManager.m
//  ImageViewer
//
//  Created by Renu P on 1/11/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import "FileDownloadManager.h"
#import "UIImage+ImageManager.h"

@implementation FileDownloadManager

+(void)downloadTheFile:(NSString *)URLStr block:(void (^)(BOOL succeeded, NSData *data, NSError *error))completionBlock
{
    __block NSData *urlData;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul), ^{
        NSURL *url = [NSURL URLWithString:URLStr];
        urlData = [NSData dataWithContentsOfURL:url];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *error;
            if (urlData) {
                if (completionBlock)
                    completionBlock(TRUE, urlData, nil);
            }else{
                if (completionBlock)
                    completionBlock(FALSE, urlData, error);
            }

        });
    });
}


+(void)downloadAndSaveJSON:(NSString *)URLStr block:(void (^)(BOOL succeeded, NSError *error))blockForCompletion
{
    //applications Documents dirctory path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"data.json"];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    
    if (!fileExists) {
        
       [self downloadTheFile:URLStr block:^(BOOL succeeded, NSData *data, NSError *error) {
           if (!error){
                [data writeToFile:filePath atomically:YES];
               if (blockForCompletion)
                   blockForCompletion(TRUE, nil);
               
           }else{
                NSLog(@"There was an error while downloading the JSON file from web - %@", error);
               if (blockForCompletion)
                   blockForCompletion(FALSE, error);
               
           }
       }];
        
    }else{
        if (blockForCompletion) {
            blockForCompletion(TRUE, nil);
        }
    }
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul), ^{
//            //live json data url
////            NSString *stringURL = @"http://dl.dropboxusercontent.com/u/89445730/images.json";
//            NSString *stringURL = URLStr;
//            NSURL *url = [NSURL URLWithString:stringURL];
//            NSData *urlData = [NSData dataWithContentsOfURL:url];
//            
//            //attempt to download live data
//            if (urlData){
//                [urlData writeToFile:filePath atomically:YES];
//            }
//        });
        
    
}

+(void)dowloadAndGetImageForImageString:(NSString *)imageString andResize:(BOOL)imageNeedResizing block:(void (^)(BOOL succeeded, UIImage *image, NSError *error))blockAfterCompletion
{
    UIImage *picFromCache = [[AppCache sharedAppCache] getImageForString:imageString];
    
    if (picFromCache) {
        if (blockAfterCompletion)
            blockAfterCompletion(TRUE, picFromCache, nil);
        
    }else{
        if (imageString != nil) {
            [self downloadTheFile:imageString block:^(BOOL succeeded, NSData *data, NSError *error) {
                
                if (succeeded) {
                    UIImage *image = [UIImage imageWithData:data];
                    if (imageNeedResizing) {
                        UIImage *resizedImage = [image resizeImageToWidth:50.f andHeight:50.f];
                        [[AppCache sharedAppCache] setImage:resizedImage forKey:imageString];
                        
                        if (blockAfterCompletion)
                            blockAfterCompletion(TRUE, resizedImage, nil);
                        
                    }else{
                        [[AppCache sharedAppCache] setImage:image forKey:imageString];
                        
                        if (blockAfterCompletion)
                            blockAfterCompletion(TRUE, image, nil);
                    }
                }else{
                    
                    if (blockAfterCompletion)
                        blockAfterCompletion(FALSE, nil, error);
                }
            }];
        }
    }
}



@end

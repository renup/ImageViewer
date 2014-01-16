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

+(void)downloadTheFile:(NSString *)URLStr
                 block:(void (^)(BOOL succeeded, NSData *data, NSError *error))completionBlock
{
    __block NSData *urlData;
    
    //Download the data asynchronously
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul), ^{
        NSURL *url = [NSURL URLWithString:URLStr];
        urlData = [NSData dataWithContentsOfURL:url];
        
        //Once the asynchronous thread execution ends, we are sending the data on Main thread for executing the completion block.
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


+(void)downloadAndGetJSONForURL:(NSString *)URLStr
                          block:(void (^)(BOOL succeeded, NSArray* jsonArr, NSError *error))blockForCompletion
{
    //applications Documents directory path
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"data.json"];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    
    if (!fileExists) {
        
       [self downloadTheFile:URLStr block:^(BOOL succeeded, NSData *data, NSError *error) {

           if (succeeded){
               //Saving the file locally
                [data writeToFile:filePath atomically:YES];
               
               if (blockForCompletion){
                   NSError *jsonError;
                   //Parsing/Serializing the JSON file and returning the result in the calling class which in this case will be MasterViewController. This method returns an array of image dictionary items.
                   NSArray* serializedJSONArr = [NSJSONSerialization
                                                 JSONObjectWithData:data
                                                 options:kNilOptions
                                                 error:&jsonError];
                   blockForCompletion(TRUE, serializedJSONArr, nil);
               }
               
           }else{
               if (blockForCompletion)
                   blockForCompletion(FALSE, nil, error);
           }
       }];
        
    }else{
        
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (blockForCompletion) {
            NSError *jsonError;
            //Parsing/Serializing the JSON file and returning the result in the calling class which in this case will be MasterViewController. This method returns an array of image dictionary items.
            NSArray* serializedJSONArr = [NSJSONSerialization
                                          JSONObjectWithData:data
                                          options:kNilOptions
                                          error:&jsonError];
            blockForCompletion(TRUE, serializedJSONArr, nil);
        }
    }
}


+(void)downloadAndGetImageForURL:(NSString *)imageString
                       andResize:(BOOL)imageNeedResizing
                          block:(void (^)(BOOL succeeded, UIImage *image, NSError *error))blockAfterCompletion
{
    UIImage *picFromCache = [[AppCache sharedAppCache] getImageForKey:imageString];
    
    //if image found in cache then send it to the calling class
    if (picFromCache) {
        if (blockAfterCompletion)
            blockAfterCompletion(TRUE, picFromCache, nil);
        
    }else{ //downloading the image as it is not cached yet
        if (imageString != nil) {
            
            [self downloadTheFile:imageString block:^(BOOL succeeded, NSData *data, NSError *error) {

                if (succeeded) {
                    UIImage *image = [UIImage imageWithData:data];
                    if (imageNeedResizing) {
                        UIImage *thumb = [UIImage imageWithData:data];
                        thumb = [thumb cropImage]; //using UIImage category method to crop to either full width or full height
                        thumb = [thumb resizeImageToWidth:50 andHeight:50]; //using UIImage category method to resize it after cropping
                        
                        //Saving it in cache
                        [[AppCache sharedAppCache] setImage:thumb forKey:imageString];
                        
                        if (blockAfterCompletion)
                            blockAfterCompletion(TRUE, thumb, nil);
                        
                    }else{
                        
                        //Saving it in cache
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

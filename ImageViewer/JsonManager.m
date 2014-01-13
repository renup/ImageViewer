//
//  JsonManager.m
//  ImageViewer
//
//  Created by Renu P on 1/10/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import "JSONManager.h"

@interface JSONManager(){
}

@end

@implementation JSONManager

@synthesize imagesArray;

-(void)parseJSONAndCreateImageContentObjects
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                                    objectAtIndex:0];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"data.json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    NSArray* jsonArr = [NSJSONSerialization
                     JSONObjectWithData:jsonData
                     options:kNilOptions
                     error:&error];
    imagesArray = [NSMutableArray array];
    for(NSDictionary *imageDict in jsonArr){
        if (([imageDict objectForKey:kCaptionKey] != [NSNull null]) && ([imageDict objectForKey:kThumbImageKey] != [NSNull null]) && ([imageDict objectForKey:kOriginalImageKey]!= [NSNull null])) {
            ImageContent *imageContentObject = [[ImageContent alloc]
                                                initImageContentWithCaption:[imageDict objectForKey:kCaptionKey]
                                                thumbString:[imageDict objectForKey:kThumbImageKey]
                                                andOriginalImageString:[imageDict objectForKey:kOriginalImageKey]];
            
            [self.imagesArray addObject:imageContentObject];
        }
    }
}

//Source: http://stackoverflow.com/questions/20543206/saving-json-file-to-iphone
//- (void)writeJsonToDocumentsDirectory
//{
//    //applications Documents dirctory path
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    
//    filePath = [documentsDirectory stringByAppendingPathComponent:@"data.json"];
//
//    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
//    
//    if (!fileExists) {
//        
//        //live json data url
//        NSString *stringURL = @"http://dl.dropboxusercontent.com/u/89445730/images.json";
//        NSURL *url = [NSURL URLWithString:stringURL];
//        NSData *urlData = [NSData dataWithContentsOfURL:url];
//        
//        //attempt to download live data
//        if (urlData)
//        {
//            //            NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"data.json"];
//            [urlData writeToFile:filePath atomically:YES];
//        }
//    }
//}

//- (NSArray *)fetchedData
//{
//    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
//    
//    //parse out the json data
//    NSError* error;
//    NSArray* json = [NSJSONSerialization
//                          JSONObjectWithData:fileData //1
//                          options:kNilOptions
//                          error:&error];
//    if (error) {
//        NSLog(@"Error while fetching the Json data from documents directory : %@", error);
//    }
//    
//    return json;
//}



@end

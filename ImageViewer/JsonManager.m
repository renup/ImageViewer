//
//  JsonManager.m
//  ImageViewer
//
//  Created by Renu P on 1/10/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//

#import "JsonManager.h"

@interface JsonManager(){
    NSString *filePath;
}

@end

@implementation JsonManager

//-(JsonManager *)init
//{
//    self = [super init];
//    if (self) {
//        
//    }
//    return self;
//    
//}


//Source: http://stackoverflow.com/questions/20543206/saving-json-file-to-iphone
- (void)writeJsonToDocumentsDirectory
{
    //applications Documents dirctory path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    filePath = [documentsDirectory stringByAppendingPathComponent:@"data.json"];

    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    
    if (!fileExists) {
        
        //live json data url
        NSString *stringURL = @"http://dl.dropboxusercontent.com/u/89445730/images.json";
        NSURL *url = [NSURL URLWithString:stringURL];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        
        //attempt to download live data
        if (urlData)
        {
            //            NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"data.json"];
            [urlData writeToFile:filePath atomically:YES];
        }
        //copy data from initial package into the applications Documents folder
//        else
//        {
//            //file to write to
//            //            NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"data.json"];
//            filePath = [documentsDirectory stringByAppendingPathComponent:@"data.json"];
//            NSLog(@"\n\nthe string %@",filePath);
//            
//            //file to copy from
//            NSString *json = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json" inDirectory:@"html/data"];
//            NSData *jsonData = [NSData dataWithContentsOfFile:json options:kNilOptions error:nil];
//            
//            //write file to device
//            [jsonData writeToFile:filePath atomically:YES];
//        }        
    }
}

- (NSArray *)fetchedData
{
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    //parse out the json data
    NSError* error;
    NSArray* json = [NSJSONSerialization
                          JSONObjectWithData:fileData //1
                          options:kNilOptions
                          error:&error];
    if (error) {
        NSLog(@"Error while fetching the Json data from documents directory : %@", error);
    }
    
    return json;
}



@end

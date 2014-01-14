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



@end

//
//  MasterViewController.m
//  ImageViewer
//
//  Created by Renu P on 1/9/14.
//  Copyright (c) 2014 Renu Punjabi. All rights reserved.
//
#import "MasterViewController.h"
#import "FileDownloadManager.h"
#import "ImageContent.h"
#import "DetailViewController.h"


@interface MasterViewController () {
    NSMutableArray * imageContentObjectsArr;
    ImageContent *imageContentobj;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Reload issues button
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                               target:self
                               action:@selector(refresh:)];
    self.navigationItem.rightBarButtonItem = button;
         
    [FileDownloadManager downloadAndGetJSONForURL:kJSON_URL block:^(BOOL succeeded, NSArray* jsonArr, NSError *error) {
        if (succeeded) {
            imageContentObjectsArr = [NSMutableArray array];
            
            for(NSDictionary *imageDict in jsonArr){
                
                if (([imageDict objectForKey:kCaptionKey] != [NSNull null]) && ([imageDict objectForKey:kThumbImageKey] != [NSNull null]) && ([imageDict objectForKey:kOriginalImageKey]!= [NSNull null])) {
                    
                    //Making Image Content objects
                    ImageContent *imageContentObject = [[ImageContent alloc]
                                                        initImageContentWithCaption:[imageDict objectForKey:kCaptionKey]
                                                        thumbString:[imageDict objectForKey:kThumbImageKey]
                                                        andOriginalImageString:[imageDict objectForKey:kOriginalImageKey]];
                    
                    [imageContentObjectsArr addObject:imageContentObject];
                }
            }
            [self.tableView reloadData];
        }
    }];
}

- (IBAction)refresh:(id)sender {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return imageContentObjectsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.numberOfLines = 0;
    
    cell.imageView.layer.backgroundColor=[[UIColor clearColor] CGColor];
    cell.imageView.layer.cornerRadius=10;
    cell.imageView.layer.borderWidth=1.50;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.borderColor=[[UIColor blackColor] CGColor];
    
    imageContentobj = imageContentObjectsArr[indexPath.row];
    
    UIImage *thumbPic = [[AppCache sharedAppCache] getImageForKey:imageContentobj.thumbImageStr];
    if (thumbPic) {
        cell.imageView.image = thumbPic;
    }else{
        cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        
        [FileDownloadManager downloadAndGetImageForURL:imageContentobj.thumbImageStr
                                             andResize:YES
                                                 block:^(BOOL succeeded, UIImage *image, NSError *error) {
                                                     if (succeeded)
                                                         cell.imageView.image = image;
                                                     else
                                                         cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        }];
    }
    
        cell.textLabel.text = imageContentobj.caption;
    return cell;
}

#pragma mark - UITableViewDelegate methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    imageContentobj = [imageContentObjectsArr objectAtIndex:indexPath.row];
    NSAttributedString * attributedString = [[NSAttributedString alloc] initWithString:imageContentobj.caption attributes:
                                             @{ NSFontAttributeName: [UIFont systemFontOfSize:18]}];
    
    //its not possible to get the cell label width since this method is called before cellForRow so best we can do
    //is get the table width and subtract the default extra space on either side of the label.
    CGSize constraintSize = CGSizeMake(tableView.frame.size.width - 30, MAXFLOAT);
    
    CGRect rect = [attributedString boundingRectWithSize:constraintSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
    
    //Add back in the extra padding above and below label on table cell.
    rect.size.height = rect.size.height + 43;
    
    //if height is smaller than a normal row set it to the normal cell height, otherwise return the bigger dynamic height.
    return (rect.size.height < 44 ? 44 : rect.size.height);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        imageContentobj = imageContentObjectsArr[indexPath.row];
        [[segue destinationViewController] setOriginalImageString:imageContentobj.originalImageStr];
    }
}

@end

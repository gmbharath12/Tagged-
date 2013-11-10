//
//  SearchViewController.m
//  FBSample
//
//  Created by Bharath G M on 10/26/13.
//  Copyright (c) 2013 Bharath G M. All rights reserved.
//

#import "SearchViewController.h"
#import "AsyncImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "DetailViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize m_cTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"DataObjects count = %d",self.dataObjects.count);
    self.m_cTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 420) style:UITableViewStylePlain];
    self.m_cTableView.delegate = self;
    self.m_cTableView.dataSource = self;
    [self.view addSubview:self.m_cTableView];
}


#pragma mark-
#pragma mark datasource and delegate methods - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Count = %d",self.dataObjects.count);
    return self.dataObjects.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        AsyncImageView* oldImage = (AsyncImageView*)[cell.contentView viewWithTag:999];
        [oldImage removeFromSuperview];
    }
    DataModelObject *dataModelObject = [self.dataObjects objectAtIndex:indexPath.row];
    NSLog(@"picture URl = %@",dataModelObject.picture);
    cell.contentView.hidden = NO;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    CGRect frame;
    frame.size.width = 40;
    frame.size.height = 40;
    frame.origin.x = 275;
    frame.origin.y = 15;
    AsyncImageView* asyncImage = [[AsyncImageView alloc]
                                  initWithFrame:frame] ;
    asyncImage.tag = 999;
    
    asyncImage.layer.cornerRadius = 5.0;
    asyncImage.layer.borderWidth = 2.0;
    asyncImage.layer.borderColor = [UIColor blackColor].CGColor;

    [asyncImage loadImageFromURL:[NSURL URLWithString:dataModelObject.picture]];
    
    [cell.contentView addSubview:asyncImage];
    cell.textLabel.text =[[self.dataObjects objectAtIndex:indexPath.row] name];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.dataObject = [self.dataObjects objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

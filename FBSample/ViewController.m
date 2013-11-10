//
//  ViewController.m
//  FBSample
//
//  Created by Bharath G M on 10/26/13.
//  Copyright (c) 2013 Bharath G M. All rights reserved.
//

#import "ViewController.h"
#import "DataModelObject.h"
#import "SearchViewController.h"

#define kNavigationBarTitle @"Tagged";
#define kData @"data"
#define kFrom @"from"
#define kName @"name"
#define kMessage @"message"
#define kPicture @"picture"

@interface ViewController ()<FBLoginViewDelegate>

- (IBAction)searchAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) NSDictionary *jsonDictionary;
@property (strong,nonatomic) DataModelObject *dataObject;
@property (strong,nonatomic) NSArray *arrayOfObjects; //passed to next contorller
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = kNavigationBarTitle
    FBLoginView *loginview = [[FBLoginView alloc] initWithFrame:CGRectMake(0, 70, 240, 5)];
    loginview.frame = CGRectOffset(loginview.frame, 15, 5);
    loginview.delegate = self;
    
    [self.view addSubview:loginview];
    
    self.nameLabel.hidden = YES;
    self.imageView.hidden = YES;
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    if ([FBSession activeSession].accessTokenData != nil)
//    {
//        [self getData];
//    }
//    else
//    {
//        NSLog(@"Please sign in to see the results");
//        
//    }
//
//}
//
//-(void)viewDidAppear:(BOOL)animated
//{
//
//}

-(void)getData
{
    
    NSString *theWholeUrl = [NSString stringWithFormat:@"https://graph.facebook.com/search?q=modi&access_token=%@",FBSession.activeSession.accessTokenData];
    
    NSLog(@"Token = %@",[FBSession activeSession].accessTokenData);
    NSLog(@"TheWholeUrl: %@", theWholeUrl);
    NSURL *facebookUrl = [NSURL URLWithString:theWholeUrl];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:facebookUrl];
                       [req setHTTPMethod:@"GET"];
                       
                       NSURLResponse *response;
                       NSError *err;
                       NSData *responseData = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&err];
                       NSDictionary* json = [NSJSONSerialization
                                             JSONObjectWithData:responseData
                                             
                                             options:kNilOptions 
                                             error:&err];
                       self.jsonDictionary = json;
                       NSLog(@"No of objects: %d", [[json objectForKey:@"data"] count]);

                       NSString *content = [NSString stringWithUTF8String:[responseData bytes]];
                       [self parseData:self.jsonDictionary];

                       dispatch_async(dispatch_get_main_queue(),
                                      ^{
                                          [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                          NSLog(@"responseData: %@", content);
                                       });
                    }
                   
                   );
}


#pragma mark-
#pragma mark Parse data

-(void)parseData:(NSDictionary*)json
{
    NSArray *lArray = [NSArray array];
   lArray = [json objectForKey:kData];
    NSLog(@"Name = %@",[[[lArray objectAtIndex:0] objectForKey:kFrom] objectForKey:kName]);
    
    NSMutableArray *arrayOfDataModelObjects = [NSMutableArray array];
    
    for (int i = 0; i < [lArray count]; i++)
    {
        self.dataObject = [[DataModelObject alloc] init];
        self.dataObject.name = [[[lArray objectAtIndex:i] objectForKey:kFrom] objectForKey:kName];
        self.dataObject.message = [[lArray objectAtIndex:i] objectForKey:kMessage];
        self.dataObject.picture = [[lArray objectAtIndex:i] objectForKey:kPicture];
        NSLog(@"Data Object = %@",self.dataObject.picture);
        [arrayOfDataModelObjects addObject:self.dataObject];
    }
    self.arrayOfObjects = arrayOfDataModelObjects;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)loginView:(FBLoginView *)loginView
      handleError:(NSError *)error
{
    
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    self.nameLabel.hidden = NO;
    self.imageView.hidden = NO;
}
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user
{
    self.nameLabel.hidden = NO;
    self.imageView.hidden = NO;
    
    self.nameLabel.text= user.name;
    
}
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    self.nameLabel.hidden = YES;
    self.imageView.hidden = YES;
}

- (IBAction)searchAction:(id)sender
{
    SearchViewController *searchController = [[SearchViewController alloc] init];
    NSLog(@"Array objects = %d",[self.arrayOfObjects count]);
    searchController.dataObjects = self.arrayOfObjects;
    [self.navigationController pushViewController:searchController animated:YES];
}


@end

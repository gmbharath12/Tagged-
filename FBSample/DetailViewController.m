//
//  DetailViewController.m
//  FBSample
//
//  Created by Bharath G M on 10/27/13.
//  Copyright (c) 2013 Bharath G M. All rights reserved.
//

#import "DetailViewController.h"
@interface DetailViewController ()

@property (weak,nonatomic)  IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    NSLog(@"Text = %@",self.dataObject.message);
    
    [self.textView setScrollEnabled:YES];
    [self.textView setText:self.dataObject.message];
    [self.textView setTextColor:[UIColor blueColor]];
    [self.textView setShowsVerticalScrollIndicator:YES];
    [self.textView setShowsHorizontalScrollIndicator:NO];
    [self.textView setEditable:NO];
    
    if (self.dataObject.message == nil)
    {
        [self.textView setText:[NSString stringWithFormat:@"No comments by %@",self.dataObject.name]];
    }


    
}



@end

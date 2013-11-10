//
//  SearchViewController.h
//  FBSample
//
//  Created by Bharath G M on 10/26/13.
//  Copyright (c) 2013 Bharath G M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModelObject.h"

@interface SearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *m_cTableView;
}
@property(nonatomic,strong) UITableView *m_cTableView;
@property(nonatomic,strong) DataModelObject *dataModelObject;
@property(nonatomic,strong) NSArray *dataObjects;
@end

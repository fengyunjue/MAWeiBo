//
//  MWDiscoverViewController.m
//  MAWeibo
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 mage. All rights reserved.
//

#import "MWDiscoverViewController.h"
#import "MWSearchBar.h"

@interface MWDiscoverViewController ()

@end

@implementation MWDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MWSearchBar *textField = [MWSearchBar searchBar];
    self.navigationItem.titleView = textField;
}


@end

//
//  RWTViewModelServicesImpl.m
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 29/05/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTViewModelServicesImpl.h"
#import "RWTFlickrSearchImpl.h"
#import "RWTSearchResultsViewController.h"

@interface RWTViewModelServicesImpl ()

@property (strong, nonatomic) RWTFlickrSearchImpl *searchService;
@property (weak, nonatomic) UINavigationController *navigationController;

@end

@implementation RWTViewModelServicesImpl

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
  if (self = [super init]) {
    _searchService = [RWTFlickrSearchImpl new];
    _navigationController = navigationController;
  }
  return self;
}


- (id<RWTFlickrSearch>)getFlickrSearchService {
  return  self.searchService;
}

- (void)pushViewModel:(id)viewModel {
  id viewController;
  
  if ([viewModel isKindOfClass:RWTSearchResultsViewModel.class]) {
    viewController = [[RWTSearchResultsViewController alloc] initWithViewModel:viewModel];
  } else {
    NSLog(@"an unknown ViewModel was pushed!");
  }
  
  [self.navigationController pushViewController:viewController animated:YES];
}

@end

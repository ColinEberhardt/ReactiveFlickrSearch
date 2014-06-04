//
//  RWTSearchResultsViewModel.m
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 01/06/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsViewModel.h"
#import "RWTFlickrPhoto.h"
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>
#import "RWTSearchResultsItemViewModel.h"

@implementation RWTSearchResultsViewModel

- (instancetype)initWithSearchResults:(RWTFlickrSearchResults *)results
                             services:(id<RWTViewModelServices>)services {
  if (self = [super init]) {
    _title = results.searchString;
    _searchResults =
      [results.photos linq_select:^id(RWTFlickrPhoto *photo) {
        return [[RWTSearchResultsItemViewModel alloc]
                  initWithPhoto:photo services:services];
      }];
  }
  return self;
}

@end

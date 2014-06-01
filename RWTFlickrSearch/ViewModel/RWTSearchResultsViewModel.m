//
//  RWTSearchResultsViewModel.m
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 01/06/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsViewModel.h"

@implementation RWTSearchResultsViewModel

- (instancetype)initWithSearchResults:(RWTFlickrSearchResults *)results
                             services:(id<RWTViewModelServices>)services {
  if (self = [super init]) {
    _title = results.searchString;
    _searchResults = results.photos;
  }
  return self;
}

@end

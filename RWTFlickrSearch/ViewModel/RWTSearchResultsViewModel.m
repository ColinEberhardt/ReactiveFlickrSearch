//
//  RWTSearchResultsViewModel.m
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 01/06/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsViewModel.h"
#import "RWTFlickrPhoto.h"

@implementation RWTSearchResultsViewModel

- (instancetype)initWithSearchResults:(RWTFlickrSearchResults *)results
                             services:(id<RWTViewModelServices>)services {
  if (self = [super init]) {
    _title = results.searchString;
    _searchResults = results.photos;
    
    RWTFlickrPhoto *photo = results.photos.firstObject;
    RACSignal *metaDataSignal = [[services getFlickrSearchService]
                                 flickrImageMetadata:photo.identifier];
    [metaDataSignal subscribeNext:^(id x) {
      NSLog(@"%@", x);
    }];
  }
  return self;
}

@end

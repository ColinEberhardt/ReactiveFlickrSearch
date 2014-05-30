//
//  RWTViewModelServicesImpl.m
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 29/05/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTViewModelServicesImpl.h"
#import "RWTFlickrSearchImpl.h"

@interface RWTViewModelServicesImpl ()

@property (strong, nonatomic) RWTFlickrSearchImpl *searchService;

@end

@implementation RWTViewModelServicesImpl

- (id)init {
  if (self = [super init]) {
    _searchService = [RWTFlickrSearchImpl new];
  }
  return self;
}

- (id<RWTFlickrSearch>)getFlickrSearchService {
  return  self.searchService;
}

@end

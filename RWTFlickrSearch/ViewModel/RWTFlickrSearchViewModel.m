//
//  RWTFlickrSearchViewModel.m
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 27/05/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation RWTFlickrSearchViewModel

- (instancetype)init {
  self = [super init];
  if (self) {
    [self initialize];
  }
  return self;
}

- (void)initialize {
  self.title = @"Flickr Search";
  
  RACSignal *validSearchSignal =
    [[RACObserve(self, searchText)
      map:^id(NSString *text) {
         return @(text.length > 3);
      }]
      distinctUntilChanged];
  
  [validSearchSignal subscribeNext:^(id x) {
    NSLog(@"search text is valid %@", x);
  }];
}

@end

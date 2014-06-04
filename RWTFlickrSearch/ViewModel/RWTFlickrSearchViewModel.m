//
//  RWTFlickrSearchViewModel.m
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 27/05/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewModel.h"
#import "RWTSearchResultsViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RWTFlickrSearchViewModel ()

@property (weak, nonatomic) id<RWTViewModelServices> services;

@end


@implementation RWTFlickrSearchViewModel

- (instancetype)initWithServices:(id<RWTViewModelServices>)services {
  self = [super init];
  if (self) {
    _services = services;
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
  
  self.executeSearch =
    [[RACCommand alloc] initWithEnabled:validSearchSignal
      signalBlock:^RACSignal *(id input) {
        return  [self executeSearchSignal];
      }];
  
  self.connectionErrors = self.executeSearch.errors;
}

-(RACSignal *)executeSearchSignal {
  return [[[self.services getFlickrSearchService]
    flickrSearchSignal:self.searchText]
    doNext:^(id result) {
      RWTSearchResultsViewModel *resultsViewModel =
        [[RWTSearchResultsViewModel alloc] initWithSearchResults:result
                                                        services:self.services];
      [self.services pushViewModel:resultsViewModel];
    }];
}

@end

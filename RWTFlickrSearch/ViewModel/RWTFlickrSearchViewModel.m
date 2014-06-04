//
//  RWTFlickrSearchViewModel.m
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 27/05/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewModel.h"
#import "RWTSearchResultsViewModel.h"
#import "RWTPreviousSearchViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>

@interface RWTFlickrSearchViewModel ()

@property (weak, nonatomic) id<RWTViewModelServices> services;
@property NSMutableArray *mutablePreviousSearches;

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
  
  self.mutablePreviousSearches = [NSMutableArray new];
  self.previousSearches = [NSArray new];
}

-(RACSignal *)executeSearchSignal {
  return [[[self.services getFlickrSearchService]
    flickrSearchSignal:self.searchText]
    doNext:^(id result) {
      RWTSearchResultsViewModel *resultsViewModel =
        [[RWTSearchResultsViewModel alloc] initWithSearchResults:result
                                                        services:self.services];
      [self.services pushViewModel:resultsViewModel];
      [self addToSearchHistory:result];
    }];
}


- (void)addToSearchHistory:(RWTFlickrSearchResults *)result {
  
  RWTPreviousSearchViewModel* match = [[self.previousSearches linq_where:^BOOL(RWTPreviousSearchViewModel *x) {
    return x.searchString == result.searchString;
  }] linq_firstOrNil];
  
  if (match) {
    [self.mutablePreviousSearches removeObject:match];
    [self.mutablePreviousSearches insertObject:match atIndex:0];
  } else {
    RWTPreviousSearchViewModel *previousSearch = [RWTPreviousSearchViewModel new];
    previousSearch.searchString = result.searchString;
    previousSearch.totalResults = result.totalResults;
    previousSearch.thumbnail = [[result.photos firstObject] url];
    [self.mutablePreviousSearches insertObject:previousSearch atIndex:0];
  }
  
  if (self.mutablePreviousSearches.count > 10) {
    [self.mutablePreviousSearches removeLastObject];
  }
  
  self.previousSearches = [NSArray arrayWithArray:self.mutablePreviousSearches];
}

@end

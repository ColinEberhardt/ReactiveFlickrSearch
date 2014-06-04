//
//  RWTSearchResultsItemViewModel.m
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 04/06/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsItemViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "RWTFlickrPhototMetadata.h"

@interface RWTSearchResultsItemViewModel ()

@property (weak, nonatomic) id<RWTViewModelServices> services;
@property (strong, nonatomic) RWTFlickrPhoto *photo;

@end

@implementation RWTSearchResultsItemViewModel

- (instancetype)initWithPhoto:(RWTFlickrPhoto *)photo services:(id<RWTViewModelServices>)services {
  self = [super init];
  if (self) {
    _title = photo.title;
    _url = photo.url;
    _services = services;
    _photo = photo;
    
    [self initialize];
  }
  return  self;
}

- (void)initialize {
  
  RACSignal *visibleStateChanged = [RACObserve(self, isVisible) skip:1];

  RACSignal *visibleSignal = [visibleStateChanged filter:^BOOL(NSNumber *value) {
    return [value boolValue];
  }];

  RACSignal *hiddenSignal = [visibleStateChanged filter:^BOOL(NSNumber *value) {
    return ![value boolValue];
  }];

  RACSignal *fetchMetadata = [[visibleSignal delay:1.0f]
                             takeUntil:hiddenSignal];

    
  @weakify(self)
  [fetchMetadata subscribeNext:^(id x) {
    @strongify(self)
    [[[self.services getFlickrSearchService] flickrImageMetadata:self.photo.identifier]
     subscribeNext:^(RWTFlickrPhototMetadata *x) {
       self.favourites = @(x.favourites);
       self.comments = @(x.comments);
     }];
  }];
}

@end

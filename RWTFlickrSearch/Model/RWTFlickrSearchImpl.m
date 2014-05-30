//
//  RWTFlickrSearchImpl.m
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 29/05/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchImpl.h"

@implementation RWTFlickrSearchImpl

- (RACSignal *)flickrSearchSignal:(NSString *)searchString {
  return [[[[RACSignal empty]
            logAll]
            delay:2.0]
            logAll];
}

@end

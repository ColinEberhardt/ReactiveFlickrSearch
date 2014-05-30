//
//  RWTFlickrSearchResults.m
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 30/05/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchResults.h"

@implementation RWTFlickrSearchResults

- (NSString *)description {
  return [NSString stringWithFormat:@"searchString=%@, totalresults=%U, photos=%@",
          self.searchString, self.totalResults, self.photos];
}

@end

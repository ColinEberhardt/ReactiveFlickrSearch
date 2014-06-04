//
//  RWTFlickrPhototMetadata.m
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 04/06/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrPhototMetadata.h"

@implementation RWTFlickrPhototMetadata

- (NSString *)description {
  return [NSString stringWithFormat:@"metadata: comments=%lU, faves=%lU",
          self.comments, self.favourites];
}

@end

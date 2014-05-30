//
//  RWTFlickrSearchResults.h
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 30/05/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTFlickrSearchResults : NSObject

@property (strong, nonatomic) NSString *searchString;
@property (strong, nonatomic) NSArray *photos;
@property (nonatomic) NSUInteger totalResults;

@end

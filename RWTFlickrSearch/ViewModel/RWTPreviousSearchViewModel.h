//
//  RWTPreviousSearch.h
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 04/06/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTPreviousSearchViewModel : NSObject

@property (strong, nonatomic) NSString *searchString;
@property (nonatomic) NSUInteger totalResults;
@property (strong, nonatomic) NSURL *thumbnail;

@end

//
//  RWTFlickrSearch.h
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 29/05/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Foundation/Foundation.h>

@protocol RWTFlickrSearch <NSObject>

- (RACSignal *)flickrSearchSignal:(NSString *)searchString;

- (RACSignal *)flickrImageMetadata:(NSString *)photoId;

@end

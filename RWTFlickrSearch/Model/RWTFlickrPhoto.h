//
//  RWTFlickrPhoto.h
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 30/05/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTFlickrPhoto : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *identifier;

@end

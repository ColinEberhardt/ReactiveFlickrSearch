//
//  RWTViewModelServices.h
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 29/05/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTFlickrSearch.h"

@protocol RWTViewModelServices <NSObject>

- (void) pushViewModel:(id)viewModel;

- (id<RWTFlickrSearch>) getFlickrSearchService;

@end

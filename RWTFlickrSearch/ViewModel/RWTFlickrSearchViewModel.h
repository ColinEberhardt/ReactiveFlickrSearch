//
//  RWTFlickrSearchViewModel.h
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 27/05/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTViewModelServices.h"

@interface RWTFlickrSearchViewModel : NSObject

- (instancetype)initWithServices:(id<RWTViewModelServices>)services;

@property (strong, nonatomic) RACCommand *executeSearch;
@property (strong, nonatomic) NSString *searchText;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) RACSignal *connectionErrors;
@property (strong, nonatomic) NSArray *previousSearches;


@end

//
//  Created by Colin Eberhardt on 24/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTRecentSearchItemTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "RWTPreviousSearchViewModel.h"

@interface RWTRecentSearchItemTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *searchLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalResultsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;

@end

@implementation RWTRecentSearchItemTableViewCell

- (void)bindViewModel:(id)viewModel {
  RWTPreviousSearchViewModel *previousSearch = viewModel;
  self.searchLabel.text = previousSearch.searchString;
  
  NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
  [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
  NSString *numberAsString = [numberFormatter stringFromNumber:@(previousSearch.totalResults)];
  self.totalResultsLabel.text = numberAsString;
  [self.thumbnailImage setImageWithURL:previousSearch.thumbnail];
}

@end

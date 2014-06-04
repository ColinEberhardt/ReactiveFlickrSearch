//
//  Created by Colin Eberhardt on 23/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CETableViewBindingHelper.h"
#import "RWTSearchResultsTableViewCell.h"

@interface RWTSearchResultsViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *searchResultsTable;

@property (strong, nonatomic) RWTSearchResultsViewModel *viewModel;
@property (strong, nonatomic) CETableViewBindingHelper *bindingHelper;

@end

@implementation RWTSearchResultsViewController

- (instancetype)initWithViewModel:(RWTSearchResultsViewModel *)viewModel {
  if (self = [super init]) {
    _viewModel = viewModel;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self bindViewModel];
}

- (void)bindViewModel {
  self.title = self.viewModel.title;
  
  UINib *nib = [UINib nibWithNibName:@"RWTSearchResultsTableViewCell" bundle:nil];
  
  self.bindingHelper  =
  [CETableViewBindingHelper bindingHelperForTableView:self.searchResultsTable
                                         sourceSignal:RACObserve(self.viewModel, searchResults)
                                     selectionCommand:nil
                                         templateCell:nib];
  
  self.bindingHelper.delegate = self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  NSArray *cells = [self.searchResultsTable visibleCells];
  for (RWTSearchResultsTableViewCell *cell in cells) {
    CGFloat value = -40 + (cell.frame.origin.y - self.searchResultsTable.contentOffset.y) / 5;
    [cell setParallax:value];
  }
}


@end

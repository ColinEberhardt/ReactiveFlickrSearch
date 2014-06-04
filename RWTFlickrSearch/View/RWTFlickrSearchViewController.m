//
//  Created by Colin Eberhardt on 13/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CETableViewBindingHelper.h"

@interface RWTFlickrSearchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *searchHistoryTable;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@property (weak, nonatomic) RWTFlickrSearchViewModel *viewModel;
@property (strong, nonatomic) CETableViewBindingHelper *bindingHelper;

@end

@implementation RWTFlickrSearchViewController

- (instancetype)initWithViewModel:(RWTFlickrSearchViewModel *)viewModel {
  self = [super init];
  if (self ) {
    self.viewModel = viewModel;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.edgesForExtendedLayout = UIRectEdgeNone;
  
  self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
  
  [self bindViewModel];
}

- (void)bindViewModel {
  self.title = self.viewModel.title;
  RAC(self.viewModel, searchText) = self.searchTextField.rac_textSignal;
  
  self.searchButton.rac_command = self.viewModel.executeSearch;
  
  RAC(self.loadingIndicator, hidden) =
    [self.viewModel.executeSearch.executing not];

  RAC([UIApplication sharedApplication], networkActivityIndicatorVisible) =
    self.viewModel.executeSearch.executing;

  [self.viewModel.executeSearch.executionSignals
    subscribeNext:^(id x) {
      [self.searchTextField resignFirstResponder];
    }];
  
  [self.viewModel.connectionErrors subscribeNext:^(NSError *error) {
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"Connection Error"
                               message:@"There was a problem reaching Flickr."
                              delegate:nil
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil];
    [alert show];
  }];
  
  UINib *nib = [UINib nibWithNibName:@"RWTRecentSearchItemTableViewCell" bundle:nil];
  self.bindingHelper = [CETableViewBindingHelper bindingHelperForTableView:self.searchHistoryTable
                                                              sourceSignal:RACObserve(self.viewModel, previousSearches)
                                                          selectionCommand:nil
                                                              templateCell:nib];
  

}

@end

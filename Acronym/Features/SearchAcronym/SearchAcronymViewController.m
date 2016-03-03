//
//  ViewController.m
//  Acronym
//
//  Created by Sushma on 2/28/16.
//  Copyright © 2016 Sush. All rights reserved.
//

#import "SearchAcronymViewController.h"
#import "AcronymCell.h"
#import "AcronymManager.h"
#import "MBProgressHUD.h"
#import "UIColor+CustomColor.h"

@interface SearchAcronymViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchField;

@end

@implementation SearchAcronymViewController

NSArray *searchResults;
NSArray *filteredResults;
bool cancelClicked = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSearchController];
    self.searchField.delegate = self;
}

//using UISearchController as UISearchDisplayController is deprecated in iOS 8.0
- (void)initSearchController {
    self.searchResultsTableView.dataSource = self;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController: nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = false;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.placeholder = @"Filter Search Results";
    self.definesPresentationContext = true;
    self.searchResultsTableView.tableHeaderView = self.searchController.searchBar;
    
    //using category color as barTintColor
    [self.searchController.searchBar setBarTintColor: [UIColor customTeal]];
    [self.searchController.searchBar setTintColor:[UIColor whiteColor]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AcronymCell *cell = (AcronymCell *)[tableView dequeueReusableCellWithIdentifier:AcronymCell.identifier];
    if (cell) {
        cell.name.text = filteredResults[indexPath.row];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return filteredResults.count;
}

#pragma mark IBActions


- (IBAction)tapout:(id)sender {
    [self.searchField resignFirstResponder];
    [self.searchController.searchBar resignFirstResponder];
}

- (IBAction)searchAcronym:(id)sender {
    [self getSearchResults:self.searchField.text];
}

#pragma mark - UISearchResultsUpdating


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self filterSearchResults: searchBar.text];
}

// required delegate method for searching required data for searchBarSearchButtonClicked
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (cancelClicked) {
        return;
    }
    if (![searchController.searchBar.text isEqual: @""]) {
        [self filterSearchResults:searchController.searchBar.text];
    } else {
        filteredResults = searchResults;
        [self.searchResultsTableView reloadData];
    }
}

#pragma mark Search Operation and filters

//show filtered search results
- (void)filterSearchResults:(NSString *)searchText {
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchText];
    filteredResults = [searchResults filteredArrayUsingPredicate:resultPredicate];
    [self.searchResultsTableView reloadData];
}

- (void)getSearchResults: (NSString *)searchText {
    self.searchController.searchBar.text = @"";
    if (![searchText isEqual: @""]) {
        [self getAcronymFromSearchText:searchText];
    }
}

- (void)getAcronymFromSearchText: (NSString *)searchText {
    
    if ([searchText isEqual: @""]) {
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^ {
        
        AcronymManager *manager = [[AcronymManager alloc] init];
        [manager getAcronyms:searchText withCompletion:^(NSArray *data, NSError *error, NSString *errorMessage) {
            if (error != nil) {
                [self showAlertView:error];
            } else {
                searchResults = data;
                filteredResults = data;
                [self.searchResultsTableView reloadData];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        }];
    });
}

#pragma mark - UISearchResultsUpdating

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    cancelClicked = false;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    cancelClicked = true;
    filteredResults = searchResults;
    [self.searchResultsTableView reloadData];
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField becomeFirstResponder];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self getSearchResults:textField.text];
    [textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

#pragma mark Helper

- (void)showAlertView:(NSError *)error {
    //show error alert
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Error"
                                          message:error.localizedDescription
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alertController addAction:defaultAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


@end


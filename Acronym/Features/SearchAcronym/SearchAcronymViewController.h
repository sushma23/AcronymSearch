//
//  ViewController.h
//  Acronym
//
//  Created by Sushma on 2/28/16.
//  Copyright © 2016 Sush. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchAcronymViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *searchResultsTableView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) UISearchController *searchController;

@end


//
//  ViewController.h
//  Livre De Chant
//
//  Created by Steeven Sylveus on 11/19/13.
//  Copyright (c) 2013 Steeven Sylveus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchHymn;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property(strong, nonatomic) NSMutableArray *hymnTitleArray;
@property(strong, nonatomic) NSMutableArray *filteredHymnsArray;
@property(strong, nonatomic)NSString *titleString;
@property BOOL isFiltered;



@end

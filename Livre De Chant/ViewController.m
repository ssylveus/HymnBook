//
//  ViewController.m
//  Livre De Chant
//
//  Created by Steeven Sylveus on 11/19/13.
//  Copyright (c) 2013 Steeven Sylveus. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize hymnTitleArray, filteredHymnsArray, titleString, isFiltered, myTableView, searchHymn;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    hymnTitleArray = [[NSMutableArray alloc]init];
    filteredHymnsArray = [[NSMutableArray alloc]init];
    [self hymnesTitleArrayFunction];
    [self.view setAutoresizesSubviews:YES];
    [self.myTableView setAutoresizesSubviews:YES];
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
   NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    NSLog(@"%@", bundleIdentifier);
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [searchHymn resignFirstResponder];
    return YES;
}

-(void)hymnesTitleArrayFunction
{
    for (int i=1; i<=654; i++) {
        NSString* path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"H%i", i] ofType:@"txt"];
        titleString = [NSMutableString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [hymnTitleArray addObject:titleString];
        // NSLog(@"%@", titleString);
    }
    
}
//========UISearch Bar Function====================
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0)
    {
        isFiltered = NO;
    }else{
        isFiltered = YES;
        
        filteredHymnsArray = [[NSMutableArray alloc]init];
        
        for(NSString *hymnTitle in hymnTitleArray)
        {
            NSRange hymnNameRange = [hymnTitle rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(hymnNameRange.location != NSNotFound)
            {
                [filteredHymnsArray addObject:hymnTitle];
            }
        }
        
    }
    [myTableView reloadData];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchHymn resignFirstResponder];
    [self.view endEditing:YES];
}

//=======UISearch Bar Functions End================
//UiTableView Functions============================
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isFiltered == YES)
    {
        
        return filteredHymnsArray.count;
        
    }
    else{
        
        return hymnTitleArray.count;
        
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString *CellIdentifier = @"Cell";
    
    //CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    
    if(cell == nil)
        
    {
        cell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if(isFiltered == YES)
    {
        
        cell.textLabel.text = [filteredHymnsArray objectAtIndex:indexPath.row];
        
    }
    else{
        
        cell.textLabel.text = [hymnTitleArray objectAtIndex:indexPath.row];
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    DetailViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    if(isFiltered == YES)
    {
        detail.tempString = [filteredHymnsArray objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"loadHymn" object:nil];
        [searchHymn resignFirstResponder];
        [self.navigationController pushViewController:detail animated:YES];
        
        
    }
    else
    {
        detail.tempString = [hymnTitleArray objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"loadHymn" object:nil];
        [searchHymn resignFirstResponder];
        [self.navigationController pushViewController:detail animated:YES];
        
        //[self presentViewController:detail animated:YES completion:nil];
    }
    
    [searchHymn resignFirstResponder];
}


@end

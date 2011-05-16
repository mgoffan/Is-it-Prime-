//
//  FirstViewController.m
//  Is it Prime?
//
//  Created by Martin Goffan on 4/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "Is_it_Prime_AppDelegate.h"

@implementation FirstViewController

@synthesize myTextField, myTableView, resultsArray, dividersArray, numberOfSectionsInTableView, favsArray, actionSheet;

NSIndexPath* path;
NSInteger toCalcInteger = 0; 

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    resultsArray = [[NSMutableArray alloc] init];
    dividersArray = [[NSMutableArray alloc] init];
    favsArray = [[NSMutableArray alloc] init];
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add to favourites", nil];
    [favsArray addObject:@"Favourites are empty."];
    [resultsArray addObject:@"There are no results yet."];
    [dividersArray addObject:@"There are no dividers yet."];
    numberOfSectionsInTableView = 0;
}

- (IBAction)showBookmarks:(id)sender {
    [myTextField resignFirstResponder];
    [myTableView beginUpdates];
    if (numberOfSectionsInTableView == 2) {
        [myTableView insertSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationRight];
        numberOfSectionsInTableView = 3;
    }
    else if (numberOfSectionsInTableView == 3){
        [myTableView deleteSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationMiddle];
        numberOfSectionsInTableView = 2;
    }
    else if (numberOfSectionsInTableView == 0) {
        [myTableView insertSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)] withRowAnimation:UITableViewRowAnimationMiddle];
        numberOfSectionsInTableView = 3;
        [myTableView endUpdates];
        [myTableView reloadData];
        [myTableView beginUpdates];
        [myTableView deleteSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)] withRowAnimation:UITableViewRowAnimationMiddle];
        numberOfSectionsInTableView = 1; 
    }
    else if (numberOfSectionsInTableView == 1) {
        [myTableView deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationMiddle];
        numberOfSectionsInTableView = 0;
    }
    [myTableView endUpdates];
    [myTableView reloadData];
}

- (IBAction)calc:(id)sender {
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doCalc) object:nil];
    [queue addOperation:operation];
    [operation release];
}
- (void)doCalc {
    [myTextField performSelectorOnMainThread:@selector(resignFirstResponder) withObject:nil waitUntilDone:YES];
    [resultsArray removeAllObjects];
    [dividersArray removeAllObjects];
    if ([favsArray count] == 1) {
        if ([[favsArray objectAtIndex:0] isEqual:@"Favourites are empty."]) {
            [favsArray removeAllObjects];
        }
    }
	toCalcInteger = myTextField.text.longLongValue;
	NSInteger var, conteo = 0;
	int a = 0;
    if (numberOfSectionsInTableView == 3) {}
    else numberOfSectionsInTableView = 2;
	for (var = 2; var < toCalcInteger/2+1; var++) {
		if (toCalcInteger%var==0) {
			a = 1;
            [resultsArray addObject:[NSString stringWithFormat:@"%d is composite.", toCalcInteger]];
            for (var = 2; var < toCalcInteger/2+1; var++) {
                if (toCalcInteger%var==0) {
                    conteo++;
                    NSNumber *tmpNumber = [[NSNumber alloc] initWithInteger:var];
                    [dividersArray addObject:tmpNumber];
                    [tmpNumber release];
                }
            }
            [resultsArray insertObject:[NSString stringWithFormat:@"%d has %d dividers.",toCalcInteger, conteo] atIndex:1];
			goto loop;
		}
    }
    if (a != 1) {
        [resultsArray insertObject:[NSString stringWithFormat:@"%d is prime.", toCalcInteger] atIndex:0];
        [resultsArray insertObject:[NSString stringWithFormat:@"%d has no dividers.", toCalcInteger] atIndex:1];
        [dividersArray insertObject:@"No Dividers" atIndex:0];
    }
loop:;
    [myTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
	a=0;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    if (numberOfSectionsInTableView == 1) {
        cell.selectionStyle= UITableViewCellSeparatorStyleNone;
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[favsArray objectAtIndex:indexPath.row]];
    }
    else {
        if (indexPath.section == 0) {
            cell.selectionStyle = UITableViewCellEditingStyleNone;
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[resultsArray objectAtIndex:indexPath.row]];
        }
        else if (indexPath.section == 1){
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[dividersArray objectAtIndex:indexPath.row]];
        }
        else {
            cell.selectionStyle= UITableViewCellSeparatorStyleNone;
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[favsArray objectAtIndex:indexPath.row]];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        path = indexPath;
        actionSheet.title = [NSString stringWithFormat:@"Add the number %@ to favourites?",[dividersArray objectAtIndex:indexPath.row]];
        [actionSheet showInView:myTableView];
        [myTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if (![favsArray containsObject:[NSString stringWithFormat:@"%@ as a divider of %d",[dividersArray objectAtIndex:path.row],toCalcInteger]]) {
            [favsArray addObject:[NSString stringWithFormat:@"%@ as a divider of %d",[dividersArray objectAtIndex:path.row],toCalcInteger]];
        }
        [favsArray sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    else {
        [self.actionSheet dismissWithClickedButtonIndex:1 animated:YES];
    }
    [myTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return numberOfSectionsInTableView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (numberOfSectionsInTableView == 1) {
        return @"Favourites";
    }
    else {
        if (section == 0) {
            return @"Result";
        }
        else if (section == 1){
            return @"Dividers";
        }
        else {
            return @"Favourites";
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [resultsArray count];
    }
    else if (section == 1){
        return [dividersArray count];
    }
    else {
        return [favsArray count];
    }
}

- (void)dealloc {
    [super dealloc];
    
    [resultsArray release];
    [dividersArray release];
    [favsArray release];
    [actionSheet release];
}

@end

//
//  View.m
//  Is it Prime?
//
//  Created by Martin Goffan on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "From2toX.h"
#import "HUDViewController.h"


@implementation From2toX

@synthesize myTextField, myTableView, primesArray, result;

HUDViewController *hVController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        primesArray = [[NSMutableArray alloc] init];
        result = [[NSMutableArray alloc] initWithCapacity:1];
        [result addObject:@""];
        hVController = [[HUDViewController alloc] initWithNibName:@"HUD" bundle:[NSBundle mainBundle]];
        
        hVController.view.center = self.view.center;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Data management

- (IBAction)calc:(id)sender {
    [self.view addSubview:hVController.view];
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *opereration = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doCalc) object:nil];
    [queue addOperation:opereration];
    [opereration release];
}

- (void)doCalc {
    [myTextField performSelectorOnMainThread:@selector(resignFirstResponder) withObject:nil waitUntilDone:YES];
    [hVController.view removeFromSuperview];
    [primesArray removeAllObjects];
    NSInteger limit = myTextField.text.longLongValue;
    NSInteger counter = 0;
	NSInteger primenumber, d;
    BOOL isPrime;
    
    for (primenumber = 2; primenumber <= limit; ++primenumber) {
        isPrime = YES;
        for (d = 2; d < primenumber/4+2; ++d) {
            if (primenumber % d == 0) isPrime = NO;
        }
        if (isPrime) {
            counter++;
            [primesArray addObject:[NSNumber numberWithInteger:primenumber]];
        }
    }
    
    [result insertObject:[NSString stringWithFormat:@"%d primes were found.",counter] atIndex:0];
    [myTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
}

#pragma mark - TableView methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[result objectAtIndex:indexPath.row]];
    }
    else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[primesArray objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else {
        return [primesArray count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Result";
    }
    else {
        return @"Primes";
    }
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

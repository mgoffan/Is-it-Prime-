//
//  SecondViewController.m
//  Is it Prime?
//
//  Created by Martin Goffan on 4/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SecondViewListToController.h"


@implementation SecondViewListToController

@synthesize myTextField, myTableView, primesArray, result;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        primesArray = [[NSMutableArray alloc] init];
        result = [[NSMutableArray alloc] initWithCapacity:1];
        [result addObject:@""];
    }
    return self;
}

- (IBAction)calc:(id)sender {
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *opereration = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doCalc) object:nil];
    [queue addOperation:opereration];
    [opereration release];
}

- (void)doCalc {
    [myTextField performSelectorOnMainThread:@selector(resignFirstResponder) withObject:nil waitUntilDone:YES];
    [primesArray removeAllObjects];
    NSInteger limit = myTextField.text.longLongValue;
    NSInteger counter = 0;
	NSInteger primenumber, d;
    BOOL isPrime;
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    for (primenumber = 2; primenumber <= limit; ++primenumber) {
        isPrime = YES;
        for (d = 2; d < primenumber/2+1; ++d) {
            if (primenumber % d == 0) isPrime = NO;
        }
        if (isPrime) {
            counter++;
            [primesArray addObject:[NSNumber numberWithInteger:primenumber]];
            NSLog(@"%d",primenumber);
        }
    }
    [pool drain];
    
    [result insertObject:[NSString stringWithFormat:@"%d primes were found.",counter] atIndex:0];
    [myTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

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


- (void)dealloc {
    [super dealloc];
    
    [primesArray release];
    [myTableView release];
    [myTextField release];
    [result release];
}

@end

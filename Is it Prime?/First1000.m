//
//  First1000.m
//  Is it Prime?
//
//  Created by Martin Goffan on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "First1000.h"
#import "HUDViewController.h"


@implementation First1000

@synthesize myTableView, primesArray;

HUDViewController *hVController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        primesArray = [[NSMutableArray alloc] init];
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
    [primesArray removeAllObjects];
    NSInteger counter = 0;
	NSInteger primenumber, d;
    BOOL isPrime;
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    for (primenumber = 2; counter < 1000; ++primenumber) {
        isPrime = YES;
        for (d = 2; d < primenumber/2+1; ++d) {
            if (primenumber % d == 0) isPrime = NO;
        }
        if (isPrime) {
            counter++;
            [primesArray addObject:[NSNumber numberWithInteger:primenumber]];
        }
    }
    [pool drain];
    
    [myTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
}

#pragma mark - TableView methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [hVController.view removeFromSuperview];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[primesArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [primesArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Primes";
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

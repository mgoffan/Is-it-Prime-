//
//  SecondViewController.h
//  Is it Prime?
//
//  Created by Martin Goffan on 4/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SecondViewListToController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITextField *myTextField;
    IBOutlet UITableView *myTableView;
    
    NSMutableArray *primesArray;
    NSMutableArray* result;
}

@property (nonatomic, retain) IBOutlet UITextField* myTextField;
@property (nonatomic, retain) IBOutlet UITableView* myTableView;

@property (nonatomic, retain) NSMutableArray *primesArray;
@property (nonatomic, retain) NSMutableArray *result;

@end

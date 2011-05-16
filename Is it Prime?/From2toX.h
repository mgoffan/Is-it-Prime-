//
//  View.h
//  Is it Prime?
//
//  Created by Martin Goffan on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface From2toX : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITextField *myTextField;
    IBOutlet UITableView *myTableView;
    
    NSMutableArray *primesArray;
    NSMutableArray* result;
}

@property (nonatomic, retain) IBOutlet UITextField* myTextField;
@property (nonatomic, retain) IBOutlet UITableView* myTableView;

@property (nonatomic, retain) NSMutableArray *primesArray;
@property (nonatomic, retain) NSMutableArray *result;

- (IBAction)calc:(id)sender;

@end

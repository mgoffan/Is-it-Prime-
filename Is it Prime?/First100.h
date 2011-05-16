//
//  First100.h
//  Is it Prime?
//
//  Created by Martin Goffan on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface First100 : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *myTableView;
    
    NSMutableArray *primesArray;
}

@property (nonatomic, retain) IBOutlet UITableView* myTableView;

@property (nonatomic, retain) NSMutableArray *primesArray;

- (IBAction)calc:(id)sender;

@end

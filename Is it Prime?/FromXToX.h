//
//  FromXToX.h
//  Is it Prime?
//
//  Created by Martin Goffan on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FromXToX : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITextField *myTextFieldFrom;
    IBOutlet UITextField *myTextFieldTo;
    IBOutlet UITableView *myTableView;
    
    NSMutableArray *primesArray;
    NSMutableArray* result;
}

@property (nonatomic, retain) IBOutlet UITextField* myTextFieldFrom;
@property (nonatomic, retain) IBOutlet UITextField* myTextFieldTo;
@property (nonatomic, retain) IBOutlet UITableView* myTableView;

@property (nonatomic, retain) NSMutableArray *primesArray;
@property (nonatomic, retain) NSMutableArray *result;

- (IBAction)calc:(id)sender;

@end

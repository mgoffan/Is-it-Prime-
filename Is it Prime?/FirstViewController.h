//
//  FirstViewController.h
//  Is it Prime?
//
//  Created by Martin Goffan on 4/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>{
    IBOutlet UITextField *myTextField;
    IBOutlet UITableView *myTableView;
    
    NSMutableArray *resultsArray;
    NSMutableArray *dividersArray;
    NSMutableArray *favsArray;
    
    UIActionSheet *actionSheet;
    
    NSInteger numberOfSectionsInTableView;
}

@property (nonatomic, retain) IBOutlet UITextField* myTextField;
@property (nonatomic, retain) IBOutlet UITableView* myTableView;

@property (nonatomic, retain) NSMutableArray *resultsArray;
@property (nonatomic, retain) NSMutableArray *dividersArray;
@property (nonatomic, retain) NSMutableArray *favsArray;

@property (nonatomic, retain) UIActionSheet *actionSheet;

@property (assign, readwrite) NSInteger numberOfSectionsInTableView;

- (IBAction)calc:(id)sender;
- (IBAction)showBookmarks:(id)sender;

@end

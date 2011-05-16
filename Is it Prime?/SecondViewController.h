//
//  RootViewController.h
//  sampple
//
//  Created by Martin Goffan on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate> {
    IBOutlet UINavigationController *navigationController;
    NSArray *optionsArray;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSArray *optionsArray;

@end

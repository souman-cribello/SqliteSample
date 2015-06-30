//
//  ViewController.h
//  SqliteSample
//
//  Created by Administrator on 6/26/15.
//  Copyright (c) 2015 Apcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
#import "AppDelegate.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblPeople;
- (IBAction)addNewRecord:(id)sender;
//testing

@end


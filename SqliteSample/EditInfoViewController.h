//
//  EditInfoViewController.h
//  SqliteSample
//
//  Created by Administrator on 6/26/15.
//  Copyright (c) 2015 Apcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
#import "AppDelegate.h"
#import "ViewController.h"
@class ViewController;
@interface EditInfoViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtFirstname;

@property (weak, nonatomic) IBOutlet UITextField *txtLastname;

@property (weak, nonatomic) IBOutlet UITextField *txtAge;
@property (strong, nonatomic) ViewController *ViewController;
- (IBAction)saveInfo:(id)sender;

- (IBAction)Skip:(id)sender;

@end

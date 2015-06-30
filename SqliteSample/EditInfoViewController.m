//
//  EditInfoViewController.m
//  SqliteSample
//
//  Created by Administrator on 6/26/15.
//  Copyright (c) 2015 Apcoda. All rights reserved.
//

#import "EditInfoViewController.h"

#define COLOR_WITH_RGB(r,g,b)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
@interface EditInfoViewController ()
@property (nonatomic, strong) DBManager *dbManager;
@end

@implementation EditInfoViewController
{
    UIButton *Submit;
    UIButton *Skip;
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Set the navigation bar tint color.
    self.navigationController.navigationBar.tintColor = self.navigationItem.rightBarButtonItem.tintColor;
    // Make self the delegate of the textfields.
    self.txtFirstname.delegate = self;
    self.txtLastname.delegate = self;
    self.txtAge.delegate = self;
    
    // Initialize the dbManager object.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"sampledb.sql"];
    
    
    //////button work///
    Submit=[[UIButton alloc]initWithFrame:CGRectMake(-1, self.view.frame.size.height-119, self.view.frame.size.width+1, 60)];
    [Submit setTitle:@"Submit" forState:UIControlStateNormal];
    Submit.titleLabel.textAlignment=NSTextAlignmentCenter;
    Submit.layer.borderColor = [[UIColor colorWithRed:0.329 green:0.839 blue:0.416 alpha:1]CGColor];
    Submit.layer.borderWidth = 1.0f;
    [Submit setTitleColor:[UIColor colorWithRed:0.329 green:0.839 blue:0.416 alpha:1] forState:UIControlStateNormal];
    Submit.tintColor=(__bridge UIColor *)([[UIColor colorWithRed:0.329 green:0.839 blue:0.416 alpha:1]CGColor]);
    [Submit addTarget:self
                 action:@selector(saveInfo:)
       forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:Submit];
    
    
    Skip=[[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width, 60)];
    Skip.backgroundColor=COLOR_WITH_RGB(86,216,104);
    [Skip setTitle:@"Skip" forState:UIControlStateNormal];
   
    [Skip addTarget:self
               action:@selector(Skip:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Skip];
    
    
   

}
#pragma textfieldDelegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
///////here database insertion done ///
- (IBAction)saveInfo:(id)sender
{
    CFUUIDRef udid = CFUUIDCreate(NULL);
    NSString *StrUUID= (NSString *) CFBridgingRelease(CFUUIDCreateString(NULL, udid));
    
    UIDevice *device = [UIDevice currentDevice];
    NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
    
    NSString *UUID=[NSString stringWithFormat:@"%@-%@",StrUUID,currentDeviceId];
    
    NSString *first_Name=self.txtFirstname.text;
    NSString *last_name=self.txtLastname.text;
    NSString *Age=self.txtAge.text;
    //////insert into core data base///
    id delegate7 = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context7 = [delegate7 managedObjectContext];
    NSManagedObject *dataRecord7 = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"PersonInfo" inManagedObjectContext:context7];
    
    
    [dataRecord7 setValue:first_Name forKey:@"first_name"];
    [dataRecord7 setValue:last_name forKey:@"last_name"];
    [dataRecord7 setValue:Age forKey:@"age"];
    [dataRecord7 setValue:UUID forKey:@"id"];
    NSError *error7;
    
    if (![context7 save:&error7])
    {
        NSLog(@"Error:%@", error7);
        
    }
    else
    {
        //////////////INSERTING DATA INTO SQLITE///////
        // Prepare the query string.
        NSString *query = [NSString stringWithFormat:@"insert into peopleInfo values(null, '%@', '%@', %d)", self.txtFirstname.text, self.txtLastname.text, [self.txtAge.text intValue]];
        ///executequery//
        [self.dbManager executeQuery:query];
        // If the query was successfully executed then pop the view controller.
        if (self.dbManager.affectedRows != 0)
        {
            NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
            
            // Pop the view controller.
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            NSLog(@"Could not execute the query.");
        }

    
    }
    
   
}
- (IBAction)Skip:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end

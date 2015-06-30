//
//  ViewController.m
//  SqliteSample
//
//  Created by Administrator on 6/26/15.
//  Copyright (c) 2015 Apcoda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *arrPeopleInfo;


-(void)loadData;
@end


@implementation ViewController
{

    /// Local db
    NSManagedObject *ManagedObject_vitalBmi;
    NSArray *NsArray_vitalBmi;
    NSManagedObjectContext *context_vitalBmi;
    NSMutableArray *Name;
    NSMutableArray *Age;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Make self the delegate and datasource of the table view.
    self.tblPeople.delegate = self;
    self.tblPeople.dataSource = self;
    
    
    
    // Initialize the dbManager property.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"sampledb.sql"];
    
    // Load the data.
    [self loadData];
    
    Name=[[NSMutableArray alloc]init];
    Age=[NSMutableArray array];

    
    id delegate1 = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context1 = [delegate1 managedObjectContext];
    NSEntityDescription *entity1 = [NSEntityDescription
                    entityForName:@"PersonInfo" inManagedObjectContext:context1];
        NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
    [request1 setEntity:entity1];
    NSError *error3;
    NsArray_vitalBmi=[context1 executeFetchRequest:request1 error:&error3];
    if([NsArray_vitalBmi count]!=0)
    {
        ManagedObject_vitalBmi=[NsArray_vitalBmi objectAtIndex:0];
        for(int i=0;i<NsArray_vitalBmi.count;i++)
        {
            ManagedObject_vitalBmi=[NsArray_vitalBmi objectAtIndex:i];
            [Name addObject:[NSString stringWithFormat:@"%@ %@",[ManagedObject_vitalBmi valueForKey:@"first_name"],[ManagedObject_vitalBmi valueForKey:@"last_name"]]];
            NSLog(@"namea %@",[ManagedObject_vitalBmi valueForKey:@"first_name"]);
        }
        
    }

//    [Name addObject:[NSString stringWithFormat:@"%@%@",[ManagedObject_vitalBmi valueForKey:@"first_name"],[ManagedObject_vitalBmi valueForKey:@"last_name"]]];
    NSLog(@"name_array %@",Name);
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Load the data.
    [self loadData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addNewRecord:(id)sender {
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}
//////////// fetch data from database////
-(void)loadData{
    // Form the query.
    NSLog(@"Hear");
    NSString *query = @"select * from peopleInfo";
    
    // Get the results.
    if (self.arrPeopleInfo != nil) {
        self.arrPeopleInfo = nil;
    }
    self.arrPeopleInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the table view.
    [self.tblPeople reloadData];
}
#pragma TableWork
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrPeopleInfo.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue the cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellRecord" forIndexPath:indexPath];
    NSInteger indexOfFirstname = [self.dbManager.arrColumnNames indexOfObject:@"firstname"];
    NSInteger indexOfLastname = [self.dbManager.arrColumnNames indexOfObject:@"lastname"];
    NSInteger indexOfAge = [self.dbManager.arrColumnNames indexOfObject:@"age"];
    
    NSLog(@"Age %@",[NSString stringWithFormat:@"Age: %@", [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfAge]]);
    // Set the loaded data to the appropriate cell labels.
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfFirstname], [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfLastname]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Age: %@", [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfAge]];
    
    return cell;
}
@end

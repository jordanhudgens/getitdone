//
//  JDHTodoListViewController.m
//  GetItDone
//
//  Created by Jordan Hudgens on 1/28/14.
//  Copyright (c) 2014 Jordan Hudgens. All rights reserved.
//

#import "JDHTodoListViewController.h"

@interface JDHTodoListViewController ()

@property (strong, nonatomic) NSMutableArray *todos;

@end

@implementation JDHTodoListViewController



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Get it done";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didTapAddButton)];
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *doumentsDirectory = [paths objectAtIndex:0];
        NSString *plistPath = [doumentsDirectory stringByAppendingPathComponent:@"todos.plist"];
        self.todos = [NSMutableArray arrayWithContentsOfFile:plistPath];
        
        if (!self.todos) {
            self.todos = [[NSMutableArray alloc] init];
        }
        
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didTapAddButton {
    JDHCreateTodoViewController *createVC = [[JDHCreateTodoViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createVC];
    createVC.delegate = self;
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView firstOtherButtonIndex]) {
        NSString *input = [[alertView textFieldAtIndex:0] text];
        [self.todos addObject:input];
        
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        [userDefaults setObject:self.todos forKey:@"todos"];
//        [userDefaults synchronize];
        
        
        
        [self.tableView reloadData];
        
        // for printing out the array
        // NSLog(@"%@", _todos);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.todos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
	
    NSDictionary *todo = self.todos[indexPath.row];
    cell.textLabel.text = todo[@"text"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;

    cell.detailTextLabel.text = [NSString stringWithFormat:@"Due %@",
                                 [dateFormatter stringFromDate:todo[@"dueDate"]]];
    
    NSLog(@"%@", [NSString stringWithFormat:@"Due %@",
                 [dateFormatter stringFromDate:todo[@"dueDate"]]]);
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.todos removeObjectAtIndex:indexPath.row];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *doumentsDirectory = [paths objectAtIndex:0];
        NSString *plistPath = [doumentsDirectory stringByAppendingPathComponent:@"todos.plist"];
        [self.todos writeToFile:plistPath atomically:YES];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
 
}

- (void)createTodo:(NSString *)todo withDueDate:(NSDate *)dueDate {
    NSDictionary *item = @{@"text": todo,
                           @"dueDate": dueDate};
    [self.todos addObject:item];
//    [[NSUserDefaults standardUserDefaults] setObject:self.todos forKey:@"todos"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doumentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [doumentsDirectory stringByAppendingPathComponent:@"todos.plist"];
    [self.todos writeToFile:plistPath atomically:YES];
    
    [self.tableView reloadData];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didCancelCreatingNewTodo {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end

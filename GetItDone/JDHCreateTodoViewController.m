//
//  JDHCreateTodoViewController.m
//  GetItDone
//
//  Created by Jordan Hudgens on 2/1/14.
//  Copyright (c) 2014 Jordan Hudgens. All rights reserved.
//

#import "JDHCreateTodoViewController.h"

@interface JDHCreateTodoViewController ()

@property (strong, nonatomic) UITextField *todoInput;
@property (strong, nonatomic) UITextField *dueDateInput;
@property (strong, nonatomic) NSDate *dueDate;

@end

@implementation JDHCreateTodoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"New To-Do";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(didTapDoneButton)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(didTapCancelButton)];
    
    [self renderTodoText];
    //[self renderDueDate];
}

- (void)renderTodoText {
    UILabel *todoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 0, 0)];
    todoLabel.text = @"To-do:";
    todoLabel.font = [UIFont boldSystemFontOfSize:UIFont.systemFontSize];
    [todoLabel sizeToFit];
    [self.view addSubview:todoLabel];
    
    self.todoInput = [[UITextField alloc] init];
    self.todoInput.borderStyle = UITextBorderStyleRoundedRect;
    self.todoInput.placeholder = @"Enter a to-do here.";
    self.todoInput.clearButtonMode = UITextFieldViewModeUnlessEditing;
    self.todoInput.delegate = self;
    self.todoInput.frame = CGRectMake(CGRectGetMinX(todoLabel.frame),
                                      CGRectGetMaxY(todoLabel.frame) + 5,
                                      CGRectGetWidth(self.view.frame) - (40),
                                      40);
    [self.view addSubview:self.todoInput];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end

//
//  JDHCreateTodoViewController.h
//  GetItDone
//
//  Created by Jordan Hudgens on 2/1/14.
//  Copyright (c) 2014 Jordan Hudgens. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JDHCreateTodoViewControllerDelegrate
@end

@interface JDHCreateTodoViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) id<JDHCreateTodoViewControllerDelegrate>delegate;
@end

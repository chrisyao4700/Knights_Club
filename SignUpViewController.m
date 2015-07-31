//
//  SignUpViewController.m
//  The Knights Club
//
//  Created by 姚远 on 7/28/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController (){
    UIAlertView * comfirmPasswordAlert;
    UIAlertView * badConnectionAlert;
    UIAlertView * signUpFinishAlert;
    UIAlertView * missInformation;
}

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllVars];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)hitDone:(id)sender {
    if ([self checkCompleteInformation] == YES) {
        if ([_passwordField.text isEqualToString:_repasswordField.text]) {
            _customer = [self configCustomer];
            [KCConnectCustomer saveCustomerToDatabaseWithCustomer:_customer andDelegate:self];
        }else{
            [comfirmPasswordAlert show];
        }
    }else{
        [missInformation show];
    }
}
- (IBAction)hitCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)usernameEdited:(id)sender {
     _emailField.text = [NSString stringWithFormat:@"%@@knights.gannon.edu",_usernameField.text];
}



-(KCCustomer *) configCustomer{
    KCCustomer * cut = [[KCCustomer alloc]initWithNetworkID:_usernameField.text andPassword:_passwordField.text andEmail:_emailField.text andGUNumber:_campusNumField.text];
    return cut;
}
-(BOOL) checkCompleteInformation{
    if (([self checkFieldNotNil:_usernameField] == YES) && ([self checkFieldNotNil:_emailField] == YES) && ([self checkFieldNotNil:_passwordField] == YES) && ([self checkFieldNotNil:_repasswordField] == YES) && ([self checkFieldNotNil:_campusNumField] == YES)) {
        return YES;
    }else {
        return NO;
    }
    
}
-(BOOL) checkFieldNotNil: (UITextField *) field{
    if (field.text.length == 0) {
        return NO;
    }else{
        return YES;
    }
    
}


-(void) initAllVars{
    if (_netWorkID) {
        _usernameField.text = _netWorkID;
        _emailField.text = [NSString stringWithFormat:@"%@@knights.gannon.edu",_netWorkID];
    }
    if (_netWorkPassword) {
        _passwordField.text = _netWorkPassword;
    }
    
    _passwordField.secureTextEntry = YES;
    _repasswordField.secureTextEntry = YES;
    _usernameField.placeholder = @"(e.g.  yao002)";
    _emailField.placeholder = @"(e.g. yao002@knights.gannon.edu)";
    
    _usernameField.delegate = self;
    _passwordField.delegate = self;
    _repasswordField.delegate = self;
    _emailField.delegate = self;
    _campusNumField.delegate = self;
    comfirmPasswordAlert = [[UIAlertView alloc] initWithTitle:@"Different Passwords"
                                                      message:@"Please enter the same password."
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    badConnectionAlert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection"
                                                    message:@"Please Check your Internet Connection."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    signUpFinishAlert = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                   message:@"Welcome to Join Knights Club!"
                                                  delegate:nil
                                         cancelButtonTitle:@"Let's Roll!"
                                         otherButtonTitles:nil];
    signUpFinishAlert.tag = 100;
    signUpFinishAlert.delegate = self;
    
    missInformation = [[UIAlertView alloc] initWithTitle:@"Incomplete Information"
                                                 message:@"Please Enter all the information."
                                                delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];

    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {// 1st Other Button
            [self performSegueWithIdentifier:@"signUpMenu" sender:self];  
        }
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [signUpFinishAlert show];
   // [self performSegueWithIdentifier:@"signUpRestaurantHunting" sender:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [error localizedDescription];
    [badConnectionAlert show];
}

/*Text Field*/
#define kOFFSET_FOR_KEYBOARD 200.0


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.repasswordField resignFirstResponder];
    [self.emailField resignFirstResponder];
    [self.campusNumField resignFirstResponder];
    
    return YES;
    
}


-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 44)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    
    //move the main view, so that the keyboard does not hide it.
    if  (self.view.frame.origin.y >= 44)
    {
        [self setViewMovedUp:YES];
    }
    
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    //CGRect textViewRect = self.requirementView.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        //rect.size.height += kOFFSET_FOR_KEYBOARD;
        //textViewRect.origin.y -= kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        //rect.size.height -= kOFFSET_FOR_KEYBOARD;
        //textViewRect.origin.y += kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    //_requirementView.frame = textViewRect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

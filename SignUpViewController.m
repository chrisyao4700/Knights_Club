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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  SignInViewController.m
//  The Knights Club
//
//  Created by 姚远 on 7/28/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController (){
    NSMutableData *  _downloadedData;
    UIAlertView * wrongPassword;
    UIAlertView * noCustomer;
}

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllVars];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)hitLogOn:(id)sender {
     [KCConnectCustomer readCustomerFromDatabaseWithUsername:_userNameField.text andPassword:_passwordField.text andDelegate:self];
   // [self performSegueWithIdentifier:@"loginMenu" sender:self];
    
}
- (IBAction)hitSignUp:(id)sender {
    
    [self performSegueWithIdentifier:@"toSignUp" sender:self];
}



- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [_downloadedData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    NSString * dataString = [NSString stringWithUTF8String:[_downloadedData bytes]];
    if ([dataString isEqualToString:@"No Result Found"]) {
        [noCustomer show];
    } else{
        NSDictionary * dataDictionary = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
        _loginCustomer = [[KCCustomer alloc]initWithContentDictionary:dataDictionary];
        
        if ([_passwordField.text isEqualToString:[_loginCustomer networkPassword]]) {
            [self performSegueWithIdentifier:@"signInRestaurantHunting" sender:self];
        }else{
            [wrongPassword show];
        }

    }
        // NSLog(@"Username: %@, Sex: %@, Nickname: %@", [_loginCustomer username], [_loginCustomer sex], [_loginCustomer nickname]);
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void) initAllVars{
    _passwordField.secureTextEntry = YES;
    
    _userNameField.placeholder = @"(e.g. yao002)";
    _passwordField.placeholder = @"Sign Up before Using GU ID";
    
    wrongPassword=  [[UIAlertView alloc] initWithTitle:@"Wrong Password"
                                               message:@"Please Check your Password."
                                              delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
    noCustomer = [[UIAlertView alloc] initWithTitle:@"No Username Found"
                                            message:@"Please Check your Username."
                                           delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toSignUp"]) {
        SignUpViewController * suvc = (SignUpViewController *)[segue destinationViewController];
        if (_userNameField.text.length != 0) {
            suvc.netWorkID = _userNameField.text;
        }
        if (_passwordField.text.length != 0) {
            suvc.netWorkPassword = _passwordField.text;
        }
        
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

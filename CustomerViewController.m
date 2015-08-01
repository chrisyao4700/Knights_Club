//
//  CustomerViewController.m
//  The Knights Club
//
//  Created by 姚远 on 7/31/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "CustomerViewController.h"

@interface CustomerViewController (){
    NSArray * tableContent;
    NSArray * headers;
    BOOL isEditing;
    CGRect screenRect;
    
   // NSMutableArray * updatedContent;
    NSString * updatedName;
    NSString * updatedPassword;
    NSString * updatedEmail;
    NSString * updatedGUNum;
}

@end

@implementation CustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllVars];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)hitMenuItem:(id)sender {
    [self performSegueWithIdentifier:@"meToMenu" sender:self];
}
- (IBAction)hitCartItem:(id)sender {
    [self performSegueWithIdentifier:@"meToCart" sender:self];
}
- (IBAction)hitEventItem:(id)sender {
    [self performSegueWithIdentifier:@"meToEvent" sender:self];
}
- (IBAction)hitMeItem:(id)sender {
}
- (IBAction)hitEdit:(id)sender {
    if (isEditing == NO) {
        isEditing =YES;
        [_editButton setTitle:@"Done" forState:UIControlStateNormal];
        [_customer_infoView reloadData];
    }else{
        isEditing = NO;
        [_editButton setTitle:@"Edit" forState:UIControlStateNormal];
        [_customer_infoView reloadData];
        [self infoEndEdit];
    }
}
- (IBAction)pushLogout:(id)sender {
    [KCCustomerHandler deleteCustomerFile];
    [KCImageHandler deleteImagesInFile];
    [KCItemListHandler deleteItemListInFile];
    sleep(1);
    [self performSegueWithIdentifier:@"meToLogin" sender:self];
    
}
-(void)closeFatherController{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void) initAllVars{
    

    [_dismisViewDelegate closeFatherController];
    
    isEditing = NO;
    headers = @[@"GU ID", @"Password", @"E-mail", @"Campus Card #"];
    _defaultCustomer = [KCCustomerHandler readCustomerFromFile];
    tableContent = [_defaultCustomer contentArray];
    
    updatedName = _defaultCustomer.networkID;
    updatedPassword = _defaultCustomer.networkPassword;
    updatedEmail = _defaultCustomer.email;
    updatedGUNum = _defaultCustomer.guNumber;
    
    screenRect = [[UIScreen mainScreen] bounds];
    [_menuItem setWidth:screenRect.size.width/5];
    [_meItem setWidth:screenRect.size.width/5];
    [_eventItem setWidth:screenRect.size.width/5];
    [_cartItem setWidth:screenRect.size.width/5];
    
    
    
    UIImageView * backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    backgroundImageView.image = [UIImage imageNamed:@"Background"];
    [self.view insertSubview:backgroundImageView atIndex:0];

    
    
    [_customer_infoView reloadData];
}

-(void) infoEndEdit{
    KCCustomer * updatedCustomer = [[KCCustomer alloc]initWithNetworkID:updatedName andPassword:updatedPassword andEmail:updatedEmail andGUNumber:updatedGUNum];
    _defaultCustomer = updatedCustomer;
    tableContent = _defaultCustomer.contentArray;
    [KCCustomerHandler saveCustomerToFileWithCustomer:updatedCustomer];
    [KCConnectCustomer editCustomerTodatabaseWithCustomer:updatedCustomer andDelegate:self];
}


/* Table View */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return tableContent.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
   
    return headers[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomerViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell" forIndexPath:indexPath];
    
    
    
    
    
    cell.contentField.text = tableContent[indexPath.section];
    cell.contentField.delegate = self;
    cell.contentField.tag = indexPath.section;
    
    if (isEditing == NO) {
        cell.light_imageView.image = [UIImage imageNamed:@"light_green"];
        cell.contentField.enabled = NO;
    }else{
        cell.light_imageView.image = [UIImage imageNamed:@"light_red"];
        cell.contentField.enabled = YES;
    }
    if (indexPath.section == 1) {
        cell.contentField.secureTextEntry = YES;
        
    }
    if (indexPath.section ==0) {
        cell.contentField.enabled =NO;
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
            updatedName = textField.text;
            break;
        case 1:
            updatedPassword = textField.text;
            case 2:
            updatedEmail= textField.text;
            case 3:
            updatedGUNum= textField.text;
        default:
            break;
    }
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"meToLogin"]) {
        SignInViewController * sivc = (SignInViewController *) [segue destinationViewController];
        sivc.dismisViewDelegate = self;
    }else if([segue.identifier isEqualToString:@"meToMenu"]){
        MenuViewController * mvc = (MenuViewController *) [segue destinationViewController];
        mvc.closeControllerDelegate = self;
    }else if ([segue.identifier isEqualToString:@"meToCart"]){
        CartViewController * cvc = (CartViewController *) [segue destinationViewController];
        cvc.dismisViewDelegate = self;
    }else if ([segue.identifier isEqualToString:@"meToEvent"]){
        EventViewController * evc = (EventViewController *) [segue destinationViewController];
        evc.dismissFatherViewDelegate = self;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

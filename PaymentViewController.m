//
//  PaymentViewController.m
//  The Knights Club
//
//  Created by 姚远 on 8/1/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "PaymentViewController.h"

@interface PaymentViewController (){
    CGRect screenRect;
    NSArray * paymentKeys;
    NSArray * paymentDescriptions;
    
    BOOL emailConnected;
    BOOL dataConnected;
    
    KCOrder * currentOrder;
    
    NSURLConnection * emailConnection;
    NSURLConnection * insertConnection;
    
    UIActivityIndicatorView * progressView;
    
    UIAlertView * successNote;
}

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllVars];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}


-(void) initAllVars{
    emailConnected = NO;
    dataConnected = NO;
    screenRect = [[UIScreen mainScreen] bounds];
    UIImageView * backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    backgroundImageView.image = [UIImage imageNamed:@"Background"];
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    _itemLabel.text = [NSString stringWithFormat:@"Item(%lu)", (unsigned long)_itemList.selectedItemArray.count];
    _orderPriceLabel.text = _orderTotal;
    _taxPriceLabel.text = _tax;
    _tipsLabel.text = _tips.stringValue;
    _totalPriceLabel.text = _total;
    
    paymentKeys = @[@"GU GOLD", @"Cash",@"PayPal",@"Cards"];
    paymentDescriptions = @[@"Pay with Campus Card #", @"Pay Cash when Picking up",@"Pay with Your PayPal Account", @"Pay with Your Credit Card"];
    
    [self pickPaymentTypeWithIndex:0];
    
     progressView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [progressView setCenter:CGPointMake(screenRect.size.width/2.0, screenRect.size.height/2.0)]; // I do this because I'm in landscape mode
    [self.view addSubview:progressView];
    
    successNote=  [[UIAlertView alloc] initWithTitle:@"Success!"
                                               message:@"You are All Set. Thank you!"
                                              delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
    successNote.tag = 26;
    successNote.delegate = self;

    
}


-(void) pickPaymentTypeWithIndex: (NSInteger) index{
     _paymentType = [paymentKeys objectAtIndex:index];
    if (index == 0) {
        _paymentTypeView.image = [UIImage imageNamed:@"gu_glod"];
    }else if(index == 1){
        _paymentTypeView.image = [UIImage imageNamed:@"cash"];
    }else if (index == 2){
        _paymentTypeView.image = [UIImage imageNamed:@"paypal"];
    }else if (index == 3){
        _paymentTypeView.image = [UIImage imageNamed:@"credit_card"];
    }
        
}

- (IBAction)hitDone:(id)sender {
    [self didPushPlaceOrder];
}
- (IBAction)hitBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)hitComfirm:(id)sender {
    [self didPushPlaceOrder];
}

-(void) didPushPlaceOrder{
    [progressView startAnimating];
    [self configOrder];
    [self sendURLConnection];
    //[self disableButtons];
    
}

-(void) disableButtons{
    _doneButton.enabled = NO;
    _comfirmButton.enabled = NO;
    
}

/* Table View */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return paymentKeys.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return paymentDescriptions[section];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell" forIndexPath:indexPath];
    cell.choiceLabel.text = [paymentKeys objectAtIndex:indexPath.section];
    if (indexPath.section == 0) {
        cell.choiceImage.image = [UIImage imageNamed:@"gu_glod"];
    }else if(indexPath.section == 1) {
        cell.choiceImage.image = [UIImage imageNamed:@"cash"];
    }else if(indexPath.section == 2) {
        cell.choiceImage.image = [UIImage imageNamed:@"paypal"];
    }else if(indexPath.section == 3) {
        cell.choiceImage.image = [UIImage imageNamed:@"credit_card"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pickPaymentTypeWithIndex:indexPath.section];
    
    
}


-(void) configOrder{
    KCCustomer * customer = [KCCustomerHandler readCustomerFromFile];
    currentOrder = [[KCOrder alloc] initWithItemList:_itemList.dataArray andOrderTips:_tips andFinalRequirement:_finalRequirement andPaymentType:_paymentType andPaymentInfo:@"0" andCustomer:customer];
}

-(void) sendURLConnection{
    emailConnection = [KCConnectOrder sendOrderToEmailService:currentOrder andDelegate:self];
    sleep(1);
    insertConnection = [KCConnectOrder insertOrderToDatabase:currentOrder andDelegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == emailConnection) {
        emailConnected = YES;
    
    }if (connection ==insertConnection) {
        dataConnected =YES;
    }
    if ((emailConnected ==YES) &&(dataConnected =YES)) {
        [self orderDidPlaced];
    }
}
-(void) orderDidPlaced{
    [progressView stopAnimating];
    [KCItemListHandler deleteItemListInFile];
    KCItemList *list = [[KCItemList alloc]init];
    [_refreshDelegate updateItemList:list];
    [successNote show];
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 26) {
        [KCConnectOrder saveOrderToFileWithOrder:currentOrder];
        [self dismissViewControllerAnimated:YES completion:nil];
    }

    
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

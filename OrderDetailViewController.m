//
//  OrderDetailViewController.m
//  The Knights Club
//
//  Created by 姚远 on 8/4/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController (){
    KCOrder * currentOrder;
    UIAlertView * noOrderAlert;
    NSMutableData * _downloadedData;
}

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllVars];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)hitBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) initAllVars{
    currentOrder = [KCConnectOrder readOrderFromFile];
    noOrderAlert = [[UIAlertView alloc]initWithTitle:@"No Order" message:@"You don't have any order on process" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    if (!currentOrder) {
        [noOrderAlert show];
    }else{
        [self updateLabel:self];
        NSTimer* timer = [NSTimer timerWithTimeInterval:30.0f target:self selector:@selector(updateLabel:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [self configElementsWithOrder];
        
    }
   
    
    
    
    
    
    
}

-(void) updateLabel:(id) sender{
   
    [KCConnectOrder readOrderFromDatabaseWithColumn:@"Title" andValue:currentOrder.kc_orderTitle andDelegate:self];
    
}

    
    


-(void) configElementsWithOrder{
    _titleLabel.text = currentOrder.kc_orderTitle;
    _stateLabel.text = currentOrder.kc_orderState;
    
    if ([_stateLabel.text isEqualToString:@"Unaccepted"]||[_stateLabel.text isEqualToString:@"Denied"]) {
        _state_image.image = [UIImage imageNamed:@"light_red"];
        
    }else if([_stateLabel.text isEqualToString:@"Accepted"] ||[_stateLabel.text isEqualToString:@"Cooked"]||[_stateLabel.text isEqualToString:@"Finished"]){
        _state_image.image = [UIImage imageNamed:@"light_green"];
    }
    _orderContentView.text =  [currentOrder.kc_orderString stringByReplacingOccurrencesOfString:@"/" withString:@"\n"];
    
    _orderContentView.editable = NO;
}

/* Database */

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
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    KCOrder * order = [[KCOrder alloc]initWithContentDictionary:[jsonArray objectAtIndex:0]];
    
    if (order) {
        currentOrder = order;
        [self configElementsWithOrder];
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

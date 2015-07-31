//
//  CartViewController.m
//  The Knights Club
//
//  Created by 姚远 on 7/30/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "CartViewController.h"

@interface CartViewController (){
    CGRect screenRect;
    
    KCItem * selectedItem;
    BOOL isUped;
    
    
    float fl_totalPrice;
    float fl_tax;
    float fl_tips;
    float fl_totalCharge;
    
    NSString * str_totalPrice;
    NSString * str_tax;
    NSString * str_tips;
    NSString * str_totalCharge;
}

@end

@implementation CartViewController

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
    screenRect = [[UIScreen mainScreen] bounds];
    
    _tipsField.delegate = self;
    isUped = NO;
    
    [_menuItem setWidth:screenRect.size.width/5];
    [_meItem setWidth:screenRect.size.width/5];
    [_eventItem setWidth:screenRect.size.width/5];
    [_cartItem setWidth:screenRect.size.width/5];
    
   
    
    UIImageView * backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    backgroundImageView.image = [UIImage imageNamed:@"Background"];
    [self.view insertSubview:backgroundImageView atIndex:0];
    fl_totalPrice = 0.0;
    
    
    for (NSDictionary * itemDic in _selectedItemList.selectedItemArray) {
        KCItem * item = [[KCItem alloc]initWithDictionary:itemDic];
        KCDish * dish = item.kc_selectedDish;
        int quantity = item.kc_quantity.intValue;
        fl_totalPrice += dish.dishPrice.floatValue * quantity;
    }
    fl_tax = fl_totalPrice * 0.06;
    fl_tips = 0;
    fl_totalCharge = fl_totalPrice + fl_tax;
    
    str_totalPrice = [NSString stringWithFormat:@"$%.2f", fl_totalPrice];
    str_tax = [NSString stringWithFormat:@"$%.2f", fl_tax];
    str_totalCharge = [NSString stringWithFormat:@"$%.2f", fl_totalCharge];
    
    _taxValueLabel.text = str_tax;
    _orderPriceLabel.text = str_totalPrice;
    _totalChargeLabel.text = str_totalCharge;
    _tipsField.placeholder = [NSString stringWithFormat:@"15%%:%.2f", (fl_totalPrice + fl_tax) *0.15];
    [_orderTable reloadData];
    
}


-(void)updateItemList: (KCItemList *) updatedList{
    _selectedItemList = updatedList;
    [self initAllVars];
}

- (IBAction)tipsChange:(id)sender {
    fl_tips = _tipsField.text.floatValue;
    fl_totalCharge = fl_totalPrice + fl_tax + fl_tips;
    str_totalPrice = [NSString stringWithFormat:@"$%.2f", fl_totalCharge];
    _totalChargeLabel.text = str_totalPrice;
}

- (IBAction)hitBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)hitCheckOut:(id)sender {
}

- (IBAction)hitMenu:(id)sender {
    [self performSegueWithIdentifier:@"cartToMenu" sender:self];
}
- (IBAction)hitCart:(id)sender {
}
- (IBAction)hitEvent:(id)sender {
}
- (IBAction)hitMe:(id)sender {
}

/* Table View */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return _selectedItemList.selectedItemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell" forIndexPath:indexPath];
    
    
    KCItem * item = [[KCItem alloc]initWithDictionary: _selectedItemList.selectedItemArray[indexPath.row]];
    
    cell.quantityLabel.text = [NSString stringWithFormat:@"X%@", item.kc_quantity.stringValue];
    cell.priceLabel.text = [NSString stringWithFormat:@"$%@",item.kc_selectedDish.dishPrice];
    cell.item_imageView.contentMode = UIViewContentModeScaleAspectFit;
    if ([item.kc_requirement isEqualToString:@""]) {
        cell.requirementView.text = @"No Special Requirement";
        cell.requirementView.editable = NO;
    }else{
        cell.requirementView.text = item.kc_requirement;
        cell.requirementView.editable = NO;
    }
    
    UIImage * dishImage = [UIImage imageWithData:item.kc_imageData];
    
    cell.item_imageView.image = dishImage;
    
    
    
    // cell.numberLabel.text = tableNumbers[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedItem = [[KCItem alloc]initWithDictionary:[[_selectedItemList.selectedItemArray objectAtIndex:indexPath.row] copy]];
    [_selectedItemList deleteItemWithIndext:indexPath.row];
    [self performSegueWithIdentifier:@"cartToDetail" sender:self];
    
    
}
/* End Table View */


/* TextView & TextField */

#define kOFFSET_FOR_KEYBOARD 200.0


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [self.tipsField resignFirstResponder];
    
    return YES;
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGRect viewRect  = self.view.frame;
    viewRect.origin.y = 0;
    self.view.frame = viewRect;
    return YES;
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (isUped == NO)
    {
        [self setViewMovedUp:YES];
        isUped = YES;
    }
    else if (isUped == YES)
    {
        //[self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (isUped == NO)
    {
        
        [self setViewMovedUp:NO];
        isUped = NO;
    }
    else if (isUped == YES)
    {
        [self setViewMovedUp:NO];
        isUped = NO;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    
       
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
/* End Text View */
-(void) closeFatherController{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"cartToDetail"]) {
        MenuDetailViewController * mdvc = (MenuDetailViewController *)[segue destinationViewController];
        mdvc.selectedItemList = _selectedItemList;
        mdvc.currentDish = [selectedItem kc_selectedDish];
        mdvc.imageData = selectedItem.kc_imageData;
        mdvc.updateItemListDelegate = self;
        mdvc.si_quantity = selectedItem.kc_quantity;
        mdvc.si_requirement = selectedItem.kc_requirement;
        
    
    }else if ([segue.identifier isEqualToString:@"cartToMenu"]){
        MenuViewController * mvc = (MenuViewController *) [segue destinationViewController];
        mvc.selectedItemList = _selectedItemList;
        mvc.closeControllerDelegate = self;
        
    }
   
}

@end

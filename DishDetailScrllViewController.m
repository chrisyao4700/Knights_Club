//
//  DishDetailScrllViewController.m
//  The Knights Club
//
//  Created by 姚远 on 7/30/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "DishDetailScrllViewController.h"

@interface DishDetailScrllViewController (){
    CGRect screenRect;
}

@end

@implementation DishDetailScrllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllVars];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) initAllVars{
    screenRect = [[UIScreen mainScreen] bounds];
    NSInteger image_w = screenRect.size.width/2.0 - 10*2;
   // NSInteger fullScreen_w = screenRect.size.width;
    NSInteger halfScreen_w = screenRect.size.width/2.0;
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(halfScreen_w + 10, halfScreen_w/3.0, halfScreen_w-20, 30)];
    _catagoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(halfScreen_w + 10, halfScreen_w/3.0*2 + 10, halfScreen_w-20, 30)];
   // NSInteger image_h = screenRect.size.height;
    _dish_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, image_w, image_w)];
    [self.view addSubview:_dish_imageView];
    [self.view addSubview:_priceLabel];
    [self.view addSubview:_catagoryLabel];
    if (_imageData) {
        _dish_imageView.image = [UIImage imageWithData:_imageData];
    }else{
        _dish_imageView.image = [UIImage imageNamed:@"lulu"];
    }

    if (_selectedDish) {
        _nameLabel.text = _selectedDish.dishName;
        _priceLabel.text = [NSString stringWithFormat:@"$%@", _selectedDish.dishPrice];
        _catagoryLabel.text = _selectedDish.dishCategory;
        if ((!_selectedDish.dishDescription)||([_selectedDish.description isEqualToString:@""])) {
            [_descriptionView removeFromSuperview];
        }else{
        _descriptionView.text = _selectedDish.dishDescription;
            [_descriptionView setEditable:NO];
        }
        
        
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

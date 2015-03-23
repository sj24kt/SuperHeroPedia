//
//  RootViewController.m
//  SuperHeroPedia
//
//  Created by Sherrie Jones on 3/23/15.
//  Copyright (c) 2015 Sherrie Jones. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSArray *superHeros;
@property (strong, nonatomic) IBOutlet UITableView *superHeroTableView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.superHeros = [NSArray arrayWithObjects:
//                       [NSDictionary dictionaryWithObjectsAndKeys:
//                       @"Superman", @"name",
//                       [NSNumber numberWithInt:32], @"age", nil],
//
//                       [NSDictionary dictionaryWithObjectsAndKeys:
//                        @"Green Lantern", @"name",
//                        [NSNumber numberWithInt:28], @"age", nil],
//
//                       [NSDictionary dictionaryWithObjectsAndKeys:
//                        @"Batman", @"name",
//                        [NSNumber numberWithInt:30], @"age", nil],
//                       nil];

    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/superheroes.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               self.superHeros = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
                               //NSLog(@"data received");
                               [self.superHeroTableView reloadData];
    }];
    //NSLog(@"data requested");

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.superHeros.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuperHerosID"];
    NSDictionary *superHero = [self.superHeros objectAtIndex:indexPath.row];
    NSURL *imageURL = [NSURL URLWithString:[superHero objectForKey:@"avatar_url"]];

    cell.textLabel.text = [superHero objectForKey:@"name"];
    cell.detailTextLabel.text = [superHero objectForKey:@"description"];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    return cell;
}



@end





























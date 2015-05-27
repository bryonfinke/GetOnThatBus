//
//  ViewController.m
//  GetOnThatBus
//
//  Created by Bryon Finke on 5/27/15.
//  Copyright (c) 2015 Bryon Finke. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController () <MKMapViewDelegate>

@property NSArray *stops;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stops = [NSArray new];

    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.stops = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError] objectForKey:@"row"];
        for (NSDictionary *location in self.stops) {
            MKPointAnnotation *point = [MKPointAnnotation new];
            point.coordinate = CLLocationCoordinate2DMake([[location objectForKey:@"latitude"] floatValue], [[location objectForKey:@"longitude"] floatValue]);
            point.title = [location objectForKey:@"cta_stop_name"];
            [self.mapView addAnnotation:point];
        }
    }];
}

@end

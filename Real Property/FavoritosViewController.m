//
//  FavoritosViewController.m
//  Real Property
//
//  Created by Anibal Rodriguez on 07/03/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import "FavoritosViewController.h"
#import "DetailViewController.h"
#import "AsyncImageView.h"

@interface FavoritosViewController ()

@property (strong, nonatomic) NSArray  * json;
@property (strong, nonatomic) NSArray  * titulos;
@property (strong, nonatomic) NSArray  * direc;
@property (strong, nonatomic) NSArray  * objetosD;
@property (strong, nonatomic) NSArray  * objetosT;
@property (strong, nonatomic) NSArray  * idinmuebleF;
@property (strong, nonatomic) NSArray  * objetosI;
@property (strong, nonatomic) NSString * valorUsuario;
@property (strong, nonatomic) NSArray  * imagenes;
@property (strong, nonatomic) NSArray  * objetosImg;

@end

@implementation FavoritosViewController

@synthesize temp, dataDes;
-(void)awakeFromNib
{
    
    NSUserDefaults * defaults2 = [NSUserDefaults standardUserDefaults];
    NSString * load = [defaults2 objectForKey:@"guardarid"];
    _valorUsuario = load;
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBarHidden = NO;
    NSMutableString *urlFav = [[NSMutableString alloc] initWithString:@"https://www.realproperty.cl/mobilData.php?functName=getFavoritos&registroID="];
    [urlFav appendString:_valorUsuario];
    NSURL *urlStringBusqueda = [NSURL URLWithString:urlFav];
    NSData *dataUrl = [NSData dataWithContentsOfURL:urlStringBusqueda];
    NSError *error;
    _json = [NSJSONSerialization JSONObjectWithData:dataUrl options:kNilOptions error:&error];
    
    _titulos      = [_json valueForKey:@"titulo"];
    _direc        = [_json valueForKey:@"direccion"];
    _idinmuebleF  = [_json valueForKey:@"inmuebleID"];
    _imagenes     = [_json valueForKey:@"imagen"];

    _objetosT = [NSArray array];
    
    for (int i = 0; i < [_titulos count]; i++) {
        _objetosT = [_objetosT arrayByAddingObjectsFromArray:[_titulos objectAtIndex:i]];
    }
 
    _objetosD = [NSArray array];
    
    for (int i = 0; i < [_direc count]; i++) {
        _objetosD = [_objetosD arrayByAddingObjectsFromArray:[_direc objectAtIndex:i]];
    }

    _objetosI = [NSArray array];
    
    for (int i = 0; i < [_idinmuebleF count]; i++) {
        _objetosI = [_objetosI arrayByAddingObjectsFromArray:[_idinmuebleF objectAtIndex:i]];
    }
    
    _objetosImg = [NSArray array];
    
    for (int i = 0; i < [_imagenes count]; i++) {
        _objetosImg = [_objetosImg arrayByAddingObjectsFromArray:[_imagenes objectAtIndex:i]];
    }
    
    _temp2     = [[NSMutableArray alloc] init];
    
    
    for (int i = 0; i < [_objetosImg count]; i++) {
        
        NSMutableString *urlImage = [[NSMutableString alloc] initWithString:@"http://www.realproperty.cl"];
        [urlImage appendString:[_objetosImg objectAtIndex:i]];
        [_temp2 addObject:urlImage];
        NSLog(@"no es 0");
    }
    
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_titulos count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }    else
    {
        //cancel loading previous image for cell
        [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.imageView];
    }
    cell.textLabel.text = [_objetosT objectAtIndex:indexPath.row];
    cell.detailTextLabel.text =  [_objetosD objectAtIndex:indexPath.row];
    
    // data de iamgenes -- NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_temp2 objectAtIndex:indexPath.row]]];
    NSURL *imageURLs = [[NSURL alloc] initWithString:[_temp2 objectAtIndex:indexPath.row]];
    NSLog(@"%@", imageURLs);
    cell.imageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    cell.imageView.imageURL = imageURLs;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%d",indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"fichaMaster"];
    vc.IDInmueble = [_objetosI objectAtIndex:indexPath.row];
    NSLog(@"%@", [_objetosI objectAtIndex:indexPath.row]);
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  DetailViewController.m
//  Real Property
//
//  Created by Anibal Rodriguez on 20/01/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import "DetailViewController.h"
#import "AsyncImageView.h"
#import "GaleriaViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"


@interface DetailViewController ()

@property (strong, nonatomic) NSArray * servicios;
@property (strong, nonatomic) NSArray * cercanos;
@property (strong, nonatomic) NSMutableString *cercanosCompletos;
@property (strong, nonatomic) NSMutableArray *temporalCercanos;

@property (strong, nonatomic) NSMutableArray *temporalServicio;

@property (strong, nonatomic) NSMutableData * acumulaData;

@end

@implementation DetailViewController

@synthesize IDInmueble, etiquetaTitulo, detailTitulo, etiquetaPrecio, detailPrecio, etiquetaBanos, etiquetaHab, scrollDetail, detailBanos, detailhab, detailDescrip, texViewDescripcion, detailSuperficie, detailSuperficieT, labelSuperficie, labelSuperficieT, labelUnidadSuper, labelunidadSuperT, detailSuperUnidad, detailSuperUnidadT, labelEstac, detailEstaci, labelRegion, detailRegion, labelComuna, detailComuna, labelDirec, detailDirec, labelAmobaldo, detailAmobaldo, detailDispo, labelDisponibilidad, labelEjecutivo, detailEjecutivo, detailEmailC, labelEmailC, detailTel, lableTel, latitud, longitud, json;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _wrap = NO;


        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSLog(@"willappear");

}
-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"willdisapear");
}


- (void)viewDidLoad
{
    NSLog(@"viewdidload");
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner setCenter:CGPointMake(320/2.0, 568/2.0)];
    //spinner.color = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
    spinner.hidden = NO;
    [spinner startAnimating];
    [self.view addSubview:spinner];
    if ([ [ UIScreen mainScreen ] bounds ].size.height == 568){
        NSLog(@"iPhone 5 pantalla");
        self.automaticallyAdjustsScrollViewInsets = NO;
    }else{
        etiquetaPrecio.frame = CGRectMake(52, 25, 200, 20);
        self.formatoPrecio.frame = CGRectMake(20, 25, 29, 21);
        self.favoritos.frame    = CGRectMake(262, 25, 33, 33);
    }

    _acumulaData = [[NSMutableData alloc] init];
    
    detailBanos = [[NSArray alloc] init];
    _carousel.type = iCarouselTypeLinear;
    
    self.navigationController.navigationBarHidden = NO;
    _roundDetailDHE.layer.cornerRadius = 5;
    _roundDetailDHE.layer.masksToBounds = YES;
    
    //cambiar imagen del boton de favoritos
    
    [self.favoritos setBackgroundImage:[UIImage imageNamed:@"nofavoritos.png"] forState:UIControlStateNormal];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(llamarContacto)];
    [lableTel addGestureRecognizer:tap];
    
    [scrollDetail setScrollEnabled:YES];
    [scrollDetail setContentSize:CGSizeMake(320,2530)];
    
    [super viewDidLoad];
    NSMutableString *inmueble = [[NSMutableString alloc] initWithString:@"https://www.realproperty.cl/mobilData.php?functName=getInmuebles&inmuebleID="];
    NSString * idInmuebleR  = IDInmueble;
    [inmueble appendString:idInmuebleR];
    NSURL *urlStringBusqueda = [NSURL URLWithString:inmueble];
    //NSData *dataUrl = [NSData dataWithContentsOfURL:urlStringBusqueda];
    //NSURLRequest *urlrq = [NSURLRequest requestWithURL:urlStringBusqueda];
    //NSURLResponse * response = nil;
    //SError *errorp = nil;
    //NSData *dataUrl = [NSURLConnection sendSynchronousRequest:urlrq returningResponse:&response error:&errorp];
    
   
    
    NSURLRequest *reqB = [[NSURLRequest alloc] initWithURL:urlStringBusqueda];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:reqB delegate:self];
    NSLog(@"%@",conn);
    //
   

}



- (IBAction)goMapAction:(id)sender {
    //mapa
    UIAlertView * mapAlert = [[UIAlertView alloc] initWithTitle:@"¡Atención!" message:@"Va a salir de la aplicacion hacia aplicación Maps, Puede volver a la aplicación sin perder datos." delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Aceptar", nil];
    mapAlert.tag = 1;
    [mapAlert show];
    


}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger) buttonIndex
{
    if (buttonIndex == 0)
    {
        NSLog(@"Cancel Tapped.");
    }
    else if (buttonIndex == 1 && alertView.tag == 1)
    {
        MKUserLocation *userLocation = _mapa.userLocation;
        NSString *latitudString = [latitud objectAtIndex:0];
        NSString *longitdString = [longitud objectAtIndex:0];
        double puntoLa = [latitudString doubleValue];;
        double puntoLo = [longitdString doubleValue];
        MKCoordinateRegion region =
        MKCoordinateRegionMakeWithDistance (
                                            userLocation.location.coordinate, 2500, 2500);
        region.center.latitude = puntoLa;
        region.center.longitude = puntoLo;
        _mapa.showsUserLocation = true;
        [_mapa setRegion:region animated:NO];
        // Posicionar la propiedad
        CLLocationCoordinate2D coordiante;
        coordiante.latitude = puntoLa;
        coordiante.longitude =puntoLo;
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:coordiante];
        [annotation setTitle:[detailTitulo objectAtIndex:0]];
        [self.mapa addAnnotation:annotation];
        
        MKCoordinateSpan span = MKCoordinateSpanMake(25000, 25000);
        NSDictionary *mapLaunchOptions = @{
                                           MKLaunchOptionsMapTypeKey: @(MKMapTypeStandard),
                                           MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                           MKLaunchOptionsMapSpanKey:[NSValue valueWithMKCoordinateSpan:span]
                                           };
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordiante addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem openInMapsWithLaunchOptions:mapLaunchOptions];
    }
    else if(buttonIndex == 1 && alertView.tag == 2 ){
        ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"signup"];
        vc.idInmuebleDesdeDettale = IDInmueble;
         [self.navigationController pushViewController:vc animated:YES];
    }

}

-(void)viewDidAppear:(BOOL)animated
{
    

    [super viewDidAppear:animated];
    
    NSString *cantidad = [NSString stringWithFormat:@"%i",temporalFotos.count];
    _cantidadFotos.text = cantidad;
    

    [self.carousel setCurrentItemIndex:0];
    [self.carousel reloadData];
    

    NSUserDefaults * defaults2 = [NSUserDefaults standardUserDefaults];
    NSString * load = [defaults2 objectForKey:@"guardarid"];
    self.idUsuario = load;
    
    //Data obtener e imprimir nota
    if (load > 0) {
        NSMutableString *urlC = [[NSMutableString alloc] initWithString:@"https://www.realproperty.cl/mobilData.php?functName=getNote"];
        [urlC appendString:@"&inmuebleID="];
        [urlC appendString:IDInmueble];
        [urlC appendString:@"&registroID="];
        [urlC appendString:self.idUsuario];
        NSURL       *urlNota = [NSURL URLWithString:urlC];
        NSData      *dataTipo = [NSData dataWithContentsOfURL:urlNota];
        NSError     *error;
        NSString    *jsonNota = [NSJSONSerialization JSONObjectWithData:dataTipo options:kNilOptions error:&error];
        NSArray *notas = [jsonNota valueForKey:@"note"];
        if ( notas.count > 0) {
            self.notaTextView.text = [notas objectAtIndex:0];
        }else{
            self.notaTextView.text = @"";
        }
    }else{
    
        NSLog(@"no esta logeado");
        
    }

    //Data obtener e imprimir favoritos (fata crear la URL)
    
    if (load > 0) {
        NSMutableString *urlC = [[NSMutableString alloc] initWithString:@"https://www.realproperty.cl/mobilData.php?functName=getFavoritos"];
        [urlC appendString:@"&inmuebleID="];
        [urlC appendString:IDInmueble];
        [urlC appendString:@"&registroID="];
        [urlC appendString:self.idUsuario];
        NSURL       *urlFav = [NSURL URLWithString:urlC];
        NSData      *dataTipoFav = [NSData dataWithContentsOfURL:urlFav];
        NSError     *errorF;
        NSString    *jsonFav = [NSJSONSerialization JSONObjectWithData:dataTipoFav options:kNilOptions error:&errorF];
        NSArray *favG = [jsonFav valueForKey:@"inmuebleID"];
      
        if ( favG.count > 0) {
            [self.favoritos setBackgroundImage:[UIImage imageNamed:@"favoritos.png"] forState:UIControlStateNormal];
        }else{
            NSLog(@"no esta en fav");
        }
    }else{
        
        NSLog(@"considere logearse");
        
    }
    
}

- (IBAction)favoritos:(id)sender {
    @try {
        
        if( self.idUsuario == 0) {
            
            //[self alertStatus:@"Para agregar a favoritos debe estar logeado." :@"Alerta:" :0];
            
            UIAlertView * logearseAlert = [[UIAlertView alloc] initWithTitle:@"¡Atención!" message:@"Para agregar a favoritos debe estar logeado." delegate:self cancelButtonTitle:@"Mas Tarde" otherButtonTitles:@"Logearse", nil];
            logearseAlert.tag = 2;
            [logearseAlert show];
            
        } else {

            NSString *postF =[[NSString alloc] initWithFormat:@"id inmueble %@ id usuario%@",IDInmueble,self.idUsuario];
            NSMutableString *urlCF = [[NSMutableString alloc] initWithString:@"https://www.realproperty.cl/mobilData.php?functName=setFavoritos"];
            [urlCF appendString:@"&inmuebleID="];
            [urlCF appendString:self.IDInmueble];
            [urlCF appendString:@"&registroID="];
            [urlCF appendString:self.idUsuario];
            
            NSURL *urlF=[NSURL URLWithString:urlCF];
            
            NSData *postDataF = [postF dataUsingEncoding:NSUTF8StringEncoding];
            
            NSString *postLengthF = [NSString stringWithFormat:@"%lu", (unsigned long)[postDataF length]];
            
            
            
            NSMutableURLRequest *requestF = [[NSMutableURLRequest alloc] init];
            [requestF setURL:urlF];
            [requestF setHTTPMethod:@"POST"];
            [requestF setValue:postLengthF forHTTPHeaderField:@"Content-Length"];
            [requestF setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [requestF setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [requestF setHTTPBody:postDataF];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *errorF = [[NSError alloc] init];
            NSHTTPURLResponse *responsef = nil;
            NSData *urlDataF=[NSURLConnection sendSynchronousRequest:requestF returningResponse:&responsef error:&errorF];
            
            NSLog(@"Response code: %ld", (long)[responsef statusCode]);
            
            if ([responsef statusCode] >= 200 && [responsef statusCode] < 300)
            {
                NSString *responseDataF = [[NSString alloc]initWithData:urlDataF encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseDataF);
                
                NSError *error = nil;
                NSDictionary *jsonDataF = [NSJSONSerialization
                                          JSONObjectWithData:urlDataF
                                          options:NSJSONReadingMutableContainers
                                          error:&error];
                
                successF = [jsonDataF[@"sucessful"] integerValue];
                mensajeF = (NSString *) jsonDataF[@"message"];
                NSLog(@"Success: %ld",(long)successF);
                
                if(successF > 0)
                {
                    NSLog(@"Inmueble agregado a favoritos!");
                } else {
                    
                    NSString *error_msgF = @"Esta propiedad fue elminada de sus favoritos.";//(NSString *) jsonDataF[@"message"];
                    [self alertStatus:error_msgF :@"¡Alerta!" :0];
                    NSString *postF =[[NSString alloc] initWithFormat:@"id inmueble %@ id usuario%@",IDInmueble,self.idUsuario];
                    NSLog(@"PostData: %@",postF);
                    NSMutableString *urlCF = [[NSMutableString alloc] initWithString:@"https://www.realproperty.cl/mobilData.php?functName=deleteFavoritos&inmuebleID"];
                    [urlCF appendString:@"&inmuebleID="];
                    [urlCF appendString:self.IDInmueble];
                    [urlCF appendString:@"&registroID="];
                    [urlCF appendString:self.idUsuario];
                    NSLog(@"%@",urlCF);
                    NSURL *urlNF = [NSURL URLWithString:urlCF];
                    NSData *urlDeleteFavoritos = [NSData dataWithContentsOfURL:urlNF];
                    NSArray *jsonFavoritosDelete = [NSJSONSerialization JSONObjectWithData:urlDeleteFavoritos options:kNilOptions error:nil];
                    NSLog(@"%@",jsonFavoritosDelete);
                    [self.favoritos setBackgroundImage:[UIImage imageNamed:@"nofavoritos.png"] forState:UIControlStateNormal];
                }
                
            } else {
                [self alertStatus:@"Connection Failed" :@"favorito fallido!" :0];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"favorito Failed." :@"Error!" :0];
    }
    if (successF) {
        UIAlertView *alertaFavorito = [[UIAlertView alloc] initWithTitle:@"Favoritos" message:@"Inmueble agregado" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [self.favoritos setBackgroundImage:[UIImage imageNamed:@"favoritos.png"] forState:UIControlStateNormal];
        [alertaFavorito show];
        
    }

}

// NOTAS

- (IBAction)enviarNota:(id)sender {

    
    @try {
        spinner.hidden = NO;
        [spinner startAnimating];
        if([[self.notaTextView text] isEqualToString:@""] ) {
            spinner.hidden = YES;
            [spinner stopAnimating];
            [self alertStatus:@"Porfavor coloque su nota" :@"Envio de nota fallido" :0];
            
        }else if( self.idUsuario == 0) {
            
            //[self alertStatus:@"Para agregar a favoritos debe estar logeado." :@"Alerta:" :0];
            
            UIAlertView * logearseAlert = [[UIAlertView alloc] initWithTitle:@"¡Atención!" message:@"Para agregar a favoritos debe estar logeado." delegate:self cancelButtonTitle:@"Mas Tarde" otherButtonTitles:@"Logearse", nil];
            logearseAlert.tag = 2;
            [logearseAlert show];
            
        } else {

            NSString *post =[[NSString alloc] initWithFormat:@"%@%@&password=%@",IDInmueble,self.idUsuario,[self.notaTextView text]];
            NSMutableString *urlC = [[NSMutableString alloc] initWithString:@"https://www.realproperty.cl/mobilData.php?functName=setNote"];
            [urlC appendString:@"&registroID="];
            [urlC appendString:self.idUsuario];
            [urlC appendString:@"&inmuebleID="];
            [urlC appendString:self.IDInmueble];
            [urlC appendString:@"&note="];
            NSString *textoNotaFormateado = [self.notaTextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [urlC appendString:textoNotaFormateado];
            
            NSURL *url=[NSURL URLWithString:urlC];
            
            NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            NSLog(@"%@",self.notaTextView);
            NSLog(@"url %@",urlC);
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %ld", (long)[response statusCode]);
            
            if ([response statusCode] >= 200 && [response statusCode] < 300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                NSError *error = nil;
                NSDictionary *jsonData = [NSJSONSerialization
                                          JSONObjectWithData:urlData
                                          options:NSJSONReadingMutableContainers
                                          error:&error];
                
                success = [jsonData[@"noteID"] integerValue];
                mensaje = (NSString *) jsonData[@"message"];
                NSLog(@"Success: %ld",(long)success);
                
                if(success > 0)
                {
                    NSLog(@"nota agregada!");
                } else {
                    
                    NSString *error_msg = (NSString *) jsonData[@"message"];
                    [self alertStatus:error_msg :@"nota fallido!" :0];
                }
                
            } else {
                //if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"nota fallido!" :0];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"nota fallida." :@"Error!" :0];
        spinner.hidden = YES;
        [spinner stopAnimating];
    }
    if (success) {
        spinner.hidden = YES;
        [spinner stopAnimating];
        NSLog(@"%@",mensaje);
        UIAlertView *alertaNotaAgregada = [[UIAlertView alloc] initWithTitle:@"Notas" message:@"Nota agregada." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertaNotaAgregada show];
    }



}

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

// carousel

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
   
    return [temporalFotos count];

}


- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //limit the number of items views loaded concurrently (for performance reasons)
    return [temporalFotos count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(AsyncImageView *)view
{
    
    
    //create a numbered view
    NSString    * strinTemp     = [temporalFotos objectAtIndex:index];
    NSURL       * urlImageTemp  = [[NSURL alloc] initWithString:strinTemp];
    //NSData      * dataTemp      = [NSData dataWithContentsOfURL:urlImageTemp];
    
    
    //UIImage     * image         = [[UIImage alloc] initWithData:dataTemp];
    
    
    //view = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 280)];
 
    
    if (view == nil) {
        view = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 280)];
    }
    // dont forget stop previous loading -cancelLoadingURL:target:

    view.image =[UIImage imageNamed:@"placeholderficha.png"];
    view.imageURL=urlImageTemp;
    
    
	return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 0;
}




- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    //wrap all carousels
    return _wrap;
}


- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    
    NSLog(@"tap %d", index);
    GaleriaViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"galeriaficha"];
    [self.navigationController pushViewController:dvc animated:YES];
    dvc.imagenes = temporalFotos;

    
}


//end carousel




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)llamarContacto:(id)sender {

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",_telefonoFinalM]]];
    NSLog(@"%@",_telefonoFinalM);
}



- (IBAction)enviarEmail:(id)sender {
    NSString *emailTitle = @"Inmueble Real Property APP";
    
    NSMutableString * cuespoEmail = [[NSMutableString alloc] initWithString:@"Acerca de este inmueble publicado en Real Property:"];
    [cuespoEmail appendString:@"\n \n \n"];
    [cuespoEmail appendString:@"http://realproperty.cl/"];
    [cuespoEmail appendString:urlInmuebleEmail];
    [cuespoEmail appendString:@"\n"];
    
    NSString *messageBody = cuespoEmail;
    
    NSArray *toRecipents = [NSArray arrayWithObject:[detailEmailC objectAtIndex:0]];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    NSLog(@"email de contacto: %@", [detailEmailC objectAtIndex:0]);
    
    [self presentViewController:mc animated:YES completion:NULL];
}
- (IBAction)enviarEmailPerAction:(id)sender {
    NSString *emailTitle = @"Inmueble Real Property APP";
    
    NSMutableString * cuespoEmail = [[NSMutableString alloc] initWithString:@"Acerca de este inmueble publicado en Real Property:"];
    [cuespoEmail appendString:@"\n \n \n"];
    [cuespoEmail appendString:@"http://realproperty.cl/"];
    [cuespoEmail appendString:urlInmuebleEmail];
    [cuespoEmail appendString:@"\n"];
    
    NSString *messageBody = cuespoEmail;
    
    NSArray *toRecipents = [NSArray arrayWithObject:@""];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    NSLog(@"email de contacto: %@", [detailEmailC objectAtIndex:0]);
    
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelado");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail salvado");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail enviado");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//metodos de NSURLCONECTION

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"resive response %@", response);
    /*
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake(320/2.0, 568/2.0)];
    spinner.color = [UIColor greenColor];
    spinner.hidden = NO;
    [spinner startAnimating];
    [self.view addSubview:spinner];
     */
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_acumulaData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    json = [NSJSONSerialization JSONObjectWithData:_acumulaData options:kNilOptions error:nil];
    
    NSLog(@"carga de conexion finalizada");
    
    
    imagenesInm = [json valueForKey:@"imageList"];
    
    temporalFotos = [NSMutableArray array];
    if ([imagenesInm objectAtIndex:0] > 0) {
        for (int i = 1; i < [[imagenesInm objectAtIndex:0] count]; i++) {
            
            NSArray *imageObject = [imagenesInm objectAtIndex:0];
            NSString * posicion = [NSString stringWithFormat:@"%d",i];
            NSArray *imageObjectF = [imageObject valueForKey:posicion];
            
            NSString *imageC = [imageObjectF valueForKey:@"image"];
            
            
            NSMutableString *urlImage = [[NSMutableString alloc] initWithString:@"http://www.realproperty.cl"];
            [urlImage appendString:imageC];
            
            [temporalFotos addObject:urlImage];
            
        }
    }else{
        
        NSLog(@"no hay imagenes");
        
    }
    
    //
    
    //carga de texto
    detailTitulo        = [json valueForKey:@"titulo"];
    detailPrecio        = [json valueForKey:@"precio"];
    detailBanos         = [json valueForKey:@"banos"];
    detailhab           = [json valueForKey:@"habitaciones"];
    detailDescrip       = [json valueForKey:@"descripcion"];
    detailSuperficieT   = [json valueForKey:@"superficieUtil"];
    detailSuperficie    = [json valueForKey:@"superficie"];
    detailSuperUnidadT  = [json valueForKey:@"unidadSuperficieUtil"];
    detailSuperUnidad   = [json valueForKey:@"unidadSuperficie"];
    detailEstaci        = [json valueForKey:@"estacionamientos"];
    detailRegion        = [json valueForKey:@"region"];
    detailDirec         = [json valueForKey:@"direccion"];
    detailComuna        = [json valueForKey:@"comuna"];
    detailAmobaldo      = [json valueForKey:@"amoblado"];
    detailDispo         = [json valueForKey:@"disponibilidad"];
    detailEjecutivo     = [json valueForKey:@"personaContacto"];
    detailTel           = [json valueForKey:@"telefono"];
    _detailTel2         = [json valueForKey:@"telefono2"];
    _detailCel          = [json valueForKey:@"celular"];
    _detailCel2         = [json valueForKey:@"celular2"];
    
    _detailTelM           = [json valueForKey:@"telefono_mobil"];
    _detailTel2M         = [json valueForKey:@"telefono2_mobil"];
    _detailCelM          = [json valueForKey:@"celular_mobil"];
    _detailCel2M         = [json valueForKey:@"celular2_mobil"];
    
    
    detailEmailC        = [json valueForKey:@"email"];
    latitud             = [json valueForKey:@"latitud"];
    longitud            = [json valueForKey:@"longitud"];
    tipodeOpV           = [[json valueForKey:@"tipoOperacion"] objectAtIndex:0];
    codigo              = [[json valueForKey:@"codigo"] objectAtIndex:0];
    HS                  = [json valueForKey:@"habitaciones_servicio"];
    BS                  = [json valueForKey:@"banos_servicio"];
    formatoPrecioV      = [[json valueForKey:@"formatoPrecio"] objectAtIndex:0];
    urlInmuebleEmail    = [[json valueForKey:@"url"] objectAtIndex:0];
    _servicios          = [[json valueForKey:@"servicios"]objectAtIndex:0];
    _cercanos           = [[json valueForKey:@"cercanos"]objectAtIndex:0];
    
    if([_cercanos count] > 1) {
        NSArray *descripcion = [_cercanos valueForKey:@"descripcion"];
        
        _temporalCercanos = [[NSMutableArray alloc] init];
        
        for (int i = 0;i < _cercanos.count ; i++) {
            
            if(i > 0){
                //NSString *textoAgregar = [descripcion objectAtIndex:i];
                [_temporalCercanos addObject:[descripcion objectAtIndex:i]];
            }
        }
        NSMutableString * result = [[NSMutableString alloc] init];
        for (NSObject * obj in _temporalCercanos)
        {
            
            [result appendString:[obj description]];
            [result appendString:@"    "];
        }
        UILabel *cercanosTexto         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        cercanosTexto.text = result;
        cercanosTexto.font = [UIFont systemFontOfSize:18];
        CGFloat width = 9999;
        NSAttributedString *attributedText =
        [[NSAttributedString alloc]
         initWithString:cercanosTexto.text
         attributes:@
         {
         NSFontAttributeName: cercanosTexto.font
         }];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        CGSize size = rect.size;
        CGFloat width2 = ceilf(size.width);
        
        UIScrollView *myScrollView2  = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 100, 280, 40)];
        myScrollView2.contentSize    = CGSizeMake(width2 + 20, 40); //or some value you like, you may have to try this out a few times
        
        cercanosTexto.frame             = CGRectMake(cercanosTexto.frame.origin.x, cercanosTexto.frame.origin.y, width2, cercanosTexto.frame.size.height);
        
        [myScrollView2 addSubview: cercanosTexto];
        [self.cercanosYserviciosView addSubview:myScrollView2];
        
    }else{
        UILabel *avisoCercanos = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 280, 40)];
        avisoCercanos.text = @"No hay Cercanos para este inmueble.";
        avisoCercanos.font = [UIFont systemFontOfSize:14];
        [self.cercanosYserviciosView addSubview:avisoCercanos];
        NSLog(@"cercanos esta vacio");
    }
    
    //servicios
    
    if (!_servicios || !_servicios.count ) {
        NSLog(@"esta vacio servicios");
        UILabel *avisoCercanos = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 280, 40)];
        avisoCercanos.text = @"No hay Servicios para este inmueble.";
        avisoCercanos.font = [UIFont systemFontOfSize:14];
        [self.cercanosYserviciosView addSubview:avisoCercanos];
    }else{
        NSArray *descripcion = [_servicios valueForKey:@"descripcion"];
        
        _temporalServicio = [[NSMutableArray alloc] init];
        
        for (int i = 0;i < _servicios.count ; i++) {
            
            
            //NSString *textoAgregar = [descripcion objectAtIndex:i];
            [_temporalServicio addObject:[descripcion objectAtIndex:i]];
            
        }
        NSMutableString * result = [[NSMutableString alloc] init];
        for (NSObject * obj in _temporalServicio)
        {
            
            [result appendString:[obj description]];
            [result appendString:@"    "];
        }
        //textview servicios
        UILabel *serviciostexto         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        serviciostexto.text = result;
        serviciostexto.font = [UIFont systemFontOfSize:18];
        CGFloat widthServicios = 9999;
        NSAttributedString *attributedTextServicios =
        [[NSAttributedString alloc]
         initWithString:serviciostexto.text
         attributes:@
         {
         NSFontAttributeName: serviciostexto.font
         }];
        CGRect rectServicios = [attributedTextServicios boundingRectWithSize:(CGSize){widthServicios, CGFLOAT_MAX}
                                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                                     context:nil];
        CGSize sizeServicios = rectServicios.size;
        CGFloat width2Servicios = ceilf(sizeServicios.width);
        
        UIScrollView *myScrollView1  = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 40, 280, 40)];
        myScrollView1.contentSize    = CGSizeMake(width2Servicios + 20, 40); //or some value you like, you may have to try this out a few times
        
        serviciostexto.frame             = CGRectMake(serviciostexto.frame.origin.x, serviciostexto.frame.origin.y, width2Servicios, serviciostexto.frame.size.height);
        
        [myScrollView1 addSubview: serviciostexto];
        [self.cercanosYserviciosView addSubview:myScrollView1];
        
    }
    
    
    //fin de servicios y carcanos
    logoEmpresa         = [json valueForKey:@"logo_empresa"];
    
    if ([logoEmpresa objectAtIndex:0] != [NSNull null]) {
        NSMutableString *urlLogoEmpresa = [[NSMutableString alloc] initWithString:@"http://realproperty.cl"];
        [urlLogoEmpresa appendString:[logoEmpresa objectAtIndex:0]];
        NSURL *logoEmpreURL = [[NSURL alloc] initWithString:urlLogoEmpresa];
        
        _logoCorredora.image = [UIImage imageNamed:@"placeholder.jpg"];
        _logoCorredora.imageURL = logoEmpreURL;
        _logoCorredora.hidden = NO;
        
    }else{
        
        _logoCorredora.image = [UIImage imageNamed:@"placeholder.jpg"];
        _logoCorredora.hidden = YES;
    }
    
    
    
    NSDictionary *preciosList = [json valueForKey:@"preciosList"];
    
    precio1v = [[preciosList valueForKey:@"$"] objectAtIndex:0];
    precio2v = [[preciosList valueForKey:@"EUR"] objectAtIndex:0];
    precio3v = [[preciosList valueForKey:@"UF"] objectAtIndex:0];
    precio4v = [[preciosList valueForKey:@"USD"] objectAtIndex:0];
    
    NSString *tipoID    = [[json valueForKey:@"tipoID"] objectAtIndex:0];
    
    if ([tipodeOpV isEqualToString:@"1"]) {
        tipodeOpV = @"Venta";
    }
    if ([tipodeOpV isEqualToString:@"2"]) {
        tipodeOpV = @"Arriendo";
    }
    if ([[detailhab objectAtIndex:0] isEqualToString:@"0"])  {
        etiquetaHab.hidden = YES;
        _etiquetaDormitorio.hidden = YES;
    }
    if ([[detailBanos objectAtIndex:0] isEqualToString:@"0"]) {
        etiquetaBanos.hidden = YES;
        _etiquetabanos.hidden = YES;
    }
    if ([[detailEstaci objectAtIndex:0] isEqualToString:@"0"]) {
        labelEstac.hidden = YES;
        _etiquetaEstacionamiento.hidden = YES;
        _roundDetailDHE.frame = CGRectMake(20, 121, 64, 21);
    }
    
    //si estacionamiento y dormitorios es igual 0
    if ([[detailBanos objectAtIndex:0] isEqualToString:@"0"]){
        _roundDetailDHE.frame = CGRectMake(20, 121, 35, 21);
    }
    
    //si estacionamiento, dormitorios y dormitorios es igual 0
    if ([[detailEstaci objectAtIndex:0] isEqualToString:@"0"] && [[detailBanos objectAtIndex:0] isEqualToString:@"0"]){
        _roundDetailDHE.hidden = YES;
    }
    
    
    
    
    //cambiar segun tipo de inmueble
    
    if ([tipoID isEqualToString:@"1"]) {
        self.unidadtotal.text = @"Mts construcción:";
        self.unidadutil.text  = @"Mts de terreno";
    }else{
        self.unidadtotal.text = @"Superficie total:";
        self.unidadutil.text  = @"Superficie útil:";
    }
    
    //saber si hay o no servicios
    
    
    if ([[HS objectAtIndex:0] isEqualToString:@"1"] || [[BS objectAtIndex:0] isEqualToString:@"1"]) {
        _serviciosLabel.text = @"Si";
    }else{
        _serviciosLabel.text = @"No";
    }
    
    
    // comparaciones
    
    if ([[detailAmobaldo objectAtIndex:0] isEqualToString:@"0"]) {
        respuestaAmoblado = @"No";
    }else{
        respuestaAmoblado = @"Si";
    }
    
    if ([[detailDispo objectAtIndex:0] isEqualToString:@"00/00/0000"]) {
        respuestaDispon = @"Inmediata";
    }else{
        respuestaDispon = [detailDispo objectAtIndex:0];
    }
    
    
    //telefono
    
    _telefonoFinal = [_detailCel objectAtIndex:0];
    _telefonoFinalM = [_detailCelM objectAtIndex:0];
    
    if ([[_detailCel objectAtIndex:0] isEqualToString:@""]) {
        _telefonoFinal = [_detailCel2 objectAtIndex:0];
        _telefonoFinalM = [_detailCel2 objectAtIndex:0];
    }
    if ([[_detailCel2 objectAtIndex:0] isEqualToString:@""] && [[_detailCel objectAtIndex:0] isEqualToString:@""]) {
        _telefonoFinal = [detailTel objectAtIndex:0];
        _telefonoFinalM = [_detailTelM objectAtIndex:0];
    }
    
    if ([[detailTel objectAtIndex:0] isEqualToString:@""] && [[_detailCel2 objectAtIndex:0] isEqualToString:@""] && [[_detailCel objectAtIndex:0] isEqualToString:@""]) {
        _telefonoFinal = [_detailTel2 objectAtIndex:0];
        _telefonoFinalM = [_detailTel2M objectAtIndex:0];
    }
    
    if ([[detailTel objectAtIndex:0] isEqualToString:@""] && [[_detailTel2 objectAtIndex:0] isEqualToString:@""] && [[_detailCel2 objectAtIndex:0] isEqualToString:@""] && [[_detailCel objectAtIndex:0] isEqualToString:@""]) {
        lableTel.hidden = YES;
    }else{
        NSLog(@"existe celular 1, es %@",_detailCel);
        NSLog(@"existe celular 2, es %@",_detailCel2);
        NSLog(@"existe telefo 1, es %@",detailTel);
        NSLog(@"existe telefono 2, es %@",_detailTel2);
    }
    
    // si existe Celular 1, Celular 2, Telefenono 1 y telefono 2 (todos).
    
    if (![[_detailCel objectAtIndex:0] isEqualToString:@""] && ![[_detailCel2 objectAtIndex:0] isEqualToString:@""] && ![[detailTel objectAtIndex:0] isEqualToString:@""] && ![[_detailTel2 objectAtIndex:0] isEqualToString:@""] ) {
        UITextView *celular2 = [[UITextView alloc] initWithFrame:CGRectMake(20, 125, 280, 30)];
        celular2.font = [UIFont systemFontOfSize:14];
        celular2.text = [_detailCel2 objectAtIndex:0];
        celular2.editable = NO;
        celular2.dataDetectorTypes = UIDataDetectorTypeAll;
        celular2.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
        [_contactoView addSubview:celular2];
        
        UITextView *telefono = [[UITextView alloc] initWithFrame:CGRectMake(20, 155, 280, 30)];
        telefono.font = [UIFont systemFontOfSize:14];
        telefono.text = [detailTel objectAtIndex:0];
        telefono.editable = NO;
        telefono.dataDetectorTypes = UIDataDetectorTypeAll;
        telefono.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
        [_contactoView addSubview:telefono];
        
        UITextView *telefono2 = [[UITextView alloc] initWithFrame:CGRectMake(20, 185, 280, 30)];
        telefono2.font = [UIFont systemFontOfSize:14];
        telefono2.text = [_detailTel2 objectAtIndex:0];
        telefono2.editable = NO;
        telefono2.dataDetectorTypes = UIDataDetectorTypeAll;
        telefono2.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
        [_contactoView addSubview:telefono2];
        
        [scrollDetail setContentSize:CGSizeMake(320,2620)];
    }
    
    // si esxiste el celular 1 y celular 2
    
    if (![[_detailCel objectAtIndex:0] isEqualToString:@""] && ![[_detailCel2 objectAtIndex:0] isEqualToString:@""]) {
        UITextView *celular2 = [[UITextView alloc] initWithFrame:CGRectMake(20, 125, 280, 30)];
        celular2.font = [UIFont systemFontOfSize:14];
        celular2.text = [_detailCel2 objectAtIndex:0];
        celular2.editable = NO;
        celular2.dataDetectorTypes = UIDataDetectorTypeAll;
        celular2.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
        [_contactoView addSubview:celular2];
        [scrollDetail setContentSize:CGSizeMake(320,2560)];
    }
    
    // si existe Telf 1 y Telf 2
    if (![[detailTel objectAtIndex:0] isEqualToString:@""] && ![[_detailTel2 objectAtIndex:0] isEqualToString:@""]) {
        UITextView *celular2 = [[UITextView alloc] initWithFrame:CGRectMake(20, 125, 280, 30)];
        celular2.font = [UIFont systemFontOfSize:14];
        celular2.text = [_detailTel2 objectAtIndex:0];
        celular2.editable = NO;
        celular2.dataDetectorTypes = UIDataDetectorTypeAll;
        celular2.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
        [_contactoView addSubview:celular2];
        [scrollDetail setContentSize:CGSizeMake(320,2560)];
    }
    // si existe celular 1 y telf 1
    if (![[_detailCel objectAtIndex:0] isEqualToString:@""] && ![[detailTel objectAtIndex:0] isEqualToString:@""]) {
        UITextView *celular2 = [[UITextView alloc] initWithFrame:CGRectMake(20, 125, 280, 30)];
        celular2.font = [UIFont systemFontOfSize:14];
        celular2.text = [detailTel objectAtIndex:0];
        celular2.editable = NO;
        celular2.dataDetectorTypes = UIDataDetectorTypeAll;
        celular2.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
        [_contactoView addSubview:celular2];
        [scrollDetail setContentSize:CGSizeMake(320,2560)];
    }
    
    //si existe celular 1, telefono 2 y telefono 1
    
    if (![[_detailCel objectAtIndex:0] isEqualToString:@""] && ![[_detailTel2 objectAtIndex:0] isEqualToString:@""] && ![[detailTel objectAtIndex:0] isEqualToString:@""]) {
        UITextView *celular2 = [[UITextView alloc] initWithFrame:CGRectMake(20, 125, 280, 30)];
        celular2.font = [UIFont systemFontOfSize:14];
        celular2.text = [detailTel objectAtIndex:0];
        celular2.editable = NO;
        celular2.dataDetectorTypes = UIDataDetectorTypeAll;
        celular2.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
        [_contactoView addSubview:celular2];
        
        
        
        UITextView *telefono = [[UITextView alloc] initWithFrame:CGRectMake(20, 155, 280, 30)];
        telefono.font = [UIFont systemFontOfSize:14];
        telefono.text = [_detailTel2 objectAtIndex:0];
        telefono.editable = NO;
        telefono.dataDetectorTypes = UIDataDetectorTypeAll;
        telefono.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
        [_contactoView addSubview:telefono];
        
        [scrollDetail setContentSize:CGSizeMake(320,2590)];
    }
    
    
    // fin telefonos
    
    
    //textos en pantalla
    etiquetaTitulo.text         = [detailTitulo objectAtIndex:0];
    etiquetaPrecio.text         = [detailPrecio objectAtIndex:0];
    etiquetaHab.text            = [detailhab objectAtIndex:0];
    etiquetaBanos.text          = [detailBanos objectAtIndex:0];
    texViewDescripcion.text     = [detailDescrip objectAtIndex:0];
    labelSuperficieT.text       = [detailSuperficieT objectAtIndex:0];
    labelSuperficie.text        = [detailSuperficie objectAtIndex:0];
    labelunidadSuperT.text      = [detailSuperUnidadT objectAtIndex:0];
    labelUnidadSuper.text       = [detailSuperUnidad objectAtIndex:0];
    labelEstac.text             = [detailEstaci objectAtIndex:0];
    labelRegion.text            = [detailRegion objectAtIndex:0];
    labelDirec.text             = [detailDirec objectAtIndex:0];
    labelComuna.text            = [detailComuna objectAtIndex:0];
    labelAmobaldo.text          = respuestaAmoblado;
    labelDisponibilidad.text    = respuestaDispon;
    labelEjecutivo.text         = [detailEjecutivo objectAtIndex:0];
    labelEmailC.text            = [detailEmailC objectAtIndex:0];
    lableTel.text               = _telefonoFinal;  //[detailTel objectAtIndex:0];
    _precio1.text               = precio1v;
    _precio2.text               = precio2v;
    _precio3.text               = precio3v;
    _precio4.text               = precio4v;
    _tipoOperacionV.text        = tipodeOpV;
    _estacInfo.text             = [detailEstaci objectAtIndex:0];
    _formatoPrecio.text         = formatoPrecioV;
    
    
    
    NSMutableString *tituloBarra = [[NSMutableString alloc] initWithString:@"Detalle - "];
    [tituloBarra appendString:codigo];
    
    self.navItemBusq.title = tituloBarra;
    
    
    //mapa
    MKUserLocation *userLocation = _mapa.userLocation;
    NSString *latitudString = [latitud objectAtIndex:0];
    NSString *longitdString = [longitud objectAtIndex:0];
    double puntoLa = [latitudString doubleValue];;
    double puntoLo = [longitdString doubleValue];
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance (
                                        userLocation.location.coordinate, 90000, 90000);
    region.center.latitude = puntoLa;
    region.center.longitude = puntoLo;
    _mapa.showsUserLocation = true;
    [_mapa setRegion:region animated:NO];
    
    
    // Posicionar la propiedad
    CLLocationCoordinate2D coordiante;
    coordiante.latitude = puntoLa;
    coordiante.longitude =puntoLo;
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coordiante];
    [annotation setTitle:[detailTitulo objectAtIndex:0]];
    [self.mapa addAnnotation:annotation];
    
    
    [spinner stopAnimating];
    spinner.hidden = YES;
    NSString *cantidad = [NSString stringWithFormat:@"%i",temporalFotos.count];
    _cantidadFotos.text = cantidad;
    
    
    [self.carousel setCurrentItemIndex:0];
    [self.carousel reloadData];
    
}



@end

//
//  ViewController.swift
//  MapKitViewDemo
//
//  Created by Mac on 11/01/24.
//

import UIKit
import MapKit
class ViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    var bitcodePin : MKPlacemark?
    var pointAnnotation : MKPointAnnotation?
    var regionCoordinate : MKCoordinateRegion?
    var mkCircle : MKCircle?
    var radiusOfCircle : CLLocationDistance?
    var mkPolygone : MKPolygon?
    var  mkpolyline : MKPolyline?
// var unsafeMutablepointer : UnsafeMutablePointer<Any>?
    
    var bitcodeCoordinates : CLLocationCoordinate2D?
    var shaniwarWadaCoordinates : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 18.5195, longitude: 73.8553)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
       setPinUsingMKPlacement()
        setPointUsingMkAnnotation()
     //   drawCircleOnMKMapView(position: shaniwarWadaCoordinates! , radius: 5.0)
   //     drawCircleOnMKMapView(position: <#T##CLLocationCoordinate2D#>, radius: <#T##CLLocationDistance#>)
//        drawCircleOnMKMapView(position: shaniwarWadaCoordinates, radius: 500.0)
        drawPolygonOnMkMapView()
        settingcameraPositon(postition: shaniwarWadaCoordinates, zoomLevel: 21.0)
        drawPolylineMkMapView()
        
    }
    func setPinUsingMKPlacement(){
         bitcodeCoordinates = CLLocationCoordinate2D(latitude: 18.5091, longitude: 73.8326)
        bitcodePin = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 18.5091, longitude: 73.8326))
        bitcodePin = MKPlacemark(coordinate: bitcodeCoordinates!)
        let region = MKCoordinateRegion(center: bitcodeCoordinates!, latitudinalMeters: 800.0, longitudinalMeters: 800.0)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(bitcodePin!)
        
    }
    func setPointUsingMkAnnotation(){
        pointAnnotation = MKPointAnnotation()
        pointAnnotation?.coordinate = CLLocationCoordinate2D(latitude: 18.5195, longitude: 73.8553)
        pointAnnotation?.title = "Shaniwar Wada"
        let shaniwarWadaRedion = MKCoordinateRegion(center: pointAnnotation!.coordinate, latitudinalMeters: 800.0, longitudinalMeters: 800.0)
    
        
        
        mapView.setRegion(shaniwarWadaRedion, animated: true)
        mapView.addAnnotation(pointAnnotation!)
        
        
        
    }
    func drawCircleOnMKMapView(position : CLLocationCoordinate2D , radius : CLLocationDistance){
        mkCircle = MKCircle(center: shaniwarWadaCoordinates , radius: radius)
        
        mkCircle?.title = "Shaniwar Wada"
        mapView.addOverlay(mkCircle!)
        

//        let bitcodeRegion = MKCoordinateRegion(center: position,
//                                               latitudinalMeters: 800.5, longitudinalMeters: 800.5)
//
//        mapView.setRegion(bitcodeRegion, animated: true)
//
//        mapView.layer.cornerRadius = 5.0
//        mapView.addAnnotation(pointAnnotation!)
    
        
    }
    func settingcameraPositon(postition : CLLocationCoordinate2D , zoomLevel : Double ){
        let camera = MKMapCamera()
        camera.centerCoordinate = postition
        camera.altitude = pow(2, zoomLevel)
        mapView.setCamera(camera, animated: true)
        
//        var mkCameraSetting = MKMapCamera(
    }
    func drawPolygonOnMkMapView(){
        let polygonCoordinates = [CLLocationCoordinate2D(latitude: 19.9975, longitude: 73.7898),
        CLLocationCoordinate2D(latitude: 19.8762, longitude: 75.3433),
        CLLocationCoordinate2D(latitude: 17.6599, longitude: 75.9064),
        CLLocationCoordinate2D(latitude: 18.5202, longitude: 73.8567)]
        
        mkPolygone = MKPolygon(coordinates: polygonCoordinates, count: polygonCoordinates.count)
        mapView.addOverlay(mkPolygone!)
    }
    func drawPolylineMkMapView()
    {
        let polylineCoordinates =
        [CLLocationCoordinate2D(latitude: 20.3839, longitude: 78.1307),
          CLLocationCoordinate2D(latitude: 21.1458, longitude: 79.0882),
          CLLocationCoordinate2D(latitude: 19.9615, longitude: 79.2961),
          CLLocationCoordinate2D(latitude: 19.6766, longitude: 78.5321),
          CLLocationCoordinate2D(latitude: 20.3839, longitude: 78.1307)]
          
        mkpolyline = MKPolyline(coordinates: polylineCoordinates, count: polylineCoordinates.count)
        mapView.addOverlay(mkpolyline!)
                                    
                                    
    }
    


}
extension ViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
       if let cirlceoverlay = overlay as? MKCircle{
           let circlrRender = MKCircleRenderer(overlay: overlay)
           circlrRender.fillColor = UIColor.red.withAlphaComponent(0.25)
           circlrRender.strokeColor = UIColor.blue
           circlrRender.lineWidth = 1
           return circlrRender
           
       }else if let polyline = overlay as? MKPolyline{
           let polylineRender = MKPolylineRenderer(overlay: polyline)
           polylineRender.strokeColor = .red
           polylineRender.lineWidth = 2
           return polylineRender
            
        } else if let polygon = overlay as? MKPolygon{
            var polygoneRender = MKPolygonRenderer(overlay: polygon)
            polygoneRender.strokeColor = .blue
            polygoneRender.fillColor = .brown.withAlphaComponent(0.25)
            polygoneRender.lineWidth = 2
            return polygoneRender
                
            }
        return MKOverlayRenderer()
        }
    }
    


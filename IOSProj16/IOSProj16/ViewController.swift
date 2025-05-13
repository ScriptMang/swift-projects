//
//  ViewController.swift
//  IOSProj16
//
//  Created by Andy Peralta on 4/15/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import UIKit
import MapKit
import WebKit

class ViewController: UIViewController, MKMapViewDelegate {
  @IBOutlet var mapView: MKMapView!
  @IBOutlet var changeView: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    let london =
      Capital(title: "London",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.507222, longitude: 51.507222),
          info: "Home to the 2012 Summer Olympics.")

    let oslo =
      Capital(title: "Oslo",
              coordinate: CLLocationCoordinate2D(
                latitude: 59.95, longitude: 10.75),
              info: "Founded over a thousand years ago.")

    let paris =
      Capital(title: "Paris",
        coordinate: CLLocationCoordinate2D(
          latitude: 48.8567, longitude: 2.3508),
        info: "Often called the City of Light.")

    let rome =
      Capital(title: "Rome",
        coordinate: CLLocationCoordinate2D(
          latitude: 41.9, longitude: 12.5),
        info: "Has a whole country inside it.")

    let washington =
      Capital(title: "Washington",
        coordinate: CLLocationCoordinate2D(
          latitude: 38.895111, longitude: -77.036667),
        info: "Named after George himself.")

    mapView.addAnnotations([london,oslo,paris,rome,washington])
  }

  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
  // 1
  guard annotation is Capital else { return nil }

  // 2
  let identifier = "Capital"

  // 3
    var annotationView =   mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

  if annotationView == nil {
      //4
      annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      annotationView?.canShowCallout = true

      if let nwAnnotationView = annotationView as? MKPinAnnotationView {
        nwAnnotationView.pinTintColor = UIColor(red: 0, green: 3.4, blue: 0, alpha: 1)
      }

      // 5
      let btn = UIButton(type: .detailDisclosure)
      annotationView?.rightCalloutAccessoryView = btn
  } else {

      // 6
      annotationView?.annotation = annotation
      if let nwAnnotationView = annotationView as? MKPinAnnotationView {
      nwAnnotationView.pinTintColor = UIColor(red: 0, green: 3.4, blue: 0, alpha: 1)
      }
  }

  return annotationView
  }


  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//      guard let capital = view.annotation as? Capital else { return }
//      let placeName = capital.title
//      let placeInfo = capital.info
//
//      let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//      ac.addAction(UIAlertAction(title: "OK", style: .default))

    let webView = WKWebView()
          if let url = URL(string: "https://en.wikipedia.org/wiki/Washington_(state)") {
          let request  = URLRequest(url: url)
          webView.load(request)
          }
          self.view = webView

        navigationItem.leftBarButtonItem =
          UIBarButtonItem(barButtonSystemItem: .done, target: self,  action: #selector(closeWbViewPressed))
  }



  @IBAction func changeViewTapped(_ sender: Any) {
    let ac = UIAlertController(title: "Change View", message: "What view would you like?", preferredStyle: .actionSheet)
       ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: {
          [weak self]  action in
          self?.mapView.mapType = MKMapType.standard
          self?.changeView.setTitle("CurrentView: Standard", for: .normal)
          }))

        ac.addAction(UIAlertAction(title: "Satellite", style: .default) {
             [weak self]  action in
             self?.mapView.mapType = MKMapType.satellite
             self?.changeView.setTitle("CurrentView: Satellite", for: .normal)
             })

        ac.addAction(UIAlertAction(title: "HybridFlyover", style: .default) {
             [weak self]  action in
             self?.mapView.mapType = MKMapType.hybridFlyover
             self?.changeView.setTitle("CurrentView: HybridFlyover", for: .normal)
             })

        ac.addAction(UIAlertAction(title: "MutedStandard", style: .default) {
             [weak self]  action in
             self?.mapView.mapType = MKMapType.mutedStandard
             self?.changeView.setTitle("CurrentView: MutedStandard", for: .normal)
             })

        ac.addAction(UIAlertAction(title: "SatelliteFlyover", style: .default) {
             [weak self]  action in
             self?.mapView.mapType = MKMapType.satelliteFlyover
             self?.changeView.setTitle("CurrentView: SatelliteFlyover", for: .normal)
             })

        ac.addAction(UIAlertAction(title: "Hybrid", style: .default) {
                [weak self]  action in
                self?.mapView.mapType = MKMapType.hybrid
                self?.changeView.setTitle("CurrentView: hybrid", for: .normal)
                })

        present(ac, animated: true)
  }

  @objc func closeWbViewPressed(button: UIBarButtonItem) {
    navigationController?.view = mapView
  }


}


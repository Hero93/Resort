//
//  ActivitiesMapVC.swift
//  Resort
//
//  Created by Luca Gramaglia on 14/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit
import MapKit

struct MapPlace {
    var location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 44.5078635, longitude: 7.7143156)
    var activities: [Activity]?
}

class ActivitiesMapVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }
    
    // MARK: - IVars
    
    private let mapPlace = MapPlace()
    private var selectedViewModel: ActivityMapViewModel?
    private static let annotationId = "mapActivityAnnotationId"
    
    var controller: ActivitiesMapController?
    var coordinator: ActivityMapCoordinator?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.region = MKCoordinateRegion(center: mapPlace.location,
                                            span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
        controller?.start()
        initBinding()
    }
    
    // MARK: - Class methods
    
    private func initBinding() {
        controller?.viewModel.activityMapViewModels.addObserver(fireNow: false) { [weak self] (mapViewModel) in
            self?.addAnnotations()
        }
    }
    
    // MARK: MapKit Utils
    
    private func addAnnotations() {
        
        guard let viewModels = controller?.viewModel.activityMapViewModels.value else { return }
        
        viewModels.forEach { viewModel in
            self.mapView.addAnnotation(viewModel)
        }
    }
    
    private func openMedia() {
        guard let viewModel = selectedViewModel,
            let url = viewModel.url else { return }
        coordinator?.openMedia(with: url, title: viewModel.activityDescription)
        selectedViewModel = nil
    }
    
    // MARK: Selectors
    
    @objc
    private func userDidTapAnnotationCalloutView(_ sender: UITapGestureRecognizer) {
        openMedia()
    }
}

// MARK: - MKMapViewDelegate

extension ActivitiesMapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard let viewModel = annotation as? ActivityMapViewModel else {
            return nil
        }
        
        let annotationView: MKAnnotationView
        if let existingView = mapView.dequeueReusableAnnotationView(withIdentifier: ActivitiesMapVC.annotationId) {
            annotationView = existingView
        } else {
            annotationView = MKAnnotationView(annotation: viewModel, reuseIdentifier: ActivitiesMapVC.annotationId)
        }
                
        annotationView.image = viewModel.image
        annotationView.tag = viewModel.id
        annotationView.canShowCallout = true
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let calloutView = view.subviews.first else { return }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userDidTapAnnotationCalloutView(_:)))
        calloutView.addGestureRecognizer(tapGesture)
        selectedViewModel = view.annotation as? ActivityMapViewModel
    }
}

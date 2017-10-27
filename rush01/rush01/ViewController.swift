import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire

//directions api key: AIzaSyDVJExoskW90M_kCRHyrClUwHLo1f-m2aI

class MapViewController: UIViewController, UISearchBarDelegate {
	
	
	@IBOutlet weak var searchButton: UIBarButtonItem!
	@IBOutlet weak var navButton: UIBarButtonItem!
	@IBOutlet weak var searchStack: UIStackView!
	@IBOutlet weak var searchBox3: UISearchBar!
	@IBOutlet weak var searchBox1: UISearchBar!
	@IBOutlet weak var searchBox2: UISearchBar!
	var locationMarker: GMSMarker?
	var polyline: GMSPolyline?
	var startMarker: GMSMarker?
	var endMarker: GMSMarker?
	var locationManager = CLLocationManager()
	var currentLocation: CLLocation?
	var mapView: GMSMapView!
	var placesClient: GMSPlacesClient!
	var zoomLevel: Float = 15.0
	
	var likelyPlaces: [GMSPlace] = []
	
	var selectedPlace: GMSPlace?
	var lastSearched: String = ""
	
	let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)
	
	@IBAction func unwindToMain(segue: UIStoryboardSegue) {
		mapView.clear()
		if selectedPlace != nil {
			let marker = GMSMarker(position: (self.selectedPlace?.coordinate)!)
			marker.title = selectedPlace?.name
			marker.snippet = selectedPlace?.formattedAddress
			marker.map = mapView
		}
		
		listLikelyPlaces()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		searchBox3.isHidden = true
		searchStack.isHidden = true
		searchButton.title = "Search"
		navButton.title = "Navigate"
		locationManager = CLLocationManager()
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestAlwaysAuthorization()
		locationManager.distanceFilter = 50
		locationManager.startUpdatingLocation()
		locationManager.delegate = self
		
		placesClient = GMSPlacesClient.shared()
		
		let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
		                                      longitude: defaultLocation.coordinate.longitude,
		                                      zoom: zoomLevel)
		mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
		mapView.settings.myLocationButton = true
		mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		mapView.isMyLocationEnabled = true
		
		view.insertSubview(mapView, at: 0)
		mapView.isHidden = true
		
		listLikelyPlaces()
	}
	
	func listLikelyPlaces() {
		likelyPlaces.removeAll()
		
		placesClient.currentPlace(callback: { (placeLikelihoods, error) -> Void in
			if let error = error {
				print("Current Place error: \(error.localizedDescription)")
				return
			}
			
			if let likelihoodList = placeLikelihoods {
				for likelihood in likelihoodList.likelihoods {
					let place = likelihood.place
					self.likelyPlaces.append(place)
				}
			}
		})
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "segueToSelect" {
			if let nextViewController = segue.destination as? PlacesViewController {
				nextViewController.likelyPlaces = likelyPlaces
			}
		}
	}
	
	func getDirections() -> Void {
		let APIKey = "AIzaSyDOionlPQYIpnKMmp72BHhiHXtqpxurgug"
//		let startLocation = CLLocationCoordinate2DMake(-26.205044, 28.040091)
//		let endLocation = CLLocationCoordinate2DMake(-26.132903, 28.003933)
		mapView.clear()
		
		var origin: String?
		var destination = searchBox2.text!
		destination = destination.replacingOccurrences(of: " ", with: "+")
		
//		origin = "\(startLocation.latitude),\(startLocation.longitude)"
		if searchBox1.text! == "Current Location" {
			origin = "\((mapView.myLocation?.coordinate.latitude)!),\((mapView.myLocation?.coordinate.longitude)!)"
		} else {
			origin = searchBox1.text
			origin = origin!.replacingOccurrences(of: " ", with: "+")
		}
		
		print(origin!)
		print(destination)
		let directionsURL: String = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin!)&destination=\(destination)&mode=driving&key=\(APIKey)"
		
		Alamofire.request(directionsURL).responseJSON(completionHandler: {
			response in
			
			print(response.request as Any)  // original URL request
			print(response.response as Any) // HTTP URL response
			print(response.data!)     // server data
			print(response.result as Any)   // result of response serialization
			
			let json = JSON(data: response.data!)
			let routes = json["routes"].arrayValue

			for route in routes {
				self.polyline?.map = nil
				self.endMarker?.map = nil
				self.startMarker?.map = nil
				let routeOverviewPolyline = route["overview_polyline"].dictionary
				let bounds = route["bounds"].dictionary
				let neBound = bounds?["northeast"]?.dictionary
				let swBound = bounds?["southwest"]?.dictionary
				let routeBounds = GMSCoordinateBounds(coordinate: CLLocationCoordinate2DMake((swBound?["lat"]?.doubleValue)!, (swBound?["lng"]?.doubleValue)!), coordinate: CLLocationCoordinate2DMake((neBound?["lat"]?.doubleValue)! + 0.01, (neBound?["lng"]?.doubleValue)!))
				
				let legs = route["legs"].array
				let firstLeg = legs?.first
				let start = firstLeg?["start_location"].dictionary
				let startCoords = CLLocationCoordinate2DMake((start?["lat"]?.doubleValue)!, (start?["lng"]?.doubleValue)!)
				let end = firstLeg?["end_location"].dictionary
				let endCoords = CLLocationCoordinate2DMake((end?["lat"]?.doubleValue)!, (end?["lng"]?.doubleValue)!)
				self.endMarker = GMSMarker(position: endCoords)
				self.endMarker?.title = "End"
				self.startMarker = GMSMarker(position: startCoords)
				self.startMarker?.title = "Start"
				self.endMarker?.map = self.mapView
				self.startMarker?.map = self.mapView
				
				let points = routeOverviewPolyline?["points"]?.stringValue
				let path = GMSPath.init(fromEncodedPath: points!)
				
				self.polyline = GMSPolyline.init(path: path)
				self.polyline?.strokeWidth = 4
				self.polyline?.strokeColor = UIColor.red
				self.polyline?.map = self.mapView
				self.mapView.animate(with: GMSCameraUpdate.fit(routeBounds))
			}
		})
		
	}

	
	@IBAction func navButtonClicked(_ sender: Any) {
		if navButton.title == "Navigate" {
			searchBox1.text = "Current Location"
			searchBox2.text = lastSearched
			searchBox2.placeholder = "Enter Destination Address"
			searchButton.title = "Go"
			self.searchStack.isHidden = false
			self.navButton.title = "Cancel"
		} else {
			self.searchStack.isHidden = true
			self.navButton.title = "Navigate"
			searchButton.title = "Search"
			searchBox3.isHidden = true
		}
		
	}
	
	@IBAction func searchButtonClicked(_ sender: Any) {
		if searchButton.title == "Go" {
			if searchBox1.text! != "" && searchBox2.text! != "" {
				self.getDirections()
				searchStack.isHidden = true
			}
			searchButton.title = "Search"
			navButton.title = "Navigate"
		} else if searchButton.title == "Search" {
			searchBox3.isHidden = false
			searchBox1.text = lastSearched
			searchBox1.placeholder = "Find an Adress"
			searchButton.title = "Find"
			navButton.title = "Cancel"
		} else {
			self.findLocation()
			self.lastSearched = searchBox3.text!
			self.searchStack.isHidden = true
			self.navButton.title = "Navigate"
			searchButton.title = "Search"
			searchBox3.isHidden = true
		}
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		if searchBox1.text! != "" && searchBox2.text! != "" {
			self.getDirections()
		}
		if searchBox3.text! != "" {
			self.lastSearched = searchBox3.text!
			self.lastSearched = self.lastSearched.replacingOccurrences(of: " ", with: "+")
			searchBox3.text = ""
			self.findLocation()
			self.lastSearched = self.lastSearched.replacingOccurrences(of: "+", with: " ")
			
		}
		self.searchStack.isHidden = true
		self.navButton.title = "Navigate"
		searchButton.title = "Search"
		searchBox3.isHidden = true
	}
	
	func findLocation() -> Void {
		let APIKey1 = "AIzaSyAXY4G_WyRbcGmZ7zRCw76uHs8Ei5xYIuA"
		
		mapView.clear()
		let directionsURL: String = "https://maps.googleapis.com/maps/api/geocode/json?address=\(self.lastSearched)&key=\(APIKey1)"
		self.locationMarker?.map = nil
		Alamofire.request(directionsURL).responseJSON(completionHandler: {
			response in
			
			print(response.request as Any)  // original URL request
			print(response.response as Any) // HTTP URL response
			print(response.data!)     // server data
			print(response.result as Any)   // result of response serialization
			
			let json = JSON(data: response.data!)
			print(json)
			let result = json["results"].arrayValue
			let firstResult = result.first
			let geometry = firstResult?["geometry"].dictionary
			let location = geometry?["location"]?.dictionary
			//print(location?["lat"]?.doubleValue)
			let locationCoords = CLLocationCoordinate2DMake((location?["lat"]?.doubleValue)!, (location?["lng"]?.doubleValue)!)
			self.locationMarker = GMSMarker(position: locationCoords)
			self.locationMarker?.map = self.mapView
			
			let bounds = geometry?["viewport"]?.dictionary
			let neBound = bounds?["northeast"]?.dictionary
			let swBound = bounds?["southwest"]?.dictionary
			print(bounds as Any)
			let routeBounds = GMSCoordinateBounds(coordinate: CLLocationCoordinate2DMake((swBound?["lat"]?.doubleValue)!, (swBound?["lng"]?.doubleValue)!), coordinate: CLLocationCoordinate2DMake((neBound?["lat"]?.doubleValue)!, (neBound?["lng"]?.doubleValue)!))
			
			self.mapView.animate(with: GMSCameraUpdate.fit(routeBounds))
		})
	}
}

extension MapViewController: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let location: CLLocation = locations.last!
		print("Location: \(location)")
		
		let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
		                                      longitude: location.coordinate.longitude,
		                                      zoom: zoomLevel)
		
		if mapView.isHidden {
			mapView.isHidden = false
			mapView.camera = camera
		} else {
			mapView.animate(to: camera)
		}
		
		listLikelyPlaces()
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		switch status {
		case .restricted:
			print("Location access was restricted.")
		case .denied:
			print("User denied access to location.")
			mapView.isHidden = false
		case .notDetermined:
			print("Location status not determined.")
		case .authorizedAlways: fallthrough
		case .authorizedWhenInUse:
			print("Location status is OK.")
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		locationManager.stopUpdatingLocation()
		print("Error: \(error)")
	}
}






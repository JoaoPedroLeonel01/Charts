//
//  ContentView.swift
//  MapsEstudo
//
//  Created by Joao pedro Leonel on 10/10/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    let cameraPosition: MapCameraPosition = .region(.init(center: .init(latitude: 37.3346, longitude: -122.0090), latitudinalMeters: 1300, longitudinalMeters: 1300 ))
    
    let locationManager = CLLocationManager()
    
    @State private var lookAroundScene: MKLookAroundScene?
    @State private var isShowingLookAround = false
    @State private var route : MKRoute?
    
    var body: some View {
        NavigationStack {
            Map(){
                Annotation("Apple Developer Academy", coordinate: .appleVisitorCenter, anchor: .center){
                    Image(systemName: "laptopcomputer")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.white)
                        .frame(width: 20, height: 20)
                        .padding(7)
                        .background(.pink.gradient,in:.circle)
                        .contextMenu{
                            Button("Open Look Around", systemImage: "binoculars"){
                                Task {
                                    lookAroundScene = await getLookAroundScene(from: .appleVisitorCenter)
                                    guard lookAroundScene != nil else { return }
                                    isShowingLookAround =  true
                                }
                            }
                            Button("Get Diretions", systemImage: "arrow.turn.down.left"){
                                getDirection(to: .appleVisitorCenter)
                            }
                        }
                }
                
                UserAnnotation()
                
                if let route{
                    MapPolyline(route)
                        .stroke(Color.pink, lineWidth: 4)
                }
                
            }
            .tint(.pink)
            .lookAroundViewer(isPresented: $isShowingLookAround, initialScene: lookAroundScene)
            .onAppear{
                locationManager.requestWhenInUseAuthorization()
            }
            .mapControls{
                MapUserLocationButton()
                MapCompass()
                MapPitchToggle()
                MapScaleView()
            }
            .mapStyle(.standard(elevation: .realistic))
        }
        
        
    }
    func getLookAroundScene(from coordinate: CLLocationCoordinate2D) async -> MKLookAroundScene? {
        do{
            return try await MKLookAroundSceneRequest(coordinate: coordinate).scene
        }catch{
            print("Cannot retrieve Look Around Scene; \(error.localizedDescription)")
            return nil
        }
    }
    func getUserLocation() async -> CLLocationCoordinate2D? {
        let updates = CLLocationUpdate.liveUpdates()
        do{
            let update = try await updates.first{$0.location?.coordinate != nil}
            return update?.location?.coordinate
        }catch{
            print("Cannot get user location")
            return nil
        }
    }
    
    func getDirection(to destination: CLLocationCoordinate2D){
        Task{
            guard let userLocation = await getUserLocation() else { return }
            
            let request = MKDirections.Request()
            let sourceItem = MKMapItem(location: CLLocation(latitude: userLocation.latitude,
                                                            longitude: userLocation.longitude),
                                       address: nil)
            
            let destinationItem = MKMapItem(location: CLLocation(latitude: destination.latitude,
                                                                 longitude: destination.longitude),
                                            address: nil)
            
            request.source = sourceItem
            request.destination = destinationItem
            request.transportType = .walking // como vc esta indo, andando,carro, bike etc...
            
            do{
                let directions = try await MKDirections(request: request).calculate()
                route = directions.routes.first
            }catch{
                print("Shoe error")
            }
        }
    }
}

#Preview {
    ContentView()
}


extension CLLocationCoordinate2D {
    static let appleVisitorCenter = CLLocationCoordinate2D(latitude: -15.863686020275095, longitude: -48.02919199455182)
}

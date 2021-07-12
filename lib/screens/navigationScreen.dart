import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart' as geoCo;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Position position;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 140,
                child: GoogleMap(
                  onTap: (tapped) async {
                    final coordinates = new geoCo.Coordinates(
                        tapped.latitude, tapped.longitude);
                    var address = await geoCo.Geocoder.local
                        .findAddressesFromCoordinates(coordinates);
                    var firstAddress = address.first;
                    getMarkers(tapped.latitude, tapped.longitude);
                    await FirebaseFirestore.instance
                        .collection('location')
                        .add({
                      'latitude': tapped.latitude,
                      'longitude': tapped.longitude,
                      'address': firstAddress.addressLine,
                      'country': firstAddress.countryName,
                    });
                  },
                  myLocationEnabled: true,
                  compassEnabled: true,
                  trafficEnabled: true,
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    setState(
                      () {
                        googleMapController = controller;
                      },
                    );
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      26.824971,
                      87.283899,
                    ),
                    zoom: 18.0,
                  ),
                  markers: Set<Marker>.of(
                    markers.values,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getMarkers(double lat, double lng) {
    MarkerId markerId = MarkerId(lat.toString() + lng.toString());
    Marker _marker = Marker(
      markerId: markerId,
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueCyan,
      ),
      infoWindow: InfoWindow(snippet: 'Address'),
    );
    setState(() {
      markers[markerId] = _marker;
    });
  }

  void getCurrentLocation() async {
    Position currentPosition =
        await GeolocatorPlatform.instance.getCurrentPosition();
    setState(() {
      position = currentPosition;
    });
  }
}

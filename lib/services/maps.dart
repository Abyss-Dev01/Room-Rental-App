import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart' as geoCo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GenerateMaps extends ChangeNotifier {
  Position position;
  Position get getPosition => position;
  GoogleMapController googleMapController;
  String finalAddress = "locating...";
  String get getFinalAddress => finalAddress;

  String countryName, mainAddress;
  String get getCountryName => countryName;
  String get getMainAddress => mainAddress;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Future getCurrentLocation() async {
    var positionData = await GeolocatorPlatform.instance.getCurrentPosition();
    final cords =
        geoCo.Coordinates(positionData.latitude, positionData.longitude);
    var _address =
        await geoCo.Geocoder.local.findAddressesFromCoordinates(cords);
    String mainAddress = _address.first.addressLine;
    finalAddress = mainAddress;
    notifyListeners();
  }

  getMarkers(double lat, double lng) {
    MarkerId markerId = MarkerId(lat.toString() + lng.toString());
    Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: getMainAddress, snippet: 'Country name'),
    );
    markers[markerId] = marker;
  }

  Widget fetchMaps() {
    return GoogleMap(
      myLocationEnabled: true,
      compassEnabled: true,
      trafficEnabled: true,
      mapType: MapType.hybrid,
      myLocationButtonEnabled: true,
      onTap: (loc) async {
        final cords = geoCo.Coordinates(loc.latitude, loc.longitude),
            address =
                await geoCo.Geocoder.local.findAddressesFromCoordinates(cords);
        countryName = address.first.countryName;
        mainAddress = address.first.addressLine;
        notifyListeners();
        markers.isEmpty
            ? getMarkers(loc.latitude, loc.longitude)
            : markers.clear();
        print(loc);
      },
      markers: Set<Marker>.of(markers.values),
      onMapCreated: (GoogleMapController mapContorller) {
        googleMapController = mapContorller;
        notifyListeners();
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(26.476544, 87.280845),
        zoom: 18,
      ),
    );
  }
}

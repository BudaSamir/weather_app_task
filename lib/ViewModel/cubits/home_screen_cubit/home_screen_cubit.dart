import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());
  static HomeScreenCubit get(context) => BlocProvider.of(context, listen: true);

  LocationPermission? permission;
  Position? position;
  List<Placemark>? placeMarks;
  bool getLocation = false;

  Future<Position> getLatAndLong() async {
    return await Geolocator.getCurrentPosition().then((value) => value);
  }

  Future getPotion() async {
    // Check if The location Service is Enabled or not
    bool location = await Geolocator.isLocationServiceEnabled();
    // IF THe location Turned off
    if (location == false) {
      // check Permission For make Location Enable
      permission = await Geolocator.checkPermission();
      // checkPermission Cases
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        // IF User Choose Allow
        if (permission != LocationPermission.denied) {
          position = await getLatAndLong();
          placeMarks = await placemarkFromCoordinates(
              position!.latitude, position!.latitude);
        }
      } else {
        // IF User Choosed Allow
        position = await getLatAndLong();
        placeMarks = await placemarkFromCoordinates(
            position!.latitude, position!.latitude);
      }
    } else {
      // IF THe location Turned on
      permission = await Geolocator.requestPermission();
      // IF User Choose Allow
      if (permission != LocationPermission.denied) {
        position = await getLatAndLong();
        placeMarks = await placemarkFromCoordinates(
            position!.latitude, position!.latitude);
      }
    }
    getLocation = true;
  }
}

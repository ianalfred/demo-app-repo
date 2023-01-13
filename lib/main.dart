import 'dart:async';

import 'package:driver/components/app_color.dart';
import 'package:driver/components/app_font.dart';
import 'package:driver/components/offline_screen_component.dart';
import 'package:driver/home.dart';
import 'package:driver/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() async {
  /// Graphql configuration
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    "https://monkfish-app-d8vty.ondigitalocean.app/graphql",
  );

  const FlutterSecureStorage storage = FlutterSecureStorage();

  String? token = await storage.read(key: "token") ?? "";

  final AuthLink authLink = AuthLink(
    // ignore: prefer_interpolation_to_compose_strings
    getToken: () async => 'Bearer ' + token,
  );

  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(
    Phoenix(
      child: LoginUI(client: client, token: token),
    ),
  );
}

class LoginUI extends StatefulWidget {
  final ValueNotifier<GraphQLClient> client;
  final String? token;
  const LoginUI({Key? key, required this.client, this.token}) : super(key: key);

  @override
  State<LoginUI> createState() => _LoginUI();
}

class _LoginUI extends State<LoginUI> {
  var latitude = "Getting latitude...";
  var longitude = "Getting longitude...";
  var address = "Getting address...";
  var isDeviceConnected = false;
  late StreamSubscription<Position> streamSubscription;

  late bool appBarVisible = true;

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  /// Check internet connection
  checkConnection() async {
    var listener = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          setState(() {
            isDeviceConnected = true;
          });
          getCurrentLocation();
          break;
        case InternetConnectionStatus.disconnected:
          setState(() {
            isDeviceConnected = false;
          });
          break;
      }
    });

    // close listener after 30 seconds, so the program doesn't run forever
    await Future.delayed(const Duration(seconds: 30));
    await listener.cancel();
  }

  /// Getting geolocation
  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (isDeviceConnected == true) {
      streamSubscription =
          Geolocator.getPositionStream().listen((Position position) {
        latitude = "${position.latitude}";
        longitude = "${position.latitude}";
        storage.write(
            key: "coordinates",
            value: "${position.latitude}, ${position.latitude}");
        getAddressFromCoordinates(position);
      });
    }
  }

  Future<void> getAddressFromCoordinates(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    address = "${place.street}, ${place.locality}";
    storage.write(key: "address", value: address);
  }

  void changeAppBarVisiblity(bool isVisible) {
    setState(() {
      appBarVisible = isVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
    if (isDeviceConnected == true) {
      getCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: widget.client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Dafric Driver App",
        theme: ThemeData(
          primarySwatch: AppColors.themeMaterialColor(AppColors.mainColor),
        ),
        home: widget.token != ""
            ? Scaffold(
                // resizeToAvoidBottomInset: false,
                appBar: appBarVisible == true
                    ? AppBar(
                        toolbarHeight: 118.0,
                        backgroundColor: Colors.white,
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CircleAvatar(
                              radius: 43.0,
                              backgroundColor: AppColors.mainColor,
                              child: CircleAvatar(
                                radius: 39.0,
                                backgroundImage:
                                    AssetImage('assets/images/avatar.png'),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "Driver",
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 36.0,
                                fontFamily: AppFont.font,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.notifications_outlined,
                                color: Colors.grey[600],
                                size: 29.0,
                              ),
                            ),
                          ),
                        ],
                        flexibleSpace: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                        ),
                        elevation: 0.0,
                      )
                    : null,
                body: isDeviceConnected == true
                    ? HomeScreen(
                        onNavChange: (bool visible) {
                          changeAppBarVisiblity(visible);
                        },
                      )
                    : OfflineScreen(
                        onClicked: () {
                          checkConnection();
                          getCurrentLocation();
                        },
                      ),
              )
            : const SplashScreen(),
      ),
    );
  }
}

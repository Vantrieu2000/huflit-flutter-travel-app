import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:travelink_app/utils/destination_model.dart';

import '../../utils/destination_model.dart';

class DesTinationDetailScreen extends StatefulWidget {
  const DesTinationDetailScreen({Key? key}) : super(key: key);

  @override
  _DesTinationDetailScreenState createState() =>
      _DesTinationDetailScreenState();
}

class _DesTinationDetailScreenState extends State<DesTinationDetailScreen>
    with TickerProviderStateMixin {
  late LatLng googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late YoutubePlayerController _controller;
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );
  Completer<GoogleMapController> _controllerMap = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'X-GCJwz4PnY',
      params: const YoutubePlayerParams(
        playlist: [
          'fTXd-DpN3AI',
          'K18cpp_-gP8',
          'iLnmTe5Q2Qw',
          '_WoCV4c6XOE',
          'KmzdUe0RSJo',
          '6jZDSSZZxjQ',
          'p2lYr3vM_1w',
          '7QUtEmBT_-w',
          '34_PXCzGw1M',
        ],
        startAt: const Duration(minutes: 1, seconds: 36),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _controller.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                      child: Image.network(
                        'https://picsum.photos/seed/64/600',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    shape: BoxShape.rectangle,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                        child: Text(
                          'Place name\nPlace price\nRate : ',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 10),
                  child: Text('Location',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: SizedBox(
                    height: 250,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: GoogleMap(
                        mapType: MapType.hybrid,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controllerMap.complete(controller);
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 10),
                  child: Text('Preview',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                  child: SizedBox(
                    height: 200,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: YoutubePlayerIFrame(
                        controller: _controller,
                        aspectRatio: 16 / 9,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

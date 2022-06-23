import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:travelink_app/screens/Home/destination_detail.dart';
import 'package:travelink_app/utils/activity_model.dart';
import 'package:travelink_app/utils/data.dart';
import 'package:travelink_app/utils/destination_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';

import '../../widgets/custom_image.dart';

class DestinationScreen extends StatefulWidget {
  final String id;

  const DestinationScreen({required this.id});

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  bool _viewMode = false;

  late LatLng googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();

  Completer<GoogleMapController> _controllerMap = Completer();

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(14.058324, 108.277199),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake =
      CameraPosition(bearing: 192.8334901395799, target: LatLng(14.058324, -108.277199), tilt: 59.440717697143555, zoom: 19.151926040649414);

  late Future<Tour> tour = fetchTourDetails(widget.id);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Tour>(
        future: tour,
        builder: (context, snapshot) {
          const double raduis = 20;
          if (snapshot.hasData) {
            late Future<List<Location>> locations = locationFromAddress("${snapshot.data!.address}, Việt Nam");
            return FutureBuilder<List<Location>>(
                future: locations,
                builder: (context, ss) {
                  if (ss.hasData) {
                    return Scaffold(
                      body: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                  height: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0),
                                    ),
                                    child: ShaderMask(
                                      shaderCallback: (bounds) => const LinearGradient(
                                        colors: [Colors.transparent, Color.fromARGB(130, 0, 0, 0)],
                                        begin: Alignment.center,
                                        end: Alignment.center,
                                      ).createShader(bounds),
                                      blendMode: BlendMode.darken,
                                      child: CustomImage(
                                        snapshot.data!.image,
                                        radius: raduis,
                                        width: double.infinity,
                                        height: double.infinity,
                                        isNetwork: true,
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.arrow_back),
                                      iconSize: 30.0,
                                      color: Colors.white,
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          _viewMode ? 'Xem danh sách tour' : 'Xem bản đồ',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                          icon: Icon(_viewMode ? Icons.tour : Icons.location_on),
                                          iconSize: 25.0,
                                          color: Colors.white,
                                          onPressed: () => setState(() {
                                            _kGooglePlex = CameraPosition(
                                              target: LatLng(ss.data![0].latitude, ss.data![0].longitude),
                                              zoom: 14.4746,
                                            );
                                            _viewMode = !_viewMode;
                                          }),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 20.0,
                                bottom: 20.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data!.name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 35.0,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.locationArrow,
                                          size: 15.0,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 5.0),
                                        Text(
                                          snapshot.data!.address,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 20, 0),
                            child: Text('${snapshot.data!.description}', style: TextStyle(fontSize: 18)),
                          ),
                          Expanded(
                              child: _viewMode == true
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 10),
                                          child: Text('Bản đồ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                                      ],
                                    )
                                  : snapshot.data!.subTours != null && snapshot.data!.subTours!.isNotEmpty
                                      ? ListSubTour(snapshot: snapshot)
                                      : Center(
                                          child: Text(
                                          'Chưa cập nhật tour con...',
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                        ))),
                        ],
                      ),
                    );
                  } else if (ss.hasError) {
                    return Text('${ss.error}');
                  }
                  return const CircularProgressIndicator();
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        });
  }
}

class ListSubTour extends StatelessWidget {
  AsyncSnapshot<Tour> snapshot;
  ListSubTour({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
      itemCount: snapshot.data!.subTours == null ? 0 : snapshot.data!.subTours!.length,
      itemBuilder: (BuildContext context, int index) {
        SubTour subTour = snapshot.data!.subTours![index];
        return GestureDetector(
          onTap: () {
            if (subTour.limit > 0)
              Navigator.push(
                  context, MaterialPageRoute(builder: ((context) => DesTinationDetailScreen(tour: snapshot.data!, subTourId: subTour.id))));
            else {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Xin lỗi bạn'),
                        content: const Text('Tour con này đã hết chỗ trống để đặt, vui lòng chọn tour con khác'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('Đã hiểu'),
                          ),
                        ],
                      ));
            }
          },
          child: Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                height: 220.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              'Tour con thứ ${index + 1}',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          Text('Từ '),
                          SizedBox(width: 10.0),
                          Container(
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(subTour.checkIn)),
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          ),
                          SizedBox(width: 10.0),
                          Text('đến '),
                          SizedBox(width: 10.0),
                          Container(
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              new DateFormat('dd-MM-yyyy').format(DateTime.parse(subTour.checkOut)),
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          Text('Số lượng: '),
                          SizedBox(width: 10.0),
                          Container(
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(subTour.limit.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          ),
                          SizedBox(width: 3.0),

                          Text('/${subTour.slot.toString()}'),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          Text('Phương tiện di chuyển: '),
                          SizedBox(width: 10.0),
                          Text(
                              subTour.transportations.map((x) => x.type).length > 0
                                  ? subTour.transportations.map((x) => x.type).toList().join(', ')
                                  : 'Chưa cập nhật...',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

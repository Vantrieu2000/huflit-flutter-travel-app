import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelink_app/screens/Home/destination_detail.dart';
import 'package:travelink_app/utils/activity_model.dart';
import 'package:travelink_app/utils/data.dart';
import 'package:travelink_app/utils/destination_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  late Future<Tour> tour = fetchTourDetails(widget.id);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Tour>(
        future: tour,
        builder: (context, snapshot) {
          const double raduis = 20;
          if (snapshot.hasData) {
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            child: ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Color.fromARGB(100, 0, 0, 0)
                                ],
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              iconSize: 30.0,
                              color: Colors.white,
                              onPressed: () => Navigator.pop(context),
                            ),
                            // Row(
                            //   children: <Widget>[
                            //     IconButton(
                            //       icon: Icon(Icons.search),
                            //       iconSize: 30.0,
                            //       color: Colors.white,
                            //       onPressed: () => Navigator.pop(context),
                            //     ),
                            //     IconButton(
                            //       icon: Icon(FontAwesomeIcons.sortAmountDown),
                            //       iconSize: 25.0,
                            //       color: Colors.white,
                            //       onPressed: () => Navigator.pop(context),
                            //     ),
                            //   ],
                            // ),
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
                      Positioned(
                        right: 20.0,
                        bottom: 20.0,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 25.0,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: snapshot.data!.subTours != null &&
                              snapshot.data!.subTours!.length > 0
                          ? ListView.builder(
                              padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                              itemCount: snapshot.data!.subTours == null
                                  ? 0
                                  : snapshot.data!.subTours!.length,
                              itemBuilder: (BuildContext context, int index) {
                                SubTour subTour =
                                    snapshot.data!.subTours![index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const DesTinationDetailScreen())));
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            5.0, 5.0, 5.0, 5.0),
                                        height: 240.0,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20.0, 20.0, 20.0, 20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: 120.0,
                                                    child: Text(
                                                      'Tour con thứ ${index + 1}',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10.0),
                                              Row(
                                                children: <Widget>[
                                                  Text('Từ '),
                                                  SizedBox(width: 10.0),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(12.0),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        new DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(DateTime
                                                                .parse(subTour
                                                                    .checkIn)),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                  SizedBox(width: 10.0),
                                                  Text('đến '),
                                                  SizedBox(width: 10.0),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(12.0),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      new DateFormat(
                                                              'yyyy-MM-dd')
                                                          .format(DateTime
                                                              .parse(subTour
                                                                  .checkOut)),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10.0),
                                              Row(
                                                children: <Widget>[
                                                  Text('Số lượng còn lại: '),
                                                  SizedBox(width: 10.0),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(12.0),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        subTour.slot.toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10.0),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                      'Phương tiện di chuyển: '),
                                                  SizedBox(width: 10.0),
                                                  Text(
                                                      subTour.transportations
                                                                  .map((x) =>
                                                                      x.type)
                                                                  .length >
                                                              0
                                                          ? subTour
                                                              .transportations
                                                              .map(
                                                                  (x) => x.type)
                                                              .toList()
                                                              .join(', ')
                                                          : 'Chưa cập nhật...',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold))
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
                            )
                          : Center(
                              child: Text(
                              'Chưa cập nhật tour con...',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ))),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        });
  }
}

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:travelink_app/screens/Home/History/history_order.dart';
import 'package:travelink_app/utils/data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../widgets/custom_image.dart';

class DesTinationDetailScreen extends StatefulWidget {
  final Tour tour;
  final String subTourId;

  const DesTinationDetailScreen({required this.tour, required this.subTourId});

  @override
  _DesTinationDetailScreenState createState() => _DesTinationDetailScreenState();
}

class _DesTinationDetailScreenState extends State<DesTinationDetailScreen> {
  late double ratingBarValue = 4;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var formatter = NumberFormat('###,000');
  double raduis = 20;

  @override
  Widget build(BuildContext context) {
    SubTour subTour = widget.tour.subTours!.firstWhere((element) => element.id == widget.subTourId);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          label: const Text('Liên hệ ngay'), onPressed: () => launch("tel://0969231151"), icon: const Icon(Icons.phone)),
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
                        widget.tour.image,
                        radius: raduis,
                        width: double.infinity,
                        height: double.infinity,
                        isNetwork: true,
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30.0,
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                ]),
              ),
              Positioned(
                left: 20.0,
                bottom: 20.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.tour.name,
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
                          widget.tour.address,
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
          Container(
            margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            height: 100.0,
            width: double.infinity,
            decoration: BoxDecoration(
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
                      Text(
                        'Đơn giá: ${formatter.format(widget.tour.price)} VND/người',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text('${widget.tour.schedule}'),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: Text('Phương tiện di chuyển', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
              itemCount: subTour.transportations.length,
              itemBuilder: (BuildContext context, int index) {
                Transportation tp = subTour.transportations[index];
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext contextModal) {
                          int _guestCount = 1;
                          return StatefulBuilder(
                              builder: (BuildContext context, setState) => Container(
                                  height: 600.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                                          child: Text('Hoàn thành đơn đặt',
                                              textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Bạn đang đặt tour ',
                                            style: const TextStyle(color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: widget.tour.name,
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              TextSpan(text: ' ${widget.tour.schedule}'),
                                              const TextSpan(text: ', khởi hành từ ngày '),
                                              TextSpan(
                                                text: DateFormat('dd-MM-yyyy').format(DateTime.parse(subTour.checkIn)),
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              const TextSpan(text: ' đến ngày '),
                                              TextSpan(
                                                text: DateFormat('dd-MM-yyyy').format(DateTime.parse(subTour.checkOut)),
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              const TextSpan(text: '. Phương tiện di chuyển là '),
                                              TextSpan(
                                                text: tp.type,
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              const TextSpan(text: ' khởi hành từ '),
                                              TextSpan(
                                                text: tp.startFrom,
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              TextSpan(text: '.'),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                                          child: Text('Bạn đi mấy người?',
                                              textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                              icon: const Icon(Icons.remove),
                                              onPressed: () => setState(() => _guestCount == 1 ? _guestCount = 1 : _guestCount--),
                                            ),
                                            Text('${_guestCount.toString()} người'),
                                            IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () =>
                                                    setState(() => _guestCount < subTour.limit ? _guestCount++ : _guestCount = _guestCount))
                                          ],
                                        ),
                                        const Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                                          child: Text('Tổng tiền',
                                              textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            const Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                              child: Text('Gói du lịch: '),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '${formatter.format(widget.tour.price)} VND x${_guestCount.toString()} người',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  textAlign: TextAlign.end,
                                                ),
                                                Text('${formatter.format(widget.tour.price * _guestCount)} VND',
                                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            const Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                              child: Text('Phương tiện di chuyển: '),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '${formatter.format(tp.subCharge)} VND x${_guestCount.toString()} người',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  textAlign: TextAlign.end,
                                                ),
                                                Text('${formatter.format(tp.subCharge * _guestCount)} VND',
                                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          height: 10,
                                          thickness: 1,
                                          indent: 120,
                                          endIndent: 0,
                                          color: Colors.black,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            const Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                              child: Text('Tổng cộng: '),
                                            ),
                                            Text('${formatter.format(tp.subCharge * _guestCount + widget.tour.price * _guestCount)} VND',
                                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () => showDialog<String>(
                                                        context: context,
                                                        builder: (BuildContext context) => AlertDialog(
                                                          title: const Text('Bạn có chắc chắn không?'),
                                                          content: RichText(
                                                            text: TextSpan(
                                                              text: 'Bạn đang đặt tour ',
                                                              style: const TextStyle(color: Colors.black),
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                  text: widget.tour.name,
                                                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                                                ),
                                                                TextSpan(text: ' ${widget.tour.schedule}'),
                                                                const TextSpan(text: ', khởi hành từ ngày '),
                                                                TextSpan(
                                                                  text: DateFormat('dd-MM-yyyy').format(DateTime.parse(subTour.checkIn)),
                                                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                                                ),
                                                                const TextSpan(text: ' đến ngày '),
                                                                TextSpan(
                                                                  text: DateFormat('dd-MM-yyyy').format(DateTime.parse(subTour.checkOut)),
                                                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                                                ),
                                                                const TextSpan(text: '. Phương tiện di chuyển là '),
                                                                TextSpan(
                                                                  text: tp.type,
                                                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                                                ),
                                                                const TextSpan(text: ' khởi hành từ '),
                                                                TextSpan(
                                                                  text: tp.startFrom,
                                                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                                                ),
                                                                TextSpan(text: '. Tổng tiền là '),
                                                                TextSpan(
                                                                  text:
                                                                      '${formatter.format(tp.subCharge * _guestCount + widget.tour.price * _guestCount)} VND',
                                                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () => Navigator.pop(context, 'Cancel'),
                                                              child: const Text('Nghĩ lại'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(context, 'OK');
                                                                Navigator.pop(contextModal);
                                                                showModalBottomSheet<void>(
                                                                  context: context,
                                                                  enableDrag: false,
                                                                  isDismissible: false,
                                                                  builder: (BuildContext contextModalDone) {
                                                                    late Future<bool> createOrder = createOrderAPI(
                                                                        tp.id,
                                                                        _guestCount,
                                                                        tp.subCharge * _guestCount + widget.tour.price * _guestCount,
                                                                        widget.tour.price);

                                                                    return FutureBuilder<bool>(
                                                                        future: createOrder,
                                                                        builder: (context, snapshot) {
                                                                          if (snapshot.hasData) {
                                                                            return Container(
                                                                              height: 200,
                                                                              child: Center(
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: <Widget>[
                                                                                    const Text(
                                                                                      'Cảm ơn bạn đã sử dụng Travelink',
                                                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                                                    ),
                                                                                    const SizedBox(height: 20),
                                                                                    ElevatedButton(
                                                                                      child: const Text('Đóng'),
                                                                                      onPressed: () {
                                                                                        Navigator.pop(contextModalDone);
                                                                                        Navigator.of(context)
                                                                                            .popUntil((route) => route.settings.name == "/root");
                                                                                      },
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          } else if (snapshot.hasError) {
                                                                            return Text('${snapshot.error}');
                                                                          }
                                                                          return Container(
                                                                            height: 200,
                                                                            child: Center(
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: <Widget>[const CircularProgressIndicator()],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        });
                                                                  },
                                                                );
                                                              },
                                                              child: const Text('Chấp nhận'),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                  child: const Text('Đặt gói du lịch',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ))),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )));
                        });
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: ((context) => DesTinationDetailScreen(
                    //             tour: snapshot.data!, subTourId: subTour.id))));
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                        height: 100.0,
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
                                      tp.type,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: <Widget>[
                                  Text('Phụ thu: '),
                                  SizedBox(width: 10.0),
                                  Text(
                                    formatter.format(tp.subCharge),
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(' VND/người'),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                children: <Widget>[
                                  Text('Khởi hành từ '),
                                  SizedBox(width: 10.0),
                                  Text(
                                    tp.startFrom,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

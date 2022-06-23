import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travelink_app/theme/color.dart';
import 'package:travelink_app/utils/data.dart';
import 'package:travelink_app/utils/destination_model.dart';
import 'package:travelink_app/widgets/category_item.dart';
import 'package:travelink_app/widgets/popular_item.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'destination_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: appBgColor,
              pinned: true,
              snap: true,
              floating: true,
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
              title: getAppBar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => buildBody(),
                childCount: 1,
              ),
            )
          ],
        ));
  }

  Widget getAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Xin chào , A",
              style: TextStyle(
                  color: textColor, fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 3,
            ),
            Text("Khám phá ngay nào !",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                )),
          ],
        )),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'Hu5PgVtzdd8',
      params: const YoutubePlayerParams(
        playlist: [
          'Hu5PgVtzdd8',
        ],
        startAt: const Duration(minutes: 0, seconds: 0),
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
    };
    _controller.onExitFullscreen = () {};
  }

  buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // SizedBox(
          //   height: 25,
          // ),
          // Container(
          //   child: getCategories(),
          // ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
            child: Text("Phổ biến nhất",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                )),
          ),
          getPopulars(),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
            child: Text("Vlog mới nhất",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                )),
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

          SizedBox(
            height: 70,
          ),
        ]),
      ),
    );
  }

  // getCategories() {
  //   List<Widget> lists = List.generate(
  //       categories.length,
  //       (index) => CategoryItem(
  //             data: categories[index],
  //             color: listColors[index % 10],
  //             onTap: () {},
  //           ));
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     padding: EdgeInsets.only(bottom: 5, left: 15),
  //     child: Row(children: lists),
  //   );
  // }

  late Future<List<Popular>> futurePopular;

  getPopulars() {
    futurePopular = fetchPopulars();
    return FutureBuilder<List<Popular>>(
        future: futurePopular,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider(
                options: CarouselOptions(
                  height: 390,
                  enlargeCenterPage: true,
                  disableCenter: true,
                  viewportFraction: .75,
                ),
                items: List.generate(
                  snapshot.data!.length,
                  (index) => GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DestinationScreen(
                          id: snapshot.data![index].id,
                        ),
                      ),
                    ),
                    child: PopularItem(
                      data: snapshot.data![index],
                    ),
                  ),
                ));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        });
  }
}

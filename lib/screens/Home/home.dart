import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travelink_app/theme/color.dart';
import 'package:travelink_app/utils/data.dart';
import 'package:travelink_app/utils/destination_model.dart';
import 'package:travelink_app/widgets/category_item.dart';
import 'package:travelink_app/widgets/popular_item.dart';

import 'destination_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 25,
          ),
          Container(
            child: getCategories(),
          ),
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
          SizedBox(
            height: 25,
          ),
        ]),
      ),
    );
  }

  getCategories() {
    List<Widget> lists = List.generate(
        categories.length,
        (index) => CategoryItem(
              data: categories[index],
              color: listColors[index % 10],
              onTap: () {},
            ));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }

  getPopulars() {
    return CarouselSlider(
        options: CarouselOptions(
          height: 390,
          enlargeCenterPage: true,
          disableCenter: true,
          viewportFraction: .75,
        ),
        items: List.generate(
          populars.length,
          (index) => GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DestinationScreen(
                  destination: destinations[index],
                ),
              ),
            ),
            child: PopularItem(
              data: populars[index],
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelink_app/theme/color.dart';
import 'package:travelink_app/utils/data.dart';
import 'package:travelink_app/widgets/explore_category_item.dart';
import 'package:travelink_app/widgets/explore_item.dart';
import 'package:travelink_app/widgets/icon_box.dart';
import 'package:travelink_app/widgets/round_textbox.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() => setState(() => {}));
  }

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
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Khám phá",
                style: TextStyle(
                    color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )),
          // IconBox(
          //   child: SvgPicture.asset(
          //     "assets/icons/filter.svg",
          //     width: 20,
          //     height: 20,
          //   ),
          // )
        ],
      ),
    );
  }

  buildBody() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 10,
      ),
      Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: RoundTextBox(
            hintText: "Tìm kiếm...",
            controller: searchController,
            prefixIcon: Icon(Icons.search, color: darker),
          )),
      SizedBox(
        height: 20,
      ),
      Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: getPlaces(),
      ),
      SizedBox(
        height: 70,
      ),
    ]));
  }

  int selectedIndex = 0;
  late Future<List<Tour>> futureTour;

  getPlaces() {
    futureTour = fetchTours();
    return FutureBuilder<List<Tour>>(
        future: futureTour,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Tour> tourFilter = snapshot.data!
                .where((element) => element.name
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase()))
                .toList();
            return new StaggeredGridView.countBuilder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              itemCount: tourFilter.length,
              itemBuilder: (BuildContext context, int index) =>
                  ExploreItem(data: tourFilter[index], onTap: () {}),
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, index.isEven ? 3 : 2),
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        });
  }
}

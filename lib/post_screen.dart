import 'package:flutter/material.dart';
import 'package:post_app/Fragment/detail_post_screen.dart';
import 'package:post_app/Utils/CommonColor.dart';
import 'package:post_app/Utils/common_widget.dart';
import 'package:post_app/Utils/size_config.dart';
import 'package:post_app/my_post_screen.dart';

class PostScreen extends StatefulWidget {
  final String PostImg;
  final PostScreenInterface mListener;
  final String likeNumber;
  const PostScreen({Key key, this.PostImg, this.mListener, this.likeNumber})
      : super(key: key);
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen>
    implements DetailScreenInterface {
  int page = 1;
  bool isShowLike = false;
  bool isShowunLike = true;
  int like = 0;
  String newGalleryImage = "";
  List<String> items = [
    'item 1',
    'item 2',
    'item 3',
    'item 4',
    'item 5',
    'item 6',
    'item 7',
    'item 8',
    'item 9',
  ];
  List<String> itemsTime = [
    '35 mins ago',
    '36 mins ago',
    '22 mins ago',
    '3 mins ago',
    '20 mins ago',
    '35 mins ago',
    '7 mins ago',
    '35 mins ago',
    '5 mins ago',
    // '35 mins ago',
    // '35 mins ago',
    // '35 mins ago',
    // '35 mins ago',
    // '35 mins ago',
    // '35 mins ago',
    // '35 mins ago',
  ];
  List<String> names = [
    "Ling Waldner",
    "Gricelda Barrera",
    "Lenard Milton",
    "Bryant Lara",
    "Rosalva Sadberry",
    "Guadalupe Ratledge",
    "Brandy Gazda",
    "Kurt Toms",
    "Rosario Gathright",
    // "Kim Delph",
    // "Stacy Christensen",
  ];
  List<String> postImage = [
    "images/1.jpeg",
    "images/2.jpeg",
    "images/3.jpeg",
    "images/4.jpg",
    "images/5.jpeg",
    "images/6.jpeg",
    "images/7.png",
    "images/2.jpeg",
    "images/3.jpeg",
  ];
  bool isLoading = false;

  bool isPagination = true;

  Future _loadData() async {
    // perform fetching data delay
    await new Future.delayed(new Duration(seconds: 2));

    print("load more");
    // update data and loading status
    setState(() {
      items.addAll(['item 1']);
      print('items: ' + items.toString());
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("imagggg....${postImage}");
    //items.length < 3 ? isPagination == false : isPagination == true;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Social Post")),
      ),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!isLoading &&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      _loadData();
                      // start loading data
                      setState(() {
                        isLoading = true;
                      });
                    }
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.all(0.0),
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return getAddPostItems(SizeConfig.screenHeight,
                          SizeConfig.screenWidth, index);
                    },
                  ),
                ),
              ),
              // Container(
              //   height: isLoading ? 50.0 : 0,
              //   color: Colors.transparent,
              //   child: Center(
              //     child: new CircularProgressIndicator(),
              //   ),
              // ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MyPostScreen()));
            },
            child: Padding(
              padding: EdgeInsets.only(
                  right: SizeConfig.screenWidth * 0.03,
                  bottom: SizeConfig.screenHeight * 0.03),
              child: Container(
                height: SizeConfig.screenHeight * .08,
                width: SizeConfig.screenHeight * .08,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Icon(
                  Icons.add,
                  size: SizeConfig.screenHeight * 0.03,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getAddPostItems(double parentHeight, double parentWidth, int index) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.01),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: parentWidth * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: parentHeight * .04,
                      width: parentHeight * .04,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //color: Colors.grey,
                        image: DecorationImage(
                            image: new AssetImage(postImage[index]),
                            fit: BoxFit.cover),
                      ),

                      // child: Image(
                      //   image: new AssetImage(postImage[index]),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        names[index],
                        style: CommonWidget.getAvenierHeavyTextStyle(
                            SizeConfig.blockSizeHorizontal * 4.5,
                            CommonColor.DARK_BLUE,
                            FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: parentWidth * 0.08),
                  child: Text(
                    itemsTime[index],
                    style: CommonWidget.getAvenierHeavyTextStyle(
                        SizeConfig.blockSizeHorizontal * 3,
                        CommonColor.TEXT_INACTIVE_COLOR,
                        FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailScreen(
                        detailImg: postImage[index],
                        mListener: this,
                        likeCount: like.toString(),
                      )));
            },
            child: Padding(
              padding: EdgeInsets.only(
                  top: parentHeight * 0.01, bottom: parentWidth * 0.009),
              child: Container(
                height: parentHeight * .15,
                width: parentHeight * .45,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.grey),
                child: Image(
                  image: new AssetImage(postImage[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          getAddLikeCommentShareLayout(parentHeight, parentWidth)
        ],
      ),
    );
  }

  Widget getAddLikeCommentShareLayout(double parentHeight, double parentWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: parentWidth * 0.06, top: parentHeight * 0.01),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    //like = like + 1;
                  });
                },
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isShowLike = true;
                          isShowunLike = false;
                          like = like + 1;
                        });
                      },
                      child: Visibility(
                        visible: isShowunLike,
                        child: Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.03),
                          child: Container(
                            child: Icon(
                              Icons.thumb_up,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isShowLike = false;
                          isShowunLike = true;
                        });
                      },
                      child: Visibility(
                        visible: isShowLike,
                        child: Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.03),
                          child: Container(
                            child: Icon(
                              Icons.thumb_up,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: parentWidth * 0.03),
                child: Container(
                  child: Icon(
                    Icons.message,
                    color: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: parentWidth * 0.03),
                child: Container(
                  child: Icon(
                    Icons.share,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              right: parentWidth * 0.05, top: parentHeight * 0.01),
          child: Text("${like}  Likes"),
        ),
      ],
    );
  }

  @override
  addImage(String Image) {
    // TODO: implement addImage
    setState(() {
      Image = postImage.toString();
    });
  }
}

abstract class PostScreenInterface {
  addImage(String imagePath);
}

import 'package:flutter/material.dart';
import 'package:post_app/Utils/AppPreference.dart';
import 'package:post_app/Utils/CommonColor.dart';
import 'package:post_app/Utils/String_En.dart';
import 'package:post_app/Utils/common_widget.dart';
import 'package:post_app/Utils/size_config.dart';
import 'package:post_app/post_screen.dart';
import 'package:readmore/readmore.dart';
import 'package:share/share.dart';

class DetailScreen extends StatefulWidget {
  final String detailImg;
  final DetailScreenInterface mListener;
  final String likeCount;
  const DetailScreen({Key key, this.detailImg, this.mListener, this.likeCount})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    implements PostScreenInterface {
  String postPic = "";
  String img;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postPic = widget.detailImg;
    print("eeeee..${postPic}");
    getLocalData();
  }

  getLocalData() async {
    String selectPost = await AppPreferences.getProfilePic();
    if (mounted)
      setState(() {
        img = selectPost;
      });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CommonColor.BLACK_COLOR,
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getAddDetailImageLayout(
                  SizeConfig.screenHeight, SizeConfig.screenWidth),
              getAddDescription(
                  SizeConfig.screenHeight, SizeConfig.screenWidth),
              getAddLikeLayout(SizeConfig.screenHeight, SizeConfig.screenWidth),
            ],
          ),
          GestureDetector(
            onTap: () {
              _simplePopup(SizeConfig.screenHeight, SizeConfig.screenWidth);
            },
            child: Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.screenHeight * .07,
                  right: SizeConfig.screenWidth * 0.03),
              child: Icon(
                Icons.more_vert,
                size: SizeConfig.screenHeight * 0.04,
                color: Colors.white60,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _simplePopup(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(right: parentWidth * 0.03),
      child: Container(
        // width: parentHeight*0.2,

        child: PopupMenuButton(
          //padding: EdgeInsets.all(0.0),
          icon: Icon(Icons.more_vert, color: Colors.white),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: parentHeight * 0.005),
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Image(
                            image: new AssetImage("images/frwd.png"),
                            height: parentHeight * 0.025,
                            //  color: CommonColor.BACK_ICON_COLOR,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: parentWidth * 0.05),
                            child: Text(
                              StringEn.FORWARD,
                              style: new TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 4.4,
                                fontFamily: "Avenir_Book",
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                              textScaleFactor: 1.07,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: parentHeight * .02),
                    child: Container(
                      height: parentHeight * .001,
                      // width: parentWidth,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Share.share(modelData.profilePic);
                    },
                    onDoubleTap: () {},
                    child: Padding(
                      padding: EdgeInsets.only(top: parentHeight * 0.01),
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Icon(
                              Icons.directions,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: parentWidth * 0.05,
                                  top: parentHeight * 0.0),
                              child: Text(
                                StringEn.SHARE,
                                style: new TextStyle(
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 4.4,
                                  fontFamily: "Avenir_Book",
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                                textScaleFactor: 1.07,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: parentHeight * .02),
                    child: Container(
                      height: parentHeight * .001,
                      // width: parentWidth,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              // value: 3,

              child: Container(
                //padding: EdgeInsets.all(0.0)  ,
                color: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.delete,
                      size: parentHeight * 0.032,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: parentWidth * 0.05),
                        child: Text(
                          StringEn.DELETE,
                          style: new TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 4.4,
                            fontFamily: "Avenir_Book",
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                          textScaleFactor: 1.07,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAddDetailImageLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * .25),
      child: Container(
        height: parentHeight * .4,
        width: parentWidth,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          //image: isShowImage == false?
          color: Colors.white,
        ),
        child: Image(
          image: new AssetImage(widget.detailImg),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget getAddLikeLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Divider(
            color: CommonColor.TEXT_INACTIVE_COLOR,
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: parentWidth * 0.02),
                        child: Text(
                          "${widget.likeCount} Likes",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.comment,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: parentWidth * 0.02),
                        child: Text(
                          "Comment",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Share.share(widget.detailImg);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.directions,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: parentWidth * 0.02),
                            child: Text(
                              "Share",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getAddDescription(double parentHeight, double parentWidth) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        //height: parentHeight * .45,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ReadMoreText(
                  'Actor Vicky Kaushal has reportedelly been approached toplay Amitabh Bachchan s role in the remake of 1975 film Chupke Chupke Reportedly the film will essay the character played by Dharmendra in the original. The 1975 comedy-drama film, which was directed by Hrishikesh Mukherjee,also starred Sharmila Tagore and Jaya Bachchan, among others.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  trimLines: 2,
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '...Show more',
                  trimExpandedText: ' show less',
                ),
              ),
            ),
            // Expanded(
            //   child: Text(
            //     "Actor Vicky Kaushal has reportedelly been approached to
            //     play Amitabh Bachchan 's role in the remake of 1975 film Chupke Chupke Reportedly.
            //     the film will essay the character played by Dharmendra in the original. The
            //     1975 comedy-drama film, which was directed by Hrishikesh Mukherjee,also
            //     starred Sharmila Tagore and Jaya Bachchan, among others.",
            //     style: TextStyle(
            //         fontSize: SizeConfig.blockSizeHorizontal * 3,
            //         color: Colors.white60
            //         //fontFamily: "SemiBold"
            //         ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  addImage(String imagePath) {
    setState(() {
      imagePath = widget.detailImg;
    });
  }
}

abstract class DetailScreenInterface {
  addImage(String Image);
}

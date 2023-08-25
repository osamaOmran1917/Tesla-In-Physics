import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/models/lesson.dart';
import 'package:video_player/video_player.dart';

class LessonDetails extends StatefulWidget {
  final Lesson lesson;

  LessonDetails(this.lesson);

  @override
  _LessonDetailsState createState() => _LessonDetailsState();
}

class _LessonDetailsState extends State<LessonDetails> {
  VideoPlayerController? _controller;
  ChewieController? _chewieController;
  String omarImage = '';

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.lesson.media ?? '');

    _chewieController = ChewieController(
      videoPlayerController: _controller!,
      autoPlay: true,
      looping: true,
      allowPlaybackSpeedChanging: true,
      showControlsOnInitialize: false,
      // Additional options
    );
    _getOmarImage();
  }

  Future<void> _getOmarImage() async {
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc('6kfQ8I3Q2ATNqFia04aQnELDX123')
        .get();
    var data = documentSnapshot.data();
    setState(() {
      omarImage = data!['image'];
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
    _chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/designed_background.jpg'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .061),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * .067),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: lightGreen,
                      borderRadius: BorderRadius.circular(width * .05),
                    ),
                    child: Image.asset(
                      'assets/images/back.png',
                      width: width * .15,
                      height: width * .15,
                    ),
                  ),
                ),
                Text(
                  'تفاصيل الدرس',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    fontSize: width * .05,
                  ),
                ),
                SizedBox(height: height * .03),
                FutureBuilder(
                  future: _controller!.initialize(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(width * .05),
                        child: AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: Chewie(
                            controller: _chewieController!,
                          ),
                        ),
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: lightGreen,
                          ),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(
                  height: height * .03,
                ),
                Container(
                  padding: EdgeInsets.all(width * .05),
                  decoration: BoxDecoration(
                      color: Color(0xFFD8EDDC),
                      borderRadius: BorderRadius.circular(width * .05)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.lesson.number,
                        style: TextStyle(
                            fontFamily: 'cairo',
                            color: lightGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: width * .05),
                      ),
                      Text(
                        widget.lesson.details ?? '',
                        style:
                            TextStyle(fontFamily: 'cairo', color: lightGreen),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: height * .015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            _controller != null &&
                                    _controller!.value.isInitialized
                                ? '${_controller!.value.duration.inMinutes}:${_controller!.value.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}'
                                : '',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'عمر مصطفى',
                            style: TextStyle(
                                fontFamily: 'cairo', color: lightGreen),
                          ),
                          SizedBox(
                            width: width * .03,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(height * .1),
                            child: CachedNetworkImage(
                              width: height * .05,
                              height: height * .05,
                              imageUrl: omarImage,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
                                child: Icon(CupertinoIcons.person_alt),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

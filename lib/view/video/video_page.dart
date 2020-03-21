import 'package:flutter/material.dart';
import 'package:osk_flutter/values/app_colors.dart';
import 'package:osk_flutter/view/common/primary_button.dart';
import 'package:osk_flutter/view/common/styled_circular_progress_indicator.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  static MaterialPageRoute pageRoute({
    MaterialPageRoute nextPageRoute,
    String youtubeUrl,
    String nextButtonText,
  }) =>
      MaterialPageRoute(
          builder: (BuildContext context) => VideoPage(
                nextPageRoute: nextPageRoute,
                youtubeUrl: youtubeUrl,
                nextButtonText: nextButtonText,
              ));

  final MaterialPageRoute nextPageRoute;
  final String youtubeUrl;
  final String nextButtonText;

  const VideoPage({Key key, this.nextPageRoute, this.youtubeUrl, this.nextButtonText}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  YoutubePlayerController _controller;
  bool _showProgress = true;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.youtubeUrl),
      flags: YoutubePlayerFlags(
        controlsVisibleAtStart: false,
        forceHideAnnotation: true,
        hideControls: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const IntroAppBar(showBottomDash: false),
      body: _controller != null ? _buildBody() : StyledCircularProgressIndicator(),
    );
  }

  Widget _buildBody() {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: AppColors.primaryBlue,
          aspectRatio: size.width / size.height,
          progressColors: ProgressBarColors(
            playedColor: AppColors.primaryBlue,
            handleColor: AppColors.primaryBlue.withAlpha(180),
          ),
          onReady: () {
            setState(() {
              _showProgress = false;
            });
          },
          onEnded: (_) {
            if (widget.nextPageRoute != null) {
              Navigator.pushReplacement(context, widget.nextPageRoute);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        Visibility(
          visible: _showProgress,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Center(
              child: StyledCircularProgressIndicator(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: PrimaryButton(
              title: widget.nextButtonText ?? "Dalej",
              onClick: () {
                if (widget.nextPageRoute != null) {
                  Navigator.pushReplacement(context, widget.nextPageRoute);
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }
}

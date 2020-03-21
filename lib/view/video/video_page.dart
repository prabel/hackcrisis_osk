import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osk_flutter/data/firebase_repository.dart';
import 'package:osk_flutter/view/intro/intro_app_bar.dart';

class VideoPage extends StatefulWidget {
  static MaterialPageRoute pageRoute({
    VoidCallback onFinish,
    String youtubeUrl,
    Widget bottomButton,
  }) =>
      MaterialPageRoute(
          builder: (BuildContext context) => VideoPage(
                onFinish: onFinish,
                youtubeUrl: youtubeUrl,
                bottomButton: bottomButton,
              ));

  final VoidCallback onFinish;
  final String youtubeUrl;
  final Widget bottomButton;

  const VideoPage({Key key, this.onFinish, this.youtubeUrl, this.bottomButton}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  String _interviewVideoUrl;

  @override
  void initState() {
    super.initState();
    RepositoryProvider.of<FirebaseRepository>(context).getInterviewVideoUrl().then((url) {
      setState(() {
        _interviewVideoUrl = url;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const IntroAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container();
  }
}

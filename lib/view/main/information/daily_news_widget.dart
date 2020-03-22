import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:osk_flutter/data/firebase_repository.dart';
import 'package:osk_flutter/model/daily_news_item_model.dart';
import 'package:osk_flutter/values/app_colors.dart';

class DailyNewsWidget extends StatefulWidget {
  @override
  _DailyNewsWidgetState createState() => _DailyNewsWidgetState();
}

class _DailyNewsWidgetState extends State<DailyNewsWidget> {
  List<DailyNewsItemModel> _items = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return _items.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 24),
              Text(
                "Informacje ogólnopolskie",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Aktualizacja codziennie o g. 9.00 i 21.00",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 18),
              Container(
                height: 260,
                width: double.infinity,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    print("Image url -> ${_items[index].imageUrl}");
                    return InkWell(
                      onTap: () {
                        FlutterWebBrowser.openWebPage(
                            url: _items[index].linkUrl, androidToolbarColor: AppColors.primaryBlue);
                      },
                      child: Container(
                        height: 260,
                        width: 260,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: FittedBox(
                          child: CachedNetworkImage(
                            imageUrl: _items[index].imageUrl,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 14);
                  },
                  itemCount: _items.length,
                ),
              )
            ],
          );
  }

  void _loadData() async {
    try {
      List<DailyNewsItemModel> list = await RepositoryProvider.of<FirebaseRepository>(context).getDailyNews();
      setState(() {
        _items = list;
      });
    } catch (e) {}
  }
}

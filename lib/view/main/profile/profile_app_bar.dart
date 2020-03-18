import 'package:flutter/material.dart';

class ProfileAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const ProfileAppBar({Key key, @required this.title}) : super(key: key);

  @override
  _ProfileAppBarState createState() => _ProfileAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 58);
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      snap: false,
      expandedHeight: 120,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(widget.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColorLight,
            )),
        centerTitle: false,
        titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 16, end: 16),
      ),
    );
  }
}

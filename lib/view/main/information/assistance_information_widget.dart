import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osk_flutter/data/firebase_repository.dart';
import 'package:osk_flutter/data/user_repository.dart';
import 'package:osk_flutter/domain/user/get_user_use_case.dart';
import 'package:osk_flutter/model/assistance_extra_information_model.dart';
import 'package:osk_flutter/model/user_model.dart';
import 'package:osk_flutter/view/main/information/assistance_informations_holder.dart';

class AssistanceInformationWidget extends StatefulWidget {
  @override
  _AssistanceInformationWidgetState createState() => _AssistanceInformationWidgetState();
}

class _AssistanceInformationWidgetState extends State<AssistanceInformationWidget> {
  List<AssistanceExtraInformationModel> _items = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  void didUpdateWidget(AssistanceInformationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (_items.isNotEmpty) ...[
          const SizedBox(height: 34),
          Text(
            "Wiedza dla Ciebie",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 18),
        ],
        Column(
          mainAxisSize: MainAxisSize.min,
          children: _items
              .map((it) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: AssistanceInformationHolder(it),
                  ))
              .toList(),
        ),
      ],
    );
  }

  void loadData() async {
    HashMap<int, AssistanceExtraInformationModel> map =
        await RepositoryProvider.of<FirebaseRepository>(context).getAssistanceExtraInformationsMap();
    final UserModel userModel = await GetUserUseCase(RepositoryProvider.of<UserRepository>(context)).execute();

    setState(() {
      List<AssistanceExtraInformationModel> temp = [];
      userModel.assistanceStatusIds.forEach((it) {
        if (map.containsKey(it)) {
          temp.add(map[it]);
        }
      });
      _items = temp;
    });
  }
}

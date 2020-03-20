import 'package:flutter/material.dart';
import 'package:osk_flutter/values/assistance_statuses.dart';

class AssistanceStatusHolder extends StatelessWidget {
  final AssistanceStatus _assistanceStatus;

  const AssistanceStatusHolder(this._assistanceStatus, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Color(0XFFEBEBEB)),
      ),
      child: Row(
        children: <Widget>[
          Container(height: 44, width: 0),
          const SizedBox(width: 8),
          Container(
            height: 36,
            width: 10,
            decoration: BoxDecoration(
              color: _assistanceStatus.getColors()[0],
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              _assistanceStatus.getDescription(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frifri/src/core/ui_kit/styles/styles.dart';

class PathInfoHeader extends StatelessWidget {
  const PathInfoHeader({required this.companyIconPath});
  final String companyIconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 32,
              height: 32,
              child: Image.asset(
                companyIconPath,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Text>[
                Text(
                  'S7 airlines',
                  style: AppStyles.textStylePoppins
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  '2ч 50м в полете',
                  style: AppStyles.textStylePoppins.copyWith(fontSize: 12),
                ),
              ],
            )
          ],
        ),
        InkWell(
          onTap: () {
            print('1');
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(6, 16, 6, 16),
            decoration: BoxDecoration(
              color: Color(0xFFEEF3FD),
            ),
            child: Text("Подробнее",
                style: AppStyles.textStylePoppins
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 12)),
          ),
        )
      ],
    );
  }
}
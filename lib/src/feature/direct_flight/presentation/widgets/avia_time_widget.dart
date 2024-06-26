import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

/// {@template avia_time_widget}
/// AviaTimeWidget widget.
/// {@endtemplate}
class AviaTimeWidget extends StatelessWidget {
  /// {@macro avia_time_widget}
  const AviaTimeWidget({super.key, required this.time});

  final String time;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 28),
      child: Column(
        children: <Widget>[
          SvgPicture.asset(
            'assets/icons/avia copy.svg',
            height: 22,
          ),
          Text(
            time,
            style:
                GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
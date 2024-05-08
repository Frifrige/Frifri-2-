import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

/// {@template choose_location_widget}
/// ChooseAirport widget.
/// {@endtemplate}
class ChooseAirport extends StatefulWidget {
  /// {@macro choose_location_widget}
  const ChooseAirport({super.key});

  @override
  State<ChooseAirport> createState() => _ChooseAirportState();
}

class _ChooseAirportState extends State<ChooseAirport> {
  bool active = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.05,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: EdgeInsets.only(right: 14),
                          child: SvgPicture.asset('assets/icons/close.svg')),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.departureAirport,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(color: Color.fromRGBO(0, 0, 0, 0.12)),
              Container(
                margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
                height: MediaQuery.sizeOf(context).height * 0.2,
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 0.12),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            setState(() {
                              active = !active;
                            });
                          },
                          child: Container(
                            height: 24,
                            width: 24,
                            child: FractionallySizedBox(
                                widthFactor: 0.5,
                                heightFactor: 0.5,
                                child: active
                                    ? SvgPicture.asset(
                                        'assets/icons/action.svg')
                                    : null),
                            decoration: BoxDecoration(
                              color: active
                                  ? Color.fromRGBO(227, 14, 5, 1)
                                  : Colors.transparent,
                              border: active
                                  ? null
                                  : Border.all(
                                      color: Color.fromRGBO(0, 0, 0, 0.12)),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Тбилиси',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        CustomCheckBox(),
                        SizedBox(width: 20),
                        Text(
                          'Тбилиси',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1),
                        ),
                      ],
                    ),
                    Divider(
                      indent: 26,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// {@template choose_location_widget}
/// CustomCheckBox widget.
/// {@endtemplate}
class CustomCheckBox extends StatefulWidget {
  /// {@macro choose_location_widget}
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        setState(() {
          active = !active;
        });
      },
      child: Container(
        height: 24,
        width: 24,
        child: FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 0.5,
            child: active ? SvgPicture.asset('assets/icons/action.svg') : null),
        decoration: BoxDecoration(
          color: active ? Color.fromRGBO(227, 14, 5, 1) : Colors.transparent,
          border:
              active ? null : Border.all(color: Color.fromRGBO(0, 0, 0, 0.12)),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}

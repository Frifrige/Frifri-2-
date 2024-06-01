import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frifri/src/core/helpers/signature_helper.dart';
import 'package:frifri/src/core/helpers/url_launcher_helper.dart';
import 'package:frifri/src/core/ui_kit/buttons/confirm_button.dart';
import 'package:frifri/src/core/ui_kit/modals/default_modal.dart';
import 'package:frifri/src/core/ui_kit/styles/styles.dart';
import 'package:frifri/src/core/utils/logger.dart';
import 'package:frifri/src/feature/more/domain/currency_bloc.dart';
import 'package:frifri/src/feature/more/domain/language_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/extensions/formatters.dart';
import '../../../buy_ticket/data/dto/month_matrix.dart';

class FlightPricesModal extends StatelessWidget {
  const FlightPricesModal({
    super.key,
    required this.originAirportName,
    required this.destinationAirportName,
    required this.monthMatrixDayInfo,
  });

  final String originAirportName;
  final String destinationAirportName;

  final List<MonthMatrixDayInfo> monthMatrixDayInfo;

  @override
  Widget build(BuildContext context) {
    return DefaultModalWrapper(
      child: Column(
        children: [
          FlightPricesModalHeader(
            destinationAirportName: destinationAirportName,
            originAirportName: originAirportName,
            monthMatrixDayInfo: monthMatrixDayInfo,
          ),
          const Divider(
            height: 1,
            thickness: 0.5,
          ),
          FlightPricesModalContent(
            monthMatrixDayInfo: monthMatrixDayInfo,
            destination: destinationAirportName,
          ),
        ],
      ),
    );
  }
}

class FlightPricesModalHeader extends StatelessWidget {
  const FlightPricesModalHeader({
    super.key,
    required this.originAirportName,
    required this.destinationAirportName,
    required this.monthMatrixDayInfo,
  });

  final String originAirportName;
  final String destinationAirportName;
  final List<MonthMatrixDayInfo> monthMatrixDayInfo;

  static const _headerTextScaleFactor = 0.27;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 26,
        vertical: 17.6,
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width:
                    MediaQuery.sizeOf(context).width * _headerTextScaleFactor,
                child: Text(
                  textAlign: TextAlign.center,
                  originAirportName,
                  style: AppStyles.textStylePoppins.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: SvgPicture.asset(
                  "assets/icons/searchfly-airplane.svg",
                  fit: BoxFit.contain,
                  height: 25,
                  width: 25,
                ),
              ),
              SizedBox(
                width:
                    MediaQuery.sizeOf(context).width * _headerTextScaleFactor,
                child: Text(
                  textAlign: TextAlign.center,
                  destinationAirportName,
                  style: AppStyles.textStylePoppins.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset("assets/icons/close.svg"),
            ),
          ),
        ],
      ),
    );
  }
}

class FlightPricesModalContent extends StatefulWidget {
  const FlightPricesModalContent({super.key, required this.monthMatrixDayInfo, required this.destination});

  final List<MonthMatrixDayInfo> monthMatrixDayInfo;
  final String destination;

  @override
  State<FlightPricesModalContent> createState() =>
      _FlightPricesModalContentState();
}

class _FlightPricesModalContentState extends State<FlightPricesModalContent> {
  @override
  Widget build(BuildContext context) {
    final currency = context.watch<CurrencySettingsCubit>().state;
    final language = context.watch<AppLanguageSettingsCubit>().state;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context).when,
                    style: AppStyles.textStylePoppins.copyWith(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    AppLocalizations.of(context).back,
                    style: AppStyles.textStylePoppins.copyWith(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    AppLocalizations.of(context).price,
                    textAlign: TextAlign.end,
                    style: AppStyles.textStylePoppins.copyWith(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              ...widget.monthMatrixDayInfo.map((e) => Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        TimeWidget(
                            date: dateFormatDay(e.departDate, language),
                            time: ''),
                        const Spacer(),
                        TimeWidget(
                            date: dateFormatDay(
                                DateTime.parse(e.returnDate), language),
                            time: formatMinutesToHoursAndMinutes(
                              e.duration,
                              context,
                            )),
                        const Spacer(),
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'от ${formatNumberWithSpaces(e.value, currency)}',
                            style: GoogleFonts.rubik(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff5B9CEC)),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          )),
          const SizedBox(height: 20),
          Divider(
            color: const Color(0xff000000).withOpacity(0.2),
            height: 1,
            thickness: 0.5,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/prices_calendar.svg"),
                      Text(
                        AppLocalizations.of(context).goToPriceCalendar,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 48,
                  child: ConfirmationButton(
                    child: Text(
                      "${AppLocalizations.of(context).from} ${formatNumberWithSpaces(
                        widget.monthMatrixDayInfo.first.value,
                        currency,
                      )}",
                      style: AppStyles.textStylePoppins.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
              UrlLauncherHelper.launchInWeb('https://frifri.ge/${language}/${widget.destination}');
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({super.key, required this.date, required this.time});

  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        Text(
          time,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('d MMMM', 'ru');

  return formatter.format(date);
}
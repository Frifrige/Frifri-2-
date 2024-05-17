import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frifri/src/core/ui_kit/styles/styles.dart';
import 'package:frifri/src/feature/buy_ticket/data/dto/ticket_search_query.dart';
import 'package:frifri/src/feature/buy_ticket/domain/entities/trip_class.dart';
import 'package:frifri/src/feature/buy_ticket/presentation/bloc/true_search_ticket_bloc.dart';
import 'package:frifri/src/feature/buy_ticket/presentation/bloc/true_search_ticket_bloc_events.dart';
import 'package:frifri/src/feature/buy_ticket/presentation/screens/search_ticket_form_screen.dart';
import 'package:frifri/src/feature/buy_ticket/presentation/widgets/cities_inputs/cities_inputs.dart';
import 'package:frifri/src/feature/buy_ticket/presentation/widgets/slider/horizontal_options_slider.dart';
import 'package:frifri/src/feature/buy_ticket/presentation/widgets/ticket_preview_card.dart';

class TicketsSearchResultScreen extends StatefulWidget {
  const TicketsSearchResultScreen({super.key, required this.searchModel});

  final SearchModel searchModel;

  @override
  State<TicketsSearchResultScreen> createState() =>
      _TicketsSearchResultScreenState();
}

class _TicketsSearchResultScreenState extends State<TicketsSearchResultScreen> {
  late final SearchModel _searchModel;
  late final SearchBloc searchBloc;

  @override
  void initState() {
    super.initState();
    _searchModel = widget.searchModel;
    searchBloc = context.read<SearchBloc>();

    TicketsSearchQuery options = TicketsSearchQuery(
      tripClass:
          tripClassToDataString(_searchModel.passengersAndClass!.tripClass),
      passengers: Passengers(
        adults: _searchModel.passengersAndClass!.passengers.adults,
        children: _searchModel.passengersAndClass!.passengers.children,
        infants: 0,
      ),
      segments: [
        Segment(
          origin: _searchModel.departureAt!.code,
          destination: _searchModel.arrivalAt!.code,
          date:
              "${_searchModel.departureDate!.year}-${_searchModel.departureDate!.month.toString().padLeft(2, '0')}-${_searchModel.departureDate!.day.toString().padLeft(2, '0')}",
        ),
      ],
    );

    if (_searchModel.returnDate != null) {
      options.segments.add(
        Segment(
          origin: _searchModel.arrivalAt!.code,
          destination: _searchModel.departureAt!.code,
          date:
              "${_searchModel.returnDate!.year}-${_searchModel.returnDate!.month.toString().padLeft(2, '0')}-${_searchModel.returnDate!.day.toString().padLeft(2, '0')}",
        ),
      );
    }

    searchBloc.add(
      StartSearchTicketEvent(options),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _TicketsSearchResultHeader(),
            _LocationPickerZone(
              searchModel: _searchModel,
            ),
            _ChipsZone(
              searchModel: _searchModel,
            ),
            const _ResultedTicketsList(),
          ],
        ),
      ),
    );
  }
}

class _ResultedTicketsList extends StatelessWidget {
  const _ResultedTicketsList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: tickets[index],
          );
        },
        itemCount: 3,
      ),
    );
  }
}

class _ChipsZone extends StatelessWidget {
  const _ChipsZone({required this.searchModel});

  final SearchModel searchModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 0, 0),
      child: SizedBox(
        height: 40,
        child: HorizontalOptionsSlider(
          searchModel: searchModel,
        ),
      ),
    );
  }
}

class _LocationPickerZone extends StatelessWidget {
  const _LocationPickerZone({required this.searchModel});

  final SearchModel searchModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: CitiesInputs(
        searchModel: searchModel,
        citiesNames: {
          "flyFrom": searchModel.departureAt!.name,
          "flyTo": searchModel.arrivalAt!.name,
        },
      ),
    );
  }
}

class _TicketsSearchResultHeader extends StatelessWidget {
  const _TicketsSearchResultHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
      child: Text(
        AppLocalizations.of(context)!.whereToFly,
        style: AppStyles.textStylePoppins.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

List<TicketPreviewCard> tickets = [
  const TicketPreviewCard(
    isLesserCost: true,
    iconPath: 'assets/icons/utr-logo.png',
    companyName: 'Utair',
    price: 3690,
    time: '12:55 - 06:25',
  ),
  const TicketPreviewCard(
    isLesserCost: false,
    iconPath: 'assets/icons/smartavia-logo.png',
    companyName: 'Smartavia',
    price: 4160,
    time: '10:00 - 03:30',
  ),
  const TicketPreviewCard(
    isLesserCost: false,
    iconPath: 'assets/icons/s7airlines-logo.png',
    companyName: 'S7 Airlines',
    price: 4172,
    time: '17:10 - 02:20',
  ),
];

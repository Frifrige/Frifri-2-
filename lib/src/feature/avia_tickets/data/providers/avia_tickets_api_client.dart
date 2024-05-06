import 'package:dio/dio.dart';
import 'package:frifri/src/feature/avia_tickets/data/models/autocomplete_result.dart';
import 'package:frifri/src/feature/avia_tickets/data/models/ticket_info.dart';
import 'package:frifri/src/feature/avia_tickets/data/models/user_location.dart';
import 'package:retrofit/retrofit.dart';

part 'avia_tickets_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class AviaTicketsApiClient {
  factory AviaTicketsApiClient(Dio dio, {String baseUrl}) =
      _AviaTicketsApiClient;

  /// Method docs:
  /// https://support.travelpayouts.com/hc/en-us/articles/203956163-Travel-insights-with-Aviasales-Data-API#chapter_2
  @GET('/aviasales/v3/get_latest_prices')
  Future<TicketInfoResult> getLatestPrices({
    @Query('currency') String? currency = null,
    @Query('origin') required String originIataCode,
    @Query('destination') String? destinationIataCode = null,
    @Query('beginning_of_period') String? beginningOfPeriod = null,
    @Query('period_type') String? periodType = null,
    @Query('one_way') bool? oneWay = null,
    @Query('page') int? page = null,
    @Query('market') String? market = null,
    @Query('limit') int? limit = null,
    @Query('sorting') String? sorting = null,
    @Query('trip_duration') int? tripDuration = null,
    @Query('trip_class') int? tripClass = null,
  });

  /// Get user's location by ip.
  ///
  /// [locale] is a language code of result
  /// available: in, rue, de, fr, it, pl, th.
  ///
  /// [ip] is a optional user's ip address
  /// if it's not provided the server will try to determine it itself
  @GET('/whereami')
  Future<UserLocation> getUserLocation({
    @Query('locale') String? locale = null,
    @Query('ip') String? ip = null,
  });

  /// Get autocomplete results for [term]
  /// [locale] is a language code of result
  /// [types] is a list of types (airport, city, country)
  @GET('http://autocomplete.travelpayouts.com/places2')
  Future<List<AutocompleteResult>> getAutocomplete({
    @Query('term') required String term,
    @Query('locale') String? locale = null,
    @Query('types') required List<String> types,
    @Query('callback') String? callback = null,
  });
}

/// Returns a string like http://pics.avs.io/width/height/iata.png
/// which leads to the airline logo image
///
/// [size] should be "48/48", "36/36", "32/32" and etc
/// Example:
/// ```dart
/// getAirlineLogoUrl("BA", "48/48");
/// ```
///
/// But not all airlines have logos!
String getAirlineLogoUrl(
  String airlineIataCode,
  String size, {
  bool isRetina = false,
}) {
  return "http://pics.avs.io/$size/$airlineIataCode${isRetina ? "@2x" : ""}.png";
}
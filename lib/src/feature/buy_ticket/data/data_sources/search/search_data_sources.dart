import 'package:dio/dio.dart';
import 'package:frifri/src/core/network/exceptions/nework_exception.dart';
import 'package:frifri/src/feature/buy_ticket/data/DTO/search_tickets_result.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frifri/src/core/network/dio_client.dart';
import 'package:frifri/src/feature/buy_ticket/data/DTO/search_tickets.dart';
import '../../../../../core/helpers/signature/signature_helper.dart';
import '../../../domain/entities/booking_ticket_entity.dart';
import '../../dto/ticket_search_query.dart';

abstract interface class ISearchDataSources {
  /// Main request with params.
  Future<TicketsSearchIdResult> searchTicket(final TicketsSearchQuery options);

  /// Get list companies offers.
  Future<TicketsSearchResultBySearchId> getTicketsBySearchId(
    final String searchId,
  );

  /// Get companies buy ticket link.
  Future<BookingTicketEntity> getABookingLink({
    required String searchId,
    required int termsUrl,
  });
}

final class SearchDataSources
    with Network, Signature
    implements ISearchDataSources {
  @override
  Future<TicketsSearchIdResult> searchTicket(TicketsSearchQuery options) async {
    try {
      String endpoint = "http://api.travelpayouts.com/v1/flight_search";

      final apiKey = dotenv.get("API_KEY");
      final signature = createSignature(options.toJson(), apiKey);

      final allOptions = options.toJson();
      allOptions.addAll(
        {"signature": signature},
      );

      allOptions.removeWhere((key, value) => value == null);

      final response = await dioClient.post(
        endpoint,
        data: allOptions,
      );

      final result = response.data;

      return TicketsSearchIdResult.fromJson(result);
    } on DioException catch (error, stack) {
      Error.throwWithStackTrace(error, stack);
    } on Object catch (error, stack) {
      Error.throwWithStackTrace(error, stack);
    }
  }

  @override
  Future<TicketsSearchResultBySearchId> getTicketsBySearchId(
    String searchId,
  ) async {
    String endpoint = "http://api.travelpayouts.com/v1/flight_search_results";

    final response = await dioClient.get(endpoint, queryParameters: {
      "uuid": searchId,
    });

    final result = response.data;

    return TicketsSearchResultBySearchId.fromJson(result);
  }

  @override
  Future<BookingTicketEntity> getABookingLink({
    required String searchId,
    required int termsUrl,
  }) async {
    try {
      final marker = dotenv.get('API_MARKER');

      final endPoint =
          'http://api.travelpayouts.com/v1/flight_searches/$searchId/clicks/$termsUrl.json';

      final response =
          await dioClient.get(endPoint, queryParameters: {"marker": marker});

      if (response.statusCode == 200) {
        return BookingTicketEntity.fromJson(response.data);
      }

      throw NetworkException(
        message: '${response.statusCode}',
        statusCode: "${response.statusCode}",
      );
    } on Object catch (error, stack) {
      Error.throwWithStackTrace(error, stack);
    }
  }
}

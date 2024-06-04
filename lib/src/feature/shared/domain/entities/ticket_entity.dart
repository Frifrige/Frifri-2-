import 'package:frifri/src/feature/shared/domain/entities/airport_entity.dart';

/// Сущность билета, содержит всю необходимую инфу
/// для отображения как миниатюр, бронирования, подробной информации
class TicketEntity {
  TicketEntity({
    required this.originAirport,
    required this.destinationAirport,
    required this.durationInMinutes,
    required this.segmentsList,
    required this.departureTime,
    required this.arrivalTime,
    required this.formattedPrice,
    required this.price,
    required this.termsUrl,
    required this.searchId,
    required this.isDirect,
  });

  final AirportEntity originAirport;
  final AirportEntity destinationAirport;

  // In [2h 45m] format
  final int durationInMinutes;

  // In [HH:mm] format
  final String departureTime;
  final String arrivalTime;

  final List<SegmentEntity> segmentsList;

  final int price;
  final String formattedPrice;

  final int termsUrl;
  final String searchId;

  final bool isDirect;
}

class SegmentEntity {
  final String airlineLogo;
  final String airlineName;

  final String departureTime;
  final DateTime departureDate;

  final String departureCityName;
  final String departureAirportName;

  final String arrivalTime;
  final DateTime arrivalDate;

  final String arrivalCityName;
  final String arrivalAirportName;

  final int durationInMinutes;

  final int arrivalTimestamp;
  final int departureTimestamp;

  SegmentEntity({
    required this.airlineLogo,
    required this.airlineName,
    required this.departureTime,
    required this.departureDate,
    required this.departureCityName,
    required this.departureAirportName,
    required this.arrivalDate,
    required this.arrivalTime,
    required this.arrivalCityName,
    required this.arrivalAirportName,
    required this.durationInMinutes,
    required this.arrivalTimestamp,
    required this.departureTimestamp,
  });
}
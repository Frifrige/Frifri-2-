import 'package:frifri/src/core/data_base/search_database.dart';
import 'package:frifri/src/feature/buy_ticket/domain/entities/country_search_entity.dart';

abstract interface class IRecentSearchRepo {
  // Future<void> addRecentSearch(CountrySearchEntity countrySearchEntity);
  // Future<List<RecentSearchData>> fetchRecentSearch(String countryCode);

  Future<void> addRecentSearch(CountrySearchEntity countrySearchEntity);
  Future<List<RecentSearchData>> fetchRecentSearch();
  Future<bool> hasRecentSearch(String countryCode);
}
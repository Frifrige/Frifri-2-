import 'package:frifri/src/core/data_base/search_database.dart';
import 'package:frifri/src/module/country_search/domain/entity/country_search_entity.dart';

abstract interface class IRecentSearchRepo {
  Future<void> addRecentSearch(CountrySearchEntity countrySearchEntity);

  Future<List<RecentSearch>> fetchRecentSearch();
}
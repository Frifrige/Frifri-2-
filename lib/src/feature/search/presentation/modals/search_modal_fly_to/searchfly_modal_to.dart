import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frifri/src/core/ui_kit/modals/default_modal.dart';
import 'package:frifri/src/core/ui_kit/styles/styles.dart';
import 'package:frifri/src/feature/search/presentation/modals/search_modal_fly_to/components/emptystring_list.dart';
import 'package:frifri/src/feature/search/presentation/modals/search_modal_fly_to/components/search_is_not_empty.dart';
import 'package:go_router/go_router.dart';

class SearchFlyModalTo extends StatelessWidget {
  const SearchFlyModalTo({
    required this.shortName,
  });

  final shortName;

  @override
  Widget build(BuildContext context) {
    return DefaultModalWrapper(
      child: Column(
        children: [
          SearchFlyModalHeader(shortName: shortName),
          Divider(
            height: 0,
            thickness: 0.5,
          ),
          _SearchFlyModalToContent(shortName: shortName),
        ],
      ),
    );
  }
}

class _SearchFlyModalToContent extends StatefulWidget {
  const _SearchFlyModalToContent({
    required this.shortName,
  });

  final String shortName;

  @override
  State<_SearchFlyModalToContent> createState() =>
      _SearchFlyModalToContentState();
}

class _SearchFlyModalToContentState extends State<_SearchFlyModalToContent> {
  String searchText = '';
  final _controller = TextEditingController();

  late String shortName;

  @override
  void initState() {
    super.initState();
    shortName = widget.shortName;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              onChanged: (text) {
                setState(() {
                  searchText = text;
                  print(searchText);
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                filled: true,
                labelText: 'Поиск аэропорта/города',
                labelStyle: AppStyles.textStylePoppins,
                fillColor: Color(0xFFF1F3F8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: returnContent(),
            )
          ],
        ),
      ),
    );
  }

  Widget returnContent() {
    var filteredAirlines = Map.fromEntries(
      airlinesList.entries.where(
        (entry) {
          return entry.key
              .toLowerCase()
              .contains(searchText.toString().toLowerCase());
        },
      ),
    );

    if (searchText == '') {
      return EmptyStringListTo(
        airlinesList: airlinesList,
      );
    } else if (filteredAirlines.isNotEmpty) {
      return SearchIsNotEmptyList(filteredAirlines: filteredAirlines);
    } else if (filteredAirlines.isEmpty && searchText != '') {
      return Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              _controller.text.toString(),
              style: TextStyle(fontSize: 30),
            ),
            Text('По данному запросу ничего не найдено'),
          ],
        ),
      );
    }

    return Container(
      child: Center(
        child: Text('Ошибка'),
      ),
    );
  }
}

class SearchFlyModalHeader extends StatelessWidget {
  const SearchFlyModalHeader({
    super.key,
    required this.shortName,
  });

  final String shortName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: SvgPicture.asset(
                      "assets/icons/close.svg",
                      height: 21,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 90),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'ОТКУДА',
                              style: AppStyles.textStylePoppins.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black26),
                            ),
                            Text(
                              shortName,
                              style: AppStyles.textStylePoppins.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.asset('assets/icons/searchfly-airplane.svg'),
                        Text(
                          'КУДА',
                          style: AppStyles.textStylePoppins.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

const airlinesList = <String, String>{
  'Батуми': 'BUS',
  'Тбилиси': 'TBS',
  'Кутаиси': 'KUT'
};

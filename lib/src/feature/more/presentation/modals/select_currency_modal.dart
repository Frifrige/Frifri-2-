import 'package:flutter/material.dart';
import 'package:frifri/src/core/ui-kit/buttons/selection_item.dart';

import 'package:frifri/src/feature/more/presentation/modals/base_modal.dart';
import 'package:frifri/src/feature/more/presentation/widgets/rounded_list_container.dart';

class SelectCurrencyModal extends BottomSheetModalBase {
  const SelectCurrencyModal({super.key});

  @override
  Widget build_header(BuildContext context) {
    return DefaultModalHeader(
      centerText: "Валюта",
    );
  }

  @override
  Widget build_content(BuildContext context) {
    return _CurrencySelectionList();
  }
}

class _CurrencySelectionList extends StatelessWidget {
  const _CurrencySelectionList({super.key});

  static const _defaultListDivider = Divider(
    height: 1,
    thickness: 0.5,
    indent: 44,
  );

  @override
  Widget build(BuildContext context) {
    return RoundedListContainer(
      separator: _defaultListDivider,
      children: [
        SelectionItemTile(title: "Доллары"),
        SelectionItemTile(title: "Евро"),
        SelectionItemTile(title: "Лари"),
      ],
    );
  }
}
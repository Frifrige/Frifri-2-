import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frifri/src/core/ui_kit/buttons/confirm_button.dart';
import 'package:frifri/src/core/ui_kit/modals/default_modal.dart';
import 'package:frifri/src/core/ui_kit/modals/default_modal_header.dart';
import 'package:frifri/src/feature/more/domain/language_bloc.dart';
import 'package:frifri/src/feature/more/presentation/widgets/custom_radio_list.dart';
import 'package:frifri/src/feature/more/presentation/widgets/rounded_list_container.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

const _contentPadding = 24.0;
const _defaultListDivider = Divider(
  height: 1,
  thickness: 0.5,
  indent: 44,
);

class SelectLanguageModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultModalWrapper(
      child: Column(
        children: [
          DefaultModalHeader(
            centerText: "Язык",
          ),
          _SelectLanguageModalContent()
        ],
      ),
    );
  }
}

class _SelectLanguageModalContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SelectLanguageModalContentState();
  }
}

class _SelectLanguageModalContentState
    extends State<_SelectLanguageModalContent> {
  late String initialLanguage;
  late String selectedLanguage;
  late bool isConfirmButtonActive;

  @override
  void initState() {
    super.initState();
    initialLanguage = context.read<AppLanguageCubit>().state;
    selectedLanguage = initialLanguage;
    isConfirmButtonActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          RoundedListContainer(
            separator: _defaultListDivider,
            children: [
              CustomRadioListTile(
                value: "ru",
                title: Text("Russian"),
                groupValue: selectedLanguage,
                onChanged: (newValue) {
                  setState(() {
                    selectedLanguage = newValue!;
                    isConfirmButtonActive = selectedLanguage != initialLanguage;
                  });
                },
              ),
              CustomRadioListTile(
                value: "eng",
                title: Text("English"),
                groupValue: selectedLanguage,
                onChanged: (newValue) {
                  setState(() {
                    selectedLanguage = newValue!;
                    isConfirmButtonActive = selectedLanguage != initialLanguage;
                  });
                },
              ),
              CustomRadioListTile(
                value: "geo",
                title: Text("Georgian"),
                groupValue: selectedLanguage,
                onChanged: (newValue) {
                  setState(
                    () {
                      selectedLanguage = newValue!;
                      isConfirmButtonActive =
                          selectedLanguage != initialLanguage;
                    },
                  );
                },
              ),
            ],
          ),
          Spacer(),
          SizedBox(
            width: MediaQuery.sizeOf(context).width - _contentPadding * 2,
            height: 48,
            child: ConfirmationButton(
              child: Text(
                AppLocalizations.of(context)!.confirm,
                style: GoogleFonts.inter(
                  color: Colors.white,
                ),
              ),
              onPressed: isConfirmButtonActive
                  ? () {
                      context
                          .read<AppLanguageCubit>()
                          .selectNewLanguage(selectedLanguage);
                      context.pop();
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frifri/src/feature/direct_flight/presentation/screens/direct_fligths_screen.dart';
import 'package:frifri/src/feature/more/presentation/screens/more_screen.dart';
import 'package:frifri/src/feature/reservation/presentation/screens/reservation_screen.dart';
import 'package:frifri/src/feature/search_ticket/presentation/screens/search_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const _screens = <Widget>[
  AviaTicketScreen(),
  Scaffold(),
  ReservationScreen(),
  MoreScreen(),
  SearchScreen()
];

/// {@template navigation_widget}
/// NavigationWidgetScreen widget.
/// {@endtemplate}
class NavigationWidgetScreen extends StatefulWidget {
  /// {@macro navigation_widget}
  const NavigationWidgetScreen({super.key});

  @override
  State<NavigationWidgetScreen> createState() => _NavigationWidgetScreenState();
}

class _NavigationWidgetScreenState extends State<NavigationWidgetScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          systemNavigationBarColor:
              Theme.of(context).appBarTheme.backgroundColor),
      child: Scaffold(
        body: _screens[currentIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
          child: SafeArea(
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.08,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7387AE).withOpacity(0.12),
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                      spreadRadius: 0,
                    )
                  ]),
              child: Row(
                children: [
                  CustomNavigationBarItem(
                      title: AppLocalizations.of(context)!.avia,
                      assetPath: 'assets/icons/home.svg',
                      activeAssetPath: 'assets/icons/active_home.svg',
                      isActive: identical(0, currentIndex) ? true : false,
                      onPressed: () {
                        setState(() {
                          currentIndex = 0;
                        });
                      }),
                  CustomNavigationBarItem(
                      title: AppLocalizations.of(context)!.hotel,
                      assetPath: 'assets/icons/book-open.svg',
                      activeAssetPath: 'assets/icons/book-open.svg',
                      isActive: identical(7, currentIndex) ? true : false,
                      onPressed: () {
                        setState(() {
                          currentIndex = 1;
                        });
                      }),
                  const SizedBox(width: 60),
                  CustomNavigationBarItem(
                      title: AppLocalizations.of(context)!.service,
                      assetPath: 'assets/icons/fire.svg',
                      activeAssetPath: 'assets/icons/active_fire.svg',
                      isActive: identical(2, currentIndex) ? true : false,
                      onPressed: () {
                        setState(() {
                          currentIndex = 2;
                        });
                      }),
                  CustomNavigationBarItem(
                      title: AppLocalizations.of(context)!.moreFirstUpCase,
                      assetPath: 'assets/icons/more-horizontal.svg',
                      activeAssetPath: 'assets/icons/active_more.svg',
                      isActive: identical(3, currentIndex) ? true : false,
                      onPressed: () {
                        setState(() {
                          currentIndex = 3;
                        });
                      }),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: InkWell(
          onTap: () {
            setState(() {
              currentIndex = 4;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ClipOval(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.07,
                width: MediaQuery.sizeOf(context).width * 0.15,
                child: ColoredBox(
                  color: const Color.fromRGBO(227, 14, 5, 1),
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    heightFactor: 0.5,
                    child: SvgPicture.asset('assets/icons/Search.svg'),
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

/// {@template navigation_widget}
/// CustomNavigationBarItem widget.
/// {@endtemplate}
class CustomNavigationBarItem extends StatelessWidget {
  
  const CustomNavigationBarItem({
    super.key,
    required this.title,
    required this.assetPath,
    required this.onPressed,
    required this.activeAssetPath,
    required this.isActive,
  });

  final String title;
  final String assetPath;
  final String activeAssetPath;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onPressed.call(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(isActive ? activeAssetPath : assetPath),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                title,
                style: isActive
                    ? GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(227, 14, 5, 1),
                      )
                    : GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

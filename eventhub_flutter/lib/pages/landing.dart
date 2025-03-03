import 'package:eventhub_flutter/auth.dart';
import 'package:eventhub_flutter/graphql/graphql.dart';
import 'package:eventhub_flutter/theme/custom_colors.dart';
import 'package:eventhub_flutter/theme/custom_text_styles.dart';
import 'package:eventhub_flutter/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  String gqlTest = """
    query {
      authConnectionTest
    }
  """;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    CustomColors colors = Theme.of(context).customColors(context);
    CustomTextStyles textStyles = Theme.of(context).customTextStyles(context);
    double toolbarHeight = /* screenHeight * .1 < 80 ? 80 : screenHeight * .1 */ 80;
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: colors.background,
      appBar: _appBar(toolbarHeight, textStyles, colors),
      body: SingleChildScrollView(
        child: Column(
            children: [
              _hero(toolbarHeight, colors, screenWidth, screenHeight, textStyles),
              TableCalendar(
                locale: "de_DE",
                firstDay: DateTime.utc(2025, 1, 1),
                lastDay: DateTime.utc(2025, 07, 31),
                focusedDay: _focusedDay,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: colors.whiteText),
                  weekendStyle: TextStyle(color: colors.darkerWhiteText),
                ),
                calendarStyle: CalendarStyle(
                  defaultTextStyle: TextStyle(color: colors.whiteText),
                  weekendTextStyle: TextStyle(color: colors.darkerWhiteText),
                  outsideTextStyle: TextStyle(color: colors.darkerWhiteText),
                  selectedDecoration: BoxDecoration(
                    color: colors.primary,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: colors.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
                calendarFormat: CalendarFormat.month,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: textStyles.displaySmall,
                  leftChevronIcon: Icon(Icons.chevron_left, color: colors.whiteText),
                  rightChevronIcon: Icon(Icons.chevron_right, color: colors.whiteText),
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,

                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              Query(
                options: QueryOptions(
                  document: gql(gqlTest),
                  pollInterval: const Duration(seconds: 10),
                ),
                builder: (QueryResult result, {refetch, fetchMore}) {
                  if (result.hasException) {
                    if (result.exception.toString().contains("AUTH_NOT_AUTHENTICATED")) {
                    return Text('Not authorized', style: textStyles.displaySmall,);
                    }
                    return Text(result.exception.toString());
                  }

                  if (result.isLoading) {
                    return Text('Loading', style: textStyles.displaySmall);
                  }

                  return Text(result.data?['authConnectionTest'] ?? 'No data', style: textStyles.displaySmall);
                  },
              ),
            ],
          ),
        )
    );
  }

  AppBar _appBar(double toolbarHeight, CustomTextStyles textStyles, CustomColors colors) {
    return AppBar(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      toolbarHeight: toolbarHeight,
      title: Row(
        children: [
          SvgPicture.asset(
            'assets/svg/engel-white.svg',
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.5),
            child: Text(
              'EventHub',
              style: textStyles.appBarTitle,
            ),
          ),
        ],
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xC71A1A1A), Color(0x631A1A1A), Colors.transparent],
            stops: [0, .65, 1],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: FilledButton(
            onPressed: () => authenticate(),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(colors.primary),
              foregroundColor: WidgetStateProperty.all(colors.whiteText),
            ),
            child: const Text("Login"),
          ),
        )
      ],
    );
  }

  Container _hero(double toolbarHeight, CustomColors colors, double screenWidth, double screenHeight, CustomTextStyles textStyles)  {
    return Container(
      padding: EdgeInsets.only(top: toolbarHeight),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [colors.primary, colors.gradientInbetween, colors.accent],
          stops: const [.0, .5, 1],
        ),
      ),
      child: Flex(
        direction: screenWidth > 1000 ? Axis.horizontal : Axis.vertical,
        children: [
          SizedBox(
            width: /* screenWidth > 1000 ? screenWidth * .5 :  */screenWidth,
            height: screenWidth * .8 > screenHeight * .6 ? screenHeight * .6 : screenWidth * .8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'IGG EventHub',
                  style: textStyles.displayLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Veranstaltungen am Ignaz',
                  style: textStyles.displayMedium,
                  textAlign: TextAlign.center,
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
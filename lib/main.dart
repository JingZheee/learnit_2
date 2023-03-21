import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learnit_2/Root/home.dart';
import 'package:learnit_2/Root/profile.dart';
import 'package:learnit_2/Root/resources.dart';
import 'package:learnit_2/Root/sessions.dart';
import 'package:learnit_2/Screen/Resources/categories.dart';
import 'package:learnit_2/Screen/Resources/notes.dart';
import 'package:learnit_2/routes/ScafoldWithBottomNavBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final tabs = [
      const ScaffoldWithNavBarTabItem(
        initialLocation: '/home',
        icon: Icon(Icons.home_outlined),
        label: 'Home',
      ),
      const ScaffoldWithNavBarTabItem(
        initialLocation: '/sessions',
        icon: Icon(Icons.calendar_month_outlined),
        label: 'Session',
      ),
      const ScaffoldWithNavBarTabItem(
        initialLocation: '/resources',
        icon: Icon(Icons.sticky_note_2_outlined),
        label: 'Resources',
      ),
      const ScaffoldWithNavBarTabItem(
        initialLocation: '/profile',
        icon: Icon(Icons.person_2_outlined),
        label: 'Profile',
      ),
      
    ];

    final goRouter = GoRouter(
      initialLocation: '/home',
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return ScaffoldWithBottomNavBar(tabs: tabs, child: child);
          },
          routes: [
            //Home page
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const Home(),
                ),
            ),
            //Sessions page
            GoRoute(
              path: '/sessions',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const Sessions(),
                ),
            ),
            //Resources page
            GoRoute(
              path: '/resources',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const Resources(),
                ),
              routes: [
                GoRoute(
                  path: 'categories',
                  builder: (context, state) => const Categories(),
                  routes: [
                    GoRoute(
                      path: 'notes',
                      builder: (context, state) => const Notes(),
                    )
                  ]
                )
              ]
            ),
            //Profile page
            GoRoute(
              path: '/profile',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const Profile(),
                ),
            ),
          ]
        )
      ]
    );

    return MaterialApp.router(
       routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}

class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  /// Constructs an [ScaffoldWithNavBarTabItem].
  const ScaffoldWithNavBarTabItem(
      {required this.initialLocation, required Widget icon, String? label})
      : super(icon: icon, label: label);

  /// The initial location/path
  final String initialLocation;
}


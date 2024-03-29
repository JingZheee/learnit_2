import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learnit_2/Root/home.dart';
import 'package:learnit_2/Root/profile.dart';
import 'package:learnit_2/Root/resources.dart';
import 'package:learnit_2/Root/sessions.dart';
import 'package:learnit_2/Screen/Resources/categories.dart';
import 'package:learnit_2/Screen/Resources/detailed_posting.dart';
import 'package:learnit_2/Screen/Resources/forum.dart';
import 'package:learnit_2/Screen/Resources/notes.dart';
import 'package:learnit_2/Screen/Resources/pages.dart';
import 'package:learnit_2/Screen/Resources/post_question.dart';
import 'package:learnit_2/Screen/Resources/post_resources.dart';
import 'package:learnit_2/routes/ScafoldWithBottomNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          // navigatorKey: _shellNavigatorKey,
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
                      path: 'notes/:subjects',
                      builder: (context, state) =>  Notes(
                        subjects: state.params["subjects"]!
                      ),
                      routes: [
                        GoRoute(
                          path: 'pages',
                          builder: (context, state) => const Pages(),
                        ),
                        GoRoute(
                          path: 'add',
                          builder: (context, state) => const PostResources(),
                        )
                      ]
                    )
                  ]
                ),
                GoRoute(
                  path: 'forum',
                  builder: (context, state) => const Forum(),
                  routes: [
                    GoRoute(
                      path: 'post',
                      builder: (context, state) => const PostQuestion(),
                    ),
                    GoRoute(
                      path: 'comment/:title/:description',
                      builder: (context, state) => DetailedPost(
                        questionTitle: state.params['title']!,
                        questionDescription: state.params['description']!,),
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


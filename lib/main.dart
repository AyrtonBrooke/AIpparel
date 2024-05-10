import 'package:firebase_core/firebase_core.dart';
import 'package:aiapparel/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
import 'data/repositories/authentication/authentication_repository.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform).then(
          (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );

  runApp(const App());
}

//class MyHomePage extends StatefulWidget {
  //const MyHomePage({super.key, required this.title});

  //final String title;

  //@override
  //State<MyHomePage> createState() => _MyHomePageState();
//}

//class _MyHomePageState extends State<MyHomePage> {
/*  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          for (final tabItem in TabNavigationItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue[200],
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.black45,
        onTap: (int index) => setState(() => _currentIndex = index),
        items: [
          for (final tabItem in TabNavigationItem.items)
            BottomNavigationBarItem(
              icon: tabItem.icon,
              label: tabItem.title,
            )
        ],
      ),
    );
  }
}

class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;

  TabNavigationItem({
    required this.page,
    required this.title,
    required this.icon,
  });

  static List<TabNavigationItem> get items => [
    TabNavigationItem(
      page: const HomePage(),
      icon: const Icon(Icons.home),
      title: "Home",
    ),
    TabNavigationItem(
      page: const OutfitsPage(),
      icon: const Icon(Icons.checkroom),
      title: "Outfits",
    ),
    TabNavigationItem(
      page: const WardrobePage(),
      icon: const Icon(Icons.door_sliding),
      title: "Wardrobe",
    ),
    TabNavigationItem(
      page: const SettingsPage(),
      icon: const Icon(Icons.settings),
      title: "Settings",
    ),
  ];
}*/

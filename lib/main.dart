import 'package:almacen_sharedprf/presentation/pages/user_page.dart';
import 'package:almacen_sharedprf/presentation/providers/provider.dart';
import 'package:almacen_sharedprf/presentation/providers/user_simple_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePrefereneces.init();
  runApp(ProviderScope(child: MyApp()));
} 

// ignore: use_key_in_widget_constructors
class MyApp extends ConsumerWidget {
  final String title = "Shared Preferences Example";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkTheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: isDarkMode ? ThemeData.dark() : ThemeData(
        scaffoldBackgroundColor: const Color(0xff8c52ff),
        unselectedWidgetColor: Colors.deepPurple.shade200,
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(Colors.white),
        ),
        colorScheme: const ColorScheme.dark()
            .copyWith(secondary: Colors.lightGreen.shade400),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Shared Preferences'),
        ),
        body: const UserPage(),
      ),
    );
  }
}

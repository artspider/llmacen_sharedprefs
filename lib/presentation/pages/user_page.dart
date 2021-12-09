import 'package:almacen_sharedprf/presentation/providers/provider.dart';
import 'package:almacen_sharedprf/presentation/providers/user_simple_preferences.dart';
import 'package:almacen_sharedprf/presentation/widgets/birthday_widget.dart';
import 'package:almacen_sharedprf/presentation/widgets/button_widget.dart';
import 'package:almacen_sharedprf/presentation/widgets/pets_buttons_widget.dart';
import 'package:almacen_sharedprf/presentation/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPage extends ConsumerStatefulWidget {
  final String idUser = "1";

  const UserPage({
    Key? key,
    idUser,
  }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
  final formKey = GlobalKey<FormState>();
  String name = '';
  late DateTime birthday;
  List<String> pets = [];
  bool mode = false;

  @override
  void initState() {
    super.initState();
    /* name = "";
    birthday = DateTime.now();
    pets = []; */
    name = UserSimplePrefereneces.getUsername() ?? "";
    birthday = UserSimplePrefereneces.getBirthday() ?? DateTime.now();
    pets = UserSimplePrefereneces.getPets() ?? [];
    mode = UserSimplePrefereneces.getMode() ?? false;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const TitleWidget(
                  icon: Icons.save_alt, text: 'Shared\nPreferences'),
              const SizedBox(height: 32),
              buildName(),
              const SizedBox(height: 12),
              buildBirthday(),
              const SizedBox(height: 12),
              buildPets(),
              const SizedBox(height: 12),
              buildSwitch(),
              const SizedBox(height: 32),
              buildButton(),
            ],
          ),
        ),
      );

  Widget buildName() => buildTitle(
        title: 'Name',
        child: TextFormField(
          initialValue: name,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Your Name',
          ),
          onChanged: (name) => setState(() => this.name = name),
        ),
      );

  Widget buildBirthday() => buildTitle(
        title: 'Birthday',
        child: BirthdayWidget(
          birthday: birthday,
          onChangedBirthday: (birthday) =>
              setState(() => this.birthday = birthday),
        ),
      );

  Widget buildPets() => buildTitle(
        title: 'Pets',
        child: PetsButtonsWidget(
          pets: pets,
          onSelectedPet: (pet) => setState(
              () => pets.contains(pet) ? pets.remove(pet) : pets.add(pet)),
        ),
      );

  Widget buildButton() => ButtonWidget(
      text: 'Save',
      onClicked: () async {
        await UserSimplePrefereneces.setUsername(username:name);
        await UserSimplePrefereneces.setBirthday(birthday);
        await UserSimplePrefereneces.setPets(pets);
        await UserSimplePrefereneces.setMode(mode);
      });

  Widget buildTitle({
    required String title,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          child,
        ],
      );

  Widget buildSwitch() => buildTitle(
      title: "DarkMode: ",
      child: Switch.adaptive(
          value: mode,
          onChanged: (value) => setState(() {
                ref.read(darkTheme.state).state = value;
                mode = value;
              })));
}

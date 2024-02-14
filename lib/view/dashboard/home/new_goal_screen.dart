import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/view/dashboard/home/new_task_screen.dart';

class NewGoalScreen extends StatefulWidget {
  const NewGoalScreen({super.key});

  @override
  State<NewGoalScreen> createState() => _NewGoalScreenState();
}

class _NewGoalScreenState extends State<NewGoalScreen> {
  late Color screenPickerColor; // Color for picker shown in Card on the screen.
  late Color dialogPickerColor; // Color for picker in dialog using onChanged
  late Color dialogSelectColor; // Color for picker using color select dialog.
  late bool isDark;

  // Define some custom colors for the custom picker segment.
  // The 'guide' color values are from
  // https://material.io/design/color/the-color-system.html#color-theme-creation
  // static const Color guidePrimary = Color(0xFF6200EE);
  // static const Color guidePrimaryVariant = Color(0xFF3700B3);
  // static const Color guideSecondary = Color(0xFF03DAC6);
  // static const Color guideSecondaryVariant = Color(0xFF018786);
  // static const Color guideError = Color(0xFFB00020);
  // static const Color guideErrorDark = Color(0xFFCF6679);
  // static const Color blueBlues = Color(0xFF174378);

  // Make a custom ColorSwatch to name map from the above custom colors.
  // final Map<ColorSwatch<Object>, String> colorsNameMap =
  //     <ColorSwatch<Object>, String>{
  //   ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
  //   ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
  //   ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
  //   ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
  //   ColorTools.createPrimarySwatch(guideError): 'Guide Error',
  //   ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
  //   ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  // };

  @override
  void initState() {
    screenPickerColor = Colors.blue;
    // dialogPickerColor = Colors.red;
    // dialogSelectColor = const Color(0xFFA239CA);
    isDark = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Goal',
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w800),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Text(
              'save',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                SizedBox(
                  width: size.width * 0.9,
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        // borderSide: const BorderSide(color: Colors.yellowAccent)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        // borderSide: const BorderSide(color: Colors.yellowAccent),
                      ),
                      hintText: 'Goal Name',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: size.width * 0.9,
                  child: TextField(
                    maxLines: 10,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        // borderSide: const BorderSide(color: Colors.yellowAccent)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        // borderSide: const BorderSide(color: Colors.yellowAccent),
                      ),
                      hintText: 'Description',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Tasks',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                // Add task
                SizedBox(
                  width: size.width * 0.9,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NewTaskScreen()),
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 36, 99, 128),
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        'Add Tasks',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Choose Color',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: size.width * 0.5,
                  height: 100,
                  child: ColorPicker(
                    enableShadesSelection: false,

                    // Use the screenPickerColor as start color.
                    color: screenPickerColor,
                    // Update the screenPickerColor using the callback.
                    onColorChanged: (Color color) =>
                        setState(() => screenPickerColor = color),
                    width: 44,
                    height: 44,
                    borderRadius: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool state = false, isAddLink = false;
  List<Goal> list = [
    const Goal('Developer', Icons.developer_mode),
    const Goal('Designer', Icons.design_services),
    const Goal('Consultant', Icons.account_balance),
    const Goal('Student', Icons.school),
  ];

  @override
  void initState() {
    isAddLink = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Task',
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
              const Text(
                'Day/Time',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: size.width * 0.9,
                child: Row(
                  children: [
                    CupertinoSwitch(
                      value: state,
                      onChanged: (value) {
                        state = value;
                        setState(() {});
                      },
                      thumbColor: CupertinoColors.white,
                      activeColor: CupertinoColors.systemGrey,
                      trackColor: CupertinoColors.systemGrey,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'all day',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width * 0.9,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        const Text(
                          'Beginning',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.grey[400],
                          size: 30,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width * 0.9,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        const Text(
                          'End',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.grey[400],
                          size: 30,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Goal',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width * 0.9,
                child: CustomDropdown<Goal>.search(
                  decoration: CustomDropdownDecoration(
                      closedBorder: Border.all(color: Colors.grey),
                      closedBorderRadius: BorderRadius.circular(12)),
                  hintText: 'Choose goal',
                  items: list,
                  excludeSelected: false,
                  onChanged: (value) {
                    debugPrint('changing value to: $value');
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width * 0.9,
                child: Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        'Create new goal',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 36, 99, 128),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Add link
              SizedBox(
                width: size.width * 0.9,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isAddLink = true;
                        });
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
                      'links',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: isAddLink ? true : false,
                child: SizedBox(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Goal with CustomDropdownListFilter {
  final String name;
  final IconData icon;
  const Goal(this.name, this.icon);

  @override
  String toString() {
    return name;
  }

  @override
  bool filter(String query) {
    return name.toLowerCase().contains(query.toLowerCase());
  }
}

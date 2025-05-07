import 'package:flutter/material.dart';
import 'package:task_buddy/utils/app_textStyles.dart';
import 'package:task_buddy/widgets/topTitlebar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<String> topTitles = ['My tasks', 'Projects', 'Notes'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          leading: IconButton(
            onPressed: () {},
            icon: Image.asset('assets/images/menu.png'),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: (Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    //color: Colors.red,
                    border: Border.all(color: Colors.grey, width: 1.0),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/profile.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                )))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 23.0, left: 16.0, right: 16.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: 'Hello, ',
                      style: AppTextStyle.h2
                          .copyWith(color: Theme.of(context).primaryColor)),
                  TextSpan(
                      text: 'John !',
                      style: AppTextStyle.h1
                          .copyWith(color: Theme.of(context).primaryColor))
                ])),
                Text(
                  'Have a nice day !',
                  style: AppTextStyle.h3
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(
                        topTitles.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: TopTitleBar(
                                title: topTitles[index],
                                isSelected: selectedIndex == index),
                          );
                        },
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}

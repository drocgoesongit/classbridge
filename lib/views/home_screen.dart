import 'package:classbridge/views/subjects_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
            title: const Row(
          children: [
            Icon(Icons.school_rounded, size: 28),
            SizedBox(width: 10),
            Text(
              'ClassBridge',
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ],
        )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Expanded(child: MetricCard(title: 'Students', value: '50')),
                    Expanded(child: MetricCard(title: 'Subjects', value: '10')),
                    Expanded(child: MetricCard(title: 'Tests', value: '5')),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Parents Replies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListTile(
                  visualDensity: VisualDensity.compact,
                  leading: CircleAvatar(
                    radius: 15,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text('Reply 1'),
                  subtitle: Text('Details about reply 1'),
                ),
                ListTile(
                  visualDensity: VisualDensity.compact,
                  leading: CircleAvatar(
                    radius: 15,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text('Announcement 2'),
                  subtitle: Text('Details about announcement 2'),
                ),
                ListTile(
                  visualDensity: VisualDensity.compact,
                  leading: CircleAvatar(
                    radius: 15,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text('Announcement 3'),
                  subtitle: Text('Details about announcement 3'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Actions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    ActionCard(
                      title: 'Subjects',
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubjectsScreen()));
                      },
                    ),
                    ActionCard(
                      title: 'Tests',
                      ontap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  final String title;
  final String value;

  const MetricCard({required this.title, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  final String title;
  final VoidCallback ontap;

  ActionCard({required this.title, Key? key, required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: ontap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

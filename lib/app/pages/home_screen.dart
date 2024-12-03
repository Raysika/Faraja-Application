import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Adjust alignment
                  children: [
                    Text(
                      "Hey, 👋",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert), // Ellipsis icon
                      onSelected: (String value) {
                        if (value == "logout") {
                          // Handle logout logic here
                          debugPrint("User chose to log out");
                          // Example: Navigate to login screen or clear session
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem<String>(
                          value: "logout",
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                              ),
                              SizedBox(width: 8.0),
                              Text("Log Out"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "Eugene Mwangi",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: Constants.SPACING),
                Text(
                  DateFormat("EEEE, MMMM dd").format(DateTime.now()),
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Below are articles suggested for you",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: Constants.SPACING),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search for articles...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (value) {
                    //handling search queries
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final Uri dialerUri = Uri(
            scheme: "tel",
            path: "+254703 037 000", // Red Cross help line  
          );

          if (await canLaunchUrl(dialerUri)) {
            await launchUrl(dialerUri);
          }
          else {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Text("Sorry we are currently unable to open dialer"),
            //   ),
            // );
            debugPrint("Unable to open dialer");
          }
        },
        backgroundColor: theme.colorScheme.primaryContainer,
        foregroundColor: theme.colorScheme.onPrimaryContainer,
        child: const Icon(Icons.phone),
      ),
    );
  }
}

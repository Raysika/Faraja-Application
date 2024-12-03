// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class BlinkingHotline extends StatefulWidget {
//   const BlinkingHotline({super.key});

//   @override
//   State<BlinkingHotline> createState() => _BlinkingHotlineState();
// }

// class _BlinkingHotlineState extends State<BlinkingHotline>
//     with SingleTickerProviderStateMixin {
//       late AnimationController _controller;
//       late Animation<double> _animation;

//     @override
//     void initState() {
//       super.initState();
//       _controller = AnimationController(
//         duration: const Duration(seconds: 1),
//         vsync: this,
//       )..repeat(reverse: true);

//       _animation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
//     }

//     @override
//     void dispose() {
//       _controller.dispose();
//       super.dispose();
//     }

//     Future<void> _launchDialer(String phoneNumber) async {
//       final Uri url = Uri(scheme: 'tel', path: phoneNumber);
//       if (await canLaunchUrl(url)) {
//         await launchUrl(url);
//       }
//       else {
//         debugPrint("Could not launch dialer for $phoneNumber");
//       }
//     }

//   @override
//   Widget build(BuildContext context) {
//     var theme = Theme.of(context);
//     return GestureDetector(
//       onTap: () => _launchDialer('0703 037 000'),
//       child: FadeTransition(
//         opacity: _animation,
//         child: Text(
//           "Hotline Number",
//           style: theme.textTheme.bodyLarge?.copyWith(
//             color: theme.colorScheme.primary,
//             decoration: TextDecoration.underline,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

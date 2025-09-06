import 'package:farmers_admin/constants/constants.dart';
import 'package:farmers_admin/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Container(
      color: Theme.of(context).extension<AppColors>()!.brandColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Spacer(),
            if (currentUser != null)
              Row(
                children: [
                  Text(
                    currentUser.email ?? 'Authenticated',
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.black),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      // The AuthWrapper will handle navigation
                    },
                    tooltip: 'Logout',
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}

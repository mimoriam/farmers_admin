import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // On very narrow screens, we might want to simplify even more,
        // but for now, we'll focus on hiding the name.
        bool isNarrow = constraints.maxWidth < 500;

        return Row(
          children: [
            // This spacer will push the icons to the right
            const Spacer(),

            // Notification Icon with a badge
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none_outlined, color: Colors.grey),
                  onPressed: () {},
                  splashRadius: 20,
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(minWidth: 8, minHeight: 8),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            // Email Icon
            IconButton(
              icon: const Icon(Icons.email_outlined, color: Colors.grey),
              onPressed: () {},
              splashRadius: 20,
            ),
            const SizedBox(width: 16),
            // User Profile Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.blueGrey,
                    child: Text('DA', style: TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                  // Conditionally show the name based on screen width
                  if (!isNarrow) ...[
                    const SizedBox(width: 8),
                    Text(
                      'Derek Alvarado',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                  const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

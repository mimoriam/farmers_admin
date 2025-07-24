import 'package:farmers_admin/constants/constants.dart' as appColors;
import 'package:farmers_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class ContentPage extends StatelessWidget {
  final String title;
  const ContentPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.headlineMedium);
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  // Helper method to build the top header, now fully responsive
  Widget _buildHeader(BuildContext context) {
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
                    constraints: const BoxConstraints(
                      minWidth: 8,
                      minHeight: 8,
                    ),
                  ),
                )
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: Colors.black),
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

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // This is the new responsive header
          _buildHeader(context),
          const SizedBox(height: 30),

          Text(
            'Dashboard',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Dashboard / Customers\' List',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 30),
          // Responsive Summary Cards
          LayoutBuilder(
            builder: (context, constraints) {
              const double breakpoint = 900.0;

              final List<Widget> cards = [
                SummaryCard(
                  title: 'Views',
                  value: '721K',
                  percentage: '+11.01%',
                  isPositive: true,
                  backgroundColor: appColors.cardBackgroundColor!,
                ),
                SummaryCard(
                  title: 'Visits',
                  value: '367K',
                  percentage: '-0.03%',
                  isPositive: false,
                  backgroundColor: appColors.cardBackgroundColor2!,
                ),
                SummaryCard(
                  title: 'New Users',
                  value: '1,156',
                  percentage: '+15.03%',
                  isPositive: true,
                  backgroundColor: appColors.cardBackgroundColor!,
                ),
                SummaryCard(
                  title: 'Active Users',
                  value: '239K',
                  percentage: '+6.08%',
                  isPositive: true,
                  backgroundColor: appColors.cardBackgroundColor2!,
                ),
              ];

              if (constraints.maxWidth < breakpoint) {
                return Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: cards,
                );
              } else {
                return Row(
                  children: cards.map((card) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: card,
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
          const SizedBox(height: 30),
          Text(
            'Pending Requests',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          const Expanded(child: RequestsGrid()),
        ],
      ),
    );
  }
}
// --- Summary Card Widget ---
class SummaryCard extends StatelessWidget {
  final String title, value, percentage;
  final bool isPositive;
  final Color backgroundColor;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.isPositive,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color percentageColor = isPositive ? Colors.green : Colors.red;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: backgroundColor,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  percentage,
                  style: TextStyle(color: percentageColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class RequestsGrid extends StatefulWidget {
  const RequestsGrid({super.key});

  @override
  State<RequestsGrid> createState() => _RequestsGridState();
}

class _RequestsGridState extends State<RequestsGrid> {
  late final PlutoGridStateManager stateManager;

  final TextEditingController _pageController = TextEditingController();

  @override
  void dispose() {
    // Important to dispose of the controller to prevent memory leaks
    _pageController.dispose();
    super.dispose();
  }

  // I've increased the row count to 50 to demonstrate pagination.
  final List<PlutoRow> rows = List.generate(50, (index) {
    final id = index + 1;
    final status = id % 3 == 0 ? 'Blocked' : 'Approved';
    return PlutoRow(cells: {
      'id': PlutoCell(value: id),
      'name': PlutoCell(value: 'User Name $id'),
      'email': PlutoCell(value: 'user$id@example.com'),
      'dob': PlutoCell(value: '01/01/1990'),
      'status': PlutoCell(value: status),
      'actions': PlutoCell(value: ''),
    });
  });

  final List<PlutoColumn> columns = [
    PlutoColumn(
      title: '#',
      field: 'id',
      type: PlutoColumnType.number(),
      width: 80,
      enableSorting: false,
    ),
    PlutoColumn(title: 'Full Name', field: 'name', type: PlutoColumnType.text()),
    PlutoColumn(title: 'E-Mail', field: 'email', type: PlutoColumnType.text()),
    PlutoColumn(
      title: 'Date of Birth',
      field: 'dob',
      type: PlutoColumnType.date(format: 'MM/dd/yyyy'),
    ),
    PlutoColumn(
      title: 'Status',
      field: 'status',
      type: PlutoColumnType.text(),
      minWidth: 115,
      renderer: (rendererContext) {
        Color statusColor = rendererContext.cell.value == 'Approved' ? Colors.green : Colors.grey;
        return Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                rendererContext.cell.value,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        );
      },
    ),
    PlutoColumn(
      title: 'Actions',
      field: 'actions',
      type: PlutoColumnType.text(),
      width: 100,
      minWidth: 50,
      enableSorting: false,
      renderer: (rendererContext) {
        return Wrap(
          alignment: WrapAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 20),
              onPressed: () {},
              splashRadius: 20,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              constraints: const BoxConstraints(),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              onPressed: () {},
              splashRadius: 20,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              constraints: const BoxConstraints(),
            ),
          ],
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PlutoGrid(
            columns: columns,
            rows: rows,
            onLoaded: (PlutoGridOnLoadedEvent event) {
              stateManager = event.stateManager;
              stateManager.setPageSize(10, notify: false); // Set page size
            },
            configuration: PlutoGridConfiguration(
              columnSize: const PlutoGridColumnSizeConfig(
                autoSizeMode: PlutoAutoSizeMode.scale,
                resizeMode: PlutoResizeMode.pushAndPull,
              ),
              style: PlutoGridStyleConfig(
                gridBorderColor: Colors.transparent,
                borderColor: Colors.grey[300]!,
                rowColor: Colors.white,
                columnTextStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            createFooter: (stateManager) {
              stateManager.setPageSize(10, notify: false);
              return PlutoPagination(stateManager);
            },
          ),
        ),
      ],
    );
  }
}
class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardContent(),
    ContentPage(title: 'Customers'),
    ContentPage(title: 'Analytics'),
    ContentPage(title: 'Posts'),
    ContentPage(title: 'Messages'),
    ContentPage(title: 'Settings'),
    ContentPage(title: 'Help Centre'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // The sidebar is now a permanent part of the layout.
          SideMenu(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
          // The main content area expands to fill the remaining space.
          Expanded(child: Center(child: _widgetOptions.elementAt(_selectedIndex))),
        ],
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  const SideMenu({super.key, required this.selectedIndex, required this.onItemTapped});

  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  @override
  Widget build(BuildContext context) {
    // Retrieve the custom colors from the theme.
    final appColors = Theme.of(context).extension<AppColors>()!;

    // We use a SizedBox to give the sidebar a fixed width.
    return SizedBox(
      width: 230, // Set the width of the sidebar
      // The child is the original container with the menu items.
      child: Container(
        // Color is now from the theme.
        color: appColors.sidebarBackground,
        // A ListView ensures the content is scrollable if it exceeds screen height.
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            // 1. Brand Title
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 20.0, bottom: 30.0, start: 5),
              child: Text(
                'Brand.',
                style: TextStyle(
                  // Color is now from the theme.
                  color: appColors.brandColor,
                  fontSize: 28,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // 2. Navigation Items - now dynamic
            _buildMenuItem(
              context: context,
              icon: Icons.home_rounded,
              text: 'DASHBOARD',
              isActive: selectedIndex == 0,
              onTap: () => onItemTapped(0),
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.people_outline_rounded,
              text: 'CUSTOMERS',
              isActive: selectedIndex == 1,
              onTap: () => onItemTapped(1),
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.analytics_outlined,
              text: 'ANALYTICS',
              isActive: selectedIndex == 2,
              onTap: () => onItemTapped(2),
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.access_time_rounded,
              text: 'POSTS',
              isActive: selectedIndex == 3,
              onTap: () => onItemTapped(3),
            ),

            // A spacer between the two sections.
            const SizedBox(height: 40),

            // 3. Settings Section Title
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 12.0, bottom: 10.0),
              child: Text(
                'SETTINGS',
                style: TextStyle(
                  // Color is now from the theme.
                  color: appColors.settingsHeaderText,
                  fontSize: 16,
                  letterSpacing: 2.0,
                ),
              ),
            ),

            // 4. Settings Items - now dynamic
            _buildMenuItem(
              context: context,
              icon: Icons.email_outlined,
              text: 'MESSAGES',
              isActive: selectedIndex == 4,
              onTap: () => onItemTapped(4),
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.settings_outlined,
              text: 'SETTINGS',
              isActive: selectedIndex == 5,
              onTap: () => onItemTapped(5),
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.help_outline_rounded,
              text: 'HELP CENTRE',
              isActive: selectedIndex == 6,
              onTap: () => onItemTapped(6),
            ),
          ],
        ),
      ),
    );
  }

  /// A helper method to build menu items, promoting code reuse.
  /// It handles the styling for both active and inactive states.
  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String text,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final color = isActive ? appColors.brandColor : appColors.inactiveMenuText;
    final backgroundColor = isActive ? appColors.activeMenuBackground : Colors.transparent;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            letterSpacing: 0.5,
            fontSize: 14,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

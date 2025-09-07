import 'package:farmers_admin/common/app_header.dart';
import 'package:farmers_admin/constants/constants.dart' as appColors;
import 'package:farmers_admin/main.dart';
import 'package:farmers_admin/screens/post_management/post_management_screen.dart';
import 'package:farmers_admin/screens/user_management/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // This is the new responsive header
            AppHeader(),
            const SizedBox(height: 30),

            Text(
              'Dashboard',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
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
                    title: 'Total Users',
                    value: '721K',
                    percentage: '+11.01%',
                    isPositive: true,
                    backgroundColor: appColors.cardBackgroundColor!,
                  ),
                  SummaryCard(
                    title: 'Active Users',
                    value: '367K',
                    percentage: '-0.03%',
                    isPositive: false,
                    backgroundColor: appColors.cardBackgroundColor2!,
                  ),
                  SummaryCard(
                    title: 'Total Posts',
                    value: '1,156',
                    percentage: '+15.03%',
                    isPositive: true,
                    backgroundColor: appColors.cardBackgroundColor!,
                  ),
                  SummaryCard(
                    title: 'Pending Posts',
                    value: '239K',
                    percentage: '+6.08%',
                    isPositive: true,
                    backgroundColor: appColors.cardBackgroundColor2!,
                  ),
                ];

                if (constraints.maxWidth < breakpoint) {
                  return Wrap(spacing: 20.0, runSpacing: 20.0, children: cards);
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
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            // const Expanded(child: RequestsGrid()),
            const SizedBox(
              height: 520, // A fixed height for the grid
              child: RequestsGrid(),
            ),
          ],
        ),
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
    return PlutoRow(
      cells: {
        'id': PlutoCell(value: id),
        'name': PlutoCell(value: 'User Name $id'),
        'email': PlutoCell(value: 'user$id@example.com'),
        'dob': PlutoCell(value: '01/01/1990'),
        'status': PlutoCell(value: status),
        'actions': PlutoCell(value: ''),
      },
    );
  });

  late final List<PlutoColumn> columns;

  void showDeleteConfirmationDialog(String postId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.priority_high_rounded, color: Colors.red, size: 40),
              ),
              SizedBox(height: 20),
              Text(
                "Warning",
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                "Are you sure you want to delete?",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.cancel_outlined, color: Colors.red),
                      label: Text("Cancel", style: TextStyle(color: Colors.red)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.delete_outline, color: Colors.white),
                      label: Text("Delete", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () async {
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }

                        if (mounted) {
                          setState(() {}); // Refresh the list
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    // 2. Initialize the list inside initState where 'this' is available.
    columns = [
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
        width: 150,
        minWidth: 150,
        enableSorting: false,
        renderer: (rendererContext) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                // This call is now valid!
                onPressed: () {
                  showDeleteConfirmationDialog("1");
                },
                splashRadius: 20,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                constraints: const BoxConstraints(),
              ),
            ],
          );
        },
      ),
    ];
  }

  // List<PlutoColumn> columns = [
  //   PlutoColumn(
  //     title: '#',
  //     field: 'id',
  //     type: PlutoColumnType.number(),
  //     width: 80,
  //     enableSorting: false,
  //   ),
  //   PlutoColumn(title: 'Full Name', field: 'name', type: PlutoColumnType.text()),
  //   PlutoColumn(title: 'E-Mail', field: 'email', type: PlutoColumnType.text()),
  //   PlutoColumn(
  //     title: 'Date of Birth',
  //     field: 'dob',
  //     type: PlutoColumnType.date(format: 'MM/dd/yyyy'),
  //   ),
  //   PlutoColumn(
  //     title: 'Status',
  //     field: 'status',
  //     type: PlutoColumnType.text(),
  //     minWidth: 115,
  //     renderer: (rendererContext) {
  //       Color statusColor = rendererContext.cell.value == 'Approved' ? Colors.green : Colors.grey;
  //       return Row(
  //         children: [
  //           Container(
  //             width: 8,
  //             height: 8,
  //             decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
  //           ),
  //           const SizedBox(width: 8),
  //           Expanded(
  //             child: Text(rendererContext.cell.value, overflow: TextOverflow.ellipsis, maxLines: 1),
  //           ),
  //         ],
  //       );
  //     },
  //   ),
  //   PlutoColumn(
  //     title: 'Actions',
  //     field: 'actions',
  //     type: PlutoColumnType.text(),
  //     width: 150,
  //     minWidth: 150,
  //     enableSorting: false,
  //     renderer: (rendererContext) {
  //       return Row(
  //         // alignment: WrapAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           IconButton(
  //             icon: const Icon(Icons.edit_outlined, size: 20),
  //             onPressed: () {},
  //             splashRadius: 20,
  //             padding: const EdgeInsets.symmetric(horizontal: 4),
  //             constraints: const BoxConstraints(),
  //           ),
  //           IconButton(
  //             icon: const Icon(Icons.delete_outline, size: 20),
  //             onPressed: () {
  //               showDeleteConfirmationDialog("1");
  //             },
  //             splashRadius: 20,
  //             padding: const EdgeInsets.symmetric(horizontal: 4),
  //             constraints: const BoxConstraints(),
  //           ),
  //         ],
  //       );
  //     },
  //   ),
  // ];

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
              stateManager.setPageSize(9, notify: false); // Set page size
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
              stateManager.setPageSize(9, notify: false);
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
    // UserManagementScreen(),
    UserScreen(),
    PostManagementScreen(),
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
              // child: Text(
              //   'Brand.',
              //   style: TextStyle(
              //     // Color is now from the theme.
              //     color: appColors.brandColor,
              //     fontSize: 28,
              //     // fontWeight: FontWeight.bold,
              //   ),
              // ),
              child: Column(
                children: [
                  ClipRRect(
                    child: SvgPicture.asset(
                      "images/splash_green_2.svg",
                      semanticsLabel: "Your crop icon",
                      width: 140,
                      height: 140,
                    ),
                  ),

                  // Text(
                  //   'Your Crop',
                  //   style: TextStyle(
                  //     // Color is now from the theme.
                  //     color: appColors.brandColor,
                  //     fontSize: 26,
                  //     // fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
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
              icon: Icons.access_time_rounded,
              text: 'POSTS',
              isActive: selectedIndex == 2,
              onTap: () => onItemTapped(2),
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
              isActive: selectedIndex == 3,
              onTap: () => onItemTapped(3),
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.settings_outlined,
              text: 'SETTINGS',
              isActive: selectedIndex == 4,
              onTap: () => onItemTapped(4),
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.help_outline_rounded,
              text: 'HELP CENTRE',
              isActive: selectedIndex == 5,
              onTap: () => onItemTapped(5),
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

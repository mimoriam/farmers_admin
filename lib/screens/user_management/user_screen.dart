import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../add_user/edit_user_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late final PlutoGridStateManager stateManager;

  List<PlutoColumn> _getColumns(BuildContext context) {
    return [
      PlutoColumn(title: 'Full Name', field: 'fullName', type: PlutoColumnType.text()),
      PlutoColumn(title: 'Email', field: 'email', type: PlutoColumnType.text()),
      PlutoColumn(title: 'Date of Birth', field: 'dob', type: PlutoColumnType.text()),
      PlutoColumn(
        title: 'ID',
        field: 'status',
        type: PlutoColumnType.text(),
        renderer: (rendererContext) {
          final String status = rendererContext.cell.value.toString();
          final bool isActive = status.toLowerCase() == 'active';
          return Center(
            child: Text(status, style: const TextStyle(color: Colors.black, fontSize: 12)),
          );
        },
      ),
      PlutoColumn(
        title: 'Actions',
        field: 'actions',
        type: PlutoColumnType.text(),
        width: 80,
        enableFilterMenuItem: false,
        enableSorting: false,
        renderer: (rendererContext) {
          return IconButton(
            icon: const Icon(Icons.edit_note_outlined),
            onPressed: () {
              final userMap = rendererContext.row.cells['userData']?.value;
              if (userMap != null && userMap is Map) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditUserScreen(user: userMap)),
                );
              }
            },
          );
        },
      ),
      PlutoColumn(title: 'User Data', field: 'userData', type: PlutoColumnType.text(), hide: true),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customers')),
      body: StreamBuilder<DatabaseEvent>(
        stream: FirebaseDatabase.instance.ref('UsersAuthData').onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData ||
              !snapshot.data!.snapshot.exists ||
              snapshot.data!.snapshot.value == null) {
            return const Center(child: Text('No users found.'));
          }

          final List<PlutoRow> rows = [];
          // Safely cast the data from Firebase
          final data = snapshot.data!.snapshot.value;
          final usersData = Map<String, dynamic>.from(data as Map);

          print(usersData);

          usersData.forEach((key, value) {
            // Ensure each user's data is also treated as a map
            final userData = Map<String, dynamic>.from(value as Map);
            // IMPORTANT: Add the user's unique ID (the key) to their data map
            userData['uid'] = key;

            rows.add(
              PlutoRow(
                cells: {
                  'fullName': PlutoCell(value: userData['userName'] ?? 'N/A'),
                  'email': PlutoCell(value: userData['userMail'] ?? 'N/A'),
                  'dob': PlutoCell(value: userData['userContact'] ?? 'N/A'),
                  'status': PlutoCell(value: userData['userId'] ?? 'inactive'),
                  'actions': PlutoCell(value: ''),
                  'userData': PlutoCell(value: userData), // Pass the whole map with the UID
                },
              ),
            );
          });

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: PlutoGrid(
              columns: _getColumns(context),
              rows: rows,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                stateManager = event.stateManager;
                stateManager.setShowColumnFilter(true);
              },
              configuration: const PlutoGridConfiguration(
                style: PlutoGridStyleConfig(
                  gridBorderRadius: BorderRadius.all(Radius.circular(8)),
                  rowHeight: 45,
                  columnTextStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

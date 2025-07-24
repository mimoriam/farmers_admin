import 'package:farmers_admin/common/app_header.dart';
import 'package:farmers_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../constants/constants.dart' as appColors;

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  late final PlutoGridStateManager stateManager;

  final List<PlutoRow> rows = [
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 1),
        'name': PlutoCell(value: 'Alyvia Kelley'),
        'email': PlutoCell(value: 'a.kelley@gmail.com'),
        'dob': PlutoCell(value: '06/18/1978'),
        'status': PlutoCell(value: 'Active'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 2),
        'name': PlutoCell(value: 'Jaiden Nixon'),
        'email': PlutoCell(value: 'jaiden.n@gmail.com'),
        'dob': PlutoCell(value: '09/30/1963'),
        'status': PlutoCell(value: 'Active'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 3),
        'name': PlutoCell(value: 'Ace Foley'),
        'email': PlutoCell(value: 'ace.fo@yahoo.com'),
        'dob': PlutoCell(value: '12/09/1985'),
        'status': PlutoCell(value: 'Inactive'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 4),
        'name': PlutoCell(value: 'Nikolai Schmidt'),
        'email': PlutoCell(value: 'nikolai.schmidt1964@outlook.com'),
        'dob': PlutoCell(value: '03/22/1956'),
        'status': PlutoCell(value: 'Deactivated'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 5),
        'name': PlutoCell(value: 'Clayton Charles'),
        'email': PlutoCell(value: 'me@clayton.com'),
        'dob': PlutoCell(value: '10/14/1971'),
        'status': PlutoCell(value: 'Active'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 6),
        'name': PlutoCell(value: 'Prince Chen'),
        'email': PlutoCell(value: 'prince.chen1997@gmail.com'),
        'dob': PlutoCell(value: '07/05/1992'),
        'status': PlutoCell(value: 'Active'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 7),
        'name': PlutoCell(value: 'Reece Duran'),
        'email': PlutoCell(value: 'reece@yahoo.com'),
        'dob': PlutoCell(value: '05/26/1980'),
        'status': PlutoCell(value: 'Active'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 8),
        'name': PlutoCell(value: 'Anastasia Mcdaniel'),
        'email': PlutoCell(value: 'anastasia.spring@mcdaniel12.com'),
        'dob': PlutoCell(value: '02/11/1968'),
        'status': PlutoCell(value: 'Deactivated'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 9),
        'name': PlutoCell(value: 'Melvin Boyle'),
        'email': PlutoCell(value: 'Me.boyle@gmail.com'),
        'dob': PlutoCell(value: '08/03/1974'),
        'status': PlutoCell(value: 'Inactive'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 10),
        'name': PlutoCell(value: 'Kailee Thomas'),
        'email': PlutoCell(value: 'Kailee.thomas@gmail.com'),
        'dob': PlutoCell(value: '11/28/1954'),
        'status': PlutoCell(value: 'Inactive'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 11),
        'name': PlutoCell(value: 'John Doe'),
        'email': PlutoCell(value: 'john.doe@email.com'),
        'dob': PlutoCell(value: '01/15/1990'),
        'status': PlutoCell(value: 'Active'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 12),
        'name': PlutoCell(value: 'Jane Smith'),
        'email': PlutoCell(value: 'jane.smith@email.com'),
        'dob': PlutoCell(value: '05/20/1985'),
        'status': PlutoCell(value: 'Inactive'),
        'actions': PlutoCell(value: ''),
      },
    ),
  ];

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
        Color statusColor;
        switch (rendererContext.cell.value) {
          case 'Active':
            statusColor = Colors.green;
            break;
          case 'Inactive':
            statusColor = Colors.orange;
            break;
          case 'Deactivated':
            statusColor = Colors.red;
            break;
          default:
            statusColor = Colors.grey;
        }
        return Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(rendererContext.cell.value, overflow: TextOverflow.ellipsis, maxLines: 1),
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
              icon: const Icon(Icons.open_in_new, size: 20),
              onPressed: () {},
              splashRadius: 20,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              onPressed: () {},
              splashRadius: 20,
            ),
          ],
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Management',
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

          LayoutBuilder(
            builder: (context, constraints) {
              bool isWide = constraints.maxWidth > 700;
              return isWide
                  ? Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search with username or user ID...',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: appColors.formFieldBorderColor!),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Status',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: appColors.formFieldBorderColor!),
                              ),
                            ),
                            value: 'Active', // Default value
                            items: ['Active', 'Inactive', 'Deactivated']
                                .map((label) => DropdownMenuItem(value: label, child: Text(label)))
                                .toList(),
                            onChanged: (value) {
                              // Handle status change
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appColors.applyFilterButtonColor,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('APPLY FILTERS', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Search with username or user ID...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: appColors.formFieldBorderColor!),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Status',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: appColors.formFieldBorderColor!),
                            ),
                          ),
                          value: 'Active', // Default value
                          items: ['Active', 'Inactive', 'Deactivated']
                              .map((label) => DropdownMenuItem(value: label, child: Text(label)))
                              .toList(),
                          onChanged: (value) {
                            // Handle status change
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appColors.applyFilterButtonColor,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('APPLY FILTERS', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    );
            },
          ),

          const SizedBox(height: 30),
          Expanded(
            child: PlutoGrid(
              columns: columns,
              rows: rows,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                stateManager = event.stateManager;
                stateManager.setPageSize(14, notify: true);
              },
              configuration: PlutoGridConfiguration(
                columnSize: const PlutoGridColumnSizeConfig(autoSizeMode: PlutoAutoSizeMode.scale),
                style: PlutoGridStyleConfig(
                  gridBorderColor: Colors.transparent,
                  borderColor: appColors.formFieldBorderColor!,
                  rowColor: Colors.white,
                  columnTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              createFooter: (stateManager) {
                return PlutoPagination(stateManager);
              },
            ),
          ),
        ],
      ),
    );
  }
}

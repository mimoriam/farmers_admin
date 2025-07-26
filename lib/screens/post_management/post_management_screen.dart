import 'package:farmers_admin/common/app_header.dart';
import 'package:farmers_admin/screens/edit_post/edit_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../main.dart';

class PostManagementScreen extends StatefulWidget {
  const PostManagementScreen({super.key});

  @override
  State<PostManagementScreen> createState() => _PostManagementScreenState();
}

class _PostManagementScreenState extends State<PostManagementScreen> {
  late final PlutoGridStateManager stateManager;

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

  List<PlutoColumn> _getColumns(BuildContext context) {
    return [
      PlutoColumn(
        title: '#',
        field: 'id',
        type: PlutoColumnType.number(),
        width: 80,
        enableSorting: false,
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(title: 'Post Title', field: 'post_title', type: PlutoColumnType.text()),
      PlutoColumn(
        title: 'Weight (KG)',
        field: 'weight',
        type: PlutoColumnType.number(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(
        title: 'Gender',
        field: 'gender',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
      ),
      PlutoColumn(title: 'City', field: 'city', type: PlutoColumnType.text()),
      PlutoColumn(
        title: 'Status',
        field: 'status',
        type: PlutoColumnType.text(),
        minWidth: 115,
        renderer: (rendererContext) {
          Color statusColor;
          switch (rendererContext.cell.value) {
            case 'Approved':
              statusColor = Colors.green;
              break;
            case 'Blocked':
              statusColor = Colors.black;
              break;
            case 'Rejected':
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
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        renderer: (rendererContext) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.open_in_new, size: 20),
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => const EditPostScreen()));
                },
                splashRadius: 20,
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20),
                onPressed: () {
                  showDeleteConfirmationDialog("1");
                },
                splashRadius: 20,
              ),
            ],
          );
        },
      ),
    ];
  }

  final List<PlutoRow> rows = [
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 1),
        'post_title': PlutoCell(value: 'Alyvia Kelley'),
        'weight': PlutoCell(value: 21.5),
        'gender': PlutoCell(value: '(Male) 46y'),
        'city': PlutoCell(value: 'Toledo'),
        'status': PlutoCell(value: 'Approved'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 2),
        'post_title': PlutoCell(value: 'Jaiden Nixon'),
        'weight': PlutoCell(value: 21.5),
        'gender': PlutoCell(value: '(Female) 23y'),
        'city': PlutoCell(value: 'Austin'),
        'status': PlutoCell(value: 'Approved'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 3),
        'post_title': PlutoCell(value: 'Ace Foley'),
        'weight': PlutoCell(value: 36.3),
        'gender': PlutoCell(value: '(Male) 24y'),
        'city': PlutoCell(value: 'Fairfield'),
        'status': PlutoCell(value: 'Blocked'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 4),
        'post_title': PlutoCell(value: 'Nikolai Schmidt'),
        'weight': PlutoCell(value: 19.3),
        'gender': PlutoCell(value: '(Female) 19y'),
        'city': PlutoCell(value: 'Fairfield'),
        'status': PlutoCell(value: 'Rejected'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 5),
        'post_title': PlutoCell(value: 'Clayton Charles'),
        'weight': PlutoCell(value: 21.5),
        'gender': PlutoCell(value: '(Female) 5y'),
        'city': PlutoCell(value: 'Toledo'),
        'status': PlutoCell(value: 'Approved'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 6),
        'post_title': PlutoCell(value: 'Prince Chen'),
        'weight': PlutoCell(value: 18.2),
        'gender': PlutoCell(value: '(Male) 10y'),
        'city': PlutoCell(value: 'Orange'),
        'status': PlutoCell(value: 'Approved'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 7),
        'post_title': PlutoCell(value: 'Reece Duran'),
        'weight': PlutoCell(value: 18.2),
        'gender': PlutoCell(value: '(Male) 65y'),
        'city': PlutoCell(value: 'Naperville'),
        'status': PlutoCell(value: 'Approved'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 8),
        'post_title': PlutoCell(value: 'Anastasia Mcdaniel'),
        'weight': PlutoCell(value: 21.5),
        'gender': PlutoCell(value: '(Female) 60y'),
        'city': PlutoCell(value: 'Orange'),
        'status': PlutoCell(value: 'Rejected'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 9),
        'post_title': PlutoCell(value: 'Melvin Boyle'),
        'weight': PlutoCell(value: 19.3),
        'gender': PlutoCell(value: '(Male) 18y'),
        'city': PlutoCell(value: 'Toledo'),
        'status': PlutoCell(value: 'Blocked'),
        'actions': PlutoCell(value: ''),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 10),
        'post_title': PlutoCell(value: 'Kailee Thomas'),
        'weight': PlutoCell(value: 34.1),
        'gender': PlutoCell(value: '(Male) 33y'),
        'city': PlutoCell(value: 'Pembroke Pines'),
        'status': PlutoCell(value: 'Blocked'),
        'actions': PlutoCell(value: ''),
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
          const AppHeader(),
          const SizedBox(height: 30),
          Text(
            'Post Management',
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Dashboard / Post Management',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Post using post code e.g #12345...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: appColors.formFieldBorderColor!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: appColors.brandColor!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: appColors.formFieldBorderColor!),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColors.applyFilterButtonColor,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('SEARCH', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: PlutoGrid(
              columns: _getColumns(context),
              rows: rows,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                stateManager = event.stateManager;
                stateManager.setPageSize(10, notify: true);
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
                stateManager.setPageSize(10, notify: true);
                return PlutoPagination(stateManager);
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:farmers_admin/common/app_header.dart';
import 'package:farmers_admin/models/post_model.dart';
import 'package:farmers_admin/screens/edit_post/edit_post_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class PostManagementScreen extends StatefulWidget {
  const PostManagementScreen({super.key});

  @override
  State<PostManagementScreen> createState() => _PostManagementScreenState();
}

class _PostManagementScreenState extends State<PostManagementScreen> {
  late PlutoGridStateManager stateManager;
  late DatabaseReference _dbRef;
  List<Post> _posts = [];
  StreamSubscription<DatabaseEvent>? _postsSubscription;
  bool _isGridLoaded = false;

  List<PlutoColumn> _getColumns() {
    return [
      PlutoColumn(
        title: 'Post ID',
        field: 'id',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Post Title',
        field: 'post_title',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Weight',
        field: 'weight',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Gender',
        field: 'gender',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'City',
        field: 'city',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Village',
        field: 'village',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Verified',
        field: 'verified',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Actions',
        field: 'actions',
        type: PlutoColumnType.text(),
        readOnly: true,
        renderer: (rendererContext) {
          return IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              final postId = rendererContext.row.cells['id']!.value;
              try {
                final post = _posts.firstWhere((p) => p.postId == postId);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPostScreen(post: post),
                  ),
                );
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: Could not find post with ID $postId')),
                  );
                }
              }
            },
          );
        },
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _dbRef = FirebaseDatabase.instance.ref().child('productsPostData');
    _listenForPosts();
  }

  void _listenForPosts() {
    _postsSubscription = _dbRef.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null && mounted) {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);
        final List<Post> loadedPosts = [];
        data.forEach((key, value) {
          value.forEach((key, value) {
            if (value is Map) {
              final postMap = Map<dynamic, dynamic>.from(value);
              print(postMap);
              loadedPosts.add(Post.fromMap(key, postMap));
            }
          });
        });

        setState(() {
          _posts = loadedPosts;
        });

        if (_isGridLoaded) {
          _updatePlutoGridRows();
        }
      }
    });
  }

  void _updatePlutoGridRows() {
    final newRows = _posts.map((post) {
      return PlutoRow(
        cells: {
          'id': PlutoCell(value: post.postId),
          'post_title': PlutoCell(value: post.postTitle),
          'weight': PlutoCell(value: post.displayWeight),
          'gender': PlutoCell(value: post.postGender),
          'city': PlutoCell(value: post.postCity),
          'village': PlutoCell(value: post.postVillage),
          'verified': PlutoCell(value: post.postUserVerified ? 'Yes' : 'No'),
          'actions': PlutoCell(value: ''),
        },
      );
    }).toList();

    stateManager.removeAllRows();
    stateManager.appendRows(newRows);
  }

  @override
  void dispose() {
    _postsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppHeader(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: PlutoGrid(
                columns: _getColumns(),
                rows: const [],
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  stateManager = event.stateManager;
                  stateManager.setShowColumnFilter(true);
                  setState(() {
                    _isGridLoaded = true;
                  });
                  if(_posts.isNotEmpty){
                    _updatePlutoGridRows();
                  }
                },
                configuration: const PlutoGridConfiguration(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


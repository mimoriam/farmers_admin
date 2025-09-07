class Post {
  final String postId;
  final String postTitle;
  final String postGender;
  final String postCity;
  final String postVillage;
  final bool postUserVerified;

  // Specific fields for weight from the database
  final dynamic postAverageWeight;
  final String? postWeightCategory;
  final int? postQuantity;

  Post({
    required this.postId,
    required this.postTitle,
    required this.postGender,
    required this.postCity,
    required this.postVillage,
    required this.postUserVerified,
    this.postAverageWeight,
    this.postWeightCategory,
    this.postQuantity,
  });

  // Computed property to create a display string for weight
  String get displayWeight {
    if (postAverageWeight != null && postAverageWeight.toString().isNotEmpty) {
      String weight = '$postAverageWeight';
      if (postWeightCategory != null && postWeightCategory!.isNotEmpty) {
        weight += ' ($postWeightCategory)';
      }
      return weight;
    } else if (postQuantity != null) {
      return '$postQuantity items';
    }
    return ''; // Return empty if no weight/quantity info
  }

  factory Post.fromMap(String key, Map<dynamic, dynamic> map) {
    return Post(
      postId: key,
      postTitle: map['postTitle'] ?? '',
      postGender: map['postGender'] ?? '',
      postCity: map['postCity'] ?? '',
      postVillage: map['postVillage'] ?? '',
      postUserVerified: map['postUserVerified'] ?? false,
      postAverageWeight: map['postAverageWeight'],
      postWeightCategory: map['postWeightCategory'],
      postQuantity: map['postQuantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postTitle': postTitle,
      'postGender': postGender,
      'postCity': postCity,
      'postVillage': postVillage,
      'postUserVerified': postUserVerified,
      'postAverageWeight': postAverageWeight,
      'postWeightCategory': postWeightCategory,
      'postQuantity': postQuantity,
    };
  }
}

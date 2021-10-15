// import 'package:equatable/equatable.dart';

// class User extends Equatable {
//   final String id;
//   final String firstName;
//   final String lastName;

//   final String? image;

//   User(this.id, this.firstName, this.lastName, {this.image});

//   Map<String, Object?> toFirebaseMap({String? newImage}) {
//     return <String, Object?>{
//       'id': id,
//       'firstName': firstName,
//       'lastName': lastName,
//       'image': newImage ?? image
//     };
//   }

//   User.fromFirebaseMap(Map<String, Object?> data)
//       : id = data['id'] as String,
//         firstName = data['name'] as String,
//         lastName = data['age'] as String,
//         image = data['image'] as String?;

//   @override
//   List<Object?> get props => [id, firstName, lastName, image];
// }

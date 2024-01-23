import 'package:equatable/equatable.dart';

class Post extends Equatable{

  late int id;
  late String title;
  late String body;

  Post({required this.id , required this.title , required this.body});

  @override
  List<Object?> get props => [id,title,body];

}
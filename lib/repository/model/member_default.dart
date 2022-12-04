import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member_default.g.dart';

@JsonSerializable()
class MemberDefault extends Equatable {
  const MemberDefault({
    required this.id,
    this.email,
    this.name,
    this.photoUrl,
  });

  final String id;
  final String? email;
  final String? name;
  final String? photoUrl;

  static const empty = MemberDefault(
    id: '',
    email: '',
    name: '',
    photoUrl: '',
  );
  bool get isEmpty => this == MemberDefault.empty;

  @override
  List<Object?> get props => [id];
}

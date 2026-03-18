class SelectOptionDto {
  final String id;
  final String name;

  SelectOptionDto({
    required this.id,
    required this.name,
  });

  factory SelectOptionDto.fromJson(Map<String, dynamic> json) {
    return SelectOptionDto(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

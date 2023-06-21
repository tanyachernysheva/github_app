final class Owner {
  final int? id;
  final String? avatarUrl;
  final String? login;

  Owner({
    this.id,
    this.avatarUrl,
    this.login,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'] as int?,
      avatarUrl: json['avatar_url'] as String?,
      login: json['login'] as String?,
    );
  }
}

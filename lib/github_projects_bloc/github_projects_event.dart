part of 'github_projects_bloc.dart';

@immutable
sealed class GitHubProjectsEvent {
  const GitHubProjectsEvent();

  const factory GitHubProjectsEvent.getProjects([String? value]) =
      GetGitHubProjectsEvent;
}

final class GetGitHubProjectsEvent extends GitHubProjectsEvent {
  final String? value;

  const GetGitHubProjectsEvent([this.value = '']);
}

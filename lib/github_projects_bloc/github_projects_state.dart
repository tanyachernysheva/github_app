part of 'github_projects_bloc.dart';

@immutable
sealed class GitHubProjectsState {
  const GitHubProjectsState();

  const factory GitHubProjectsState.initial() = GitHubProjectsInitial;
  const factory GitHubProjectsState.data(List<GitHubProject> projects) =
      GitHubProjectsData;
  const factory GitHubProjectsState.isEmpty() = GitHubProjectsDataisEmpty;
  const factory GitHubProjectsState.loading() = GitHubProjectsLoading;
  const factory GitHubProjectsState.error(String message) = GitHubProjectsError;
}

class GitHubProjectsInitial extends GitHubProjectsState {
  const GitHubProjectsInitial();
}

class GitHubProjectsData extends GitHubProjectsState {
  final List<GitHubProject> projects;

  const GitHubProjectsData([this.projects = const []]);
}

class GitHubProjectsDataisEmpty extends GitHubProjectsState {
  const GitHubProjectsDataisEmpty();
}

class GitHubProjectsLoading extends GitHubProjectsState {
  const GitHubProjectsLoading();
}

class GitHubProjectsError extends GitHubProjectsState {
  final String message;

  const GitHubProjectsError(this.message);
}

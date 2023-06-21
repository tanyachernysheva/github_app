import 'package:flutter/material.dart';
import 'package:github_app/models/github_project.dart';
import 'package:github_app/widgets/dot_divider.dart';
import 'package:github_app/widgets/icon_label.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final GitHubProject project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (project.htmlUrl == null) return;

        launchUrl(Uri.parse(project.htmlUrl!));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF30363D),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 14,
                  backgroundImage: NetworkImage(
                    project.owner?.avatarUrl ?? '',
                  ),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    project.title ?? '---',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(project.description ?? ''),
            SizedBox(
              height: project.topics.isNotEmpty ? 10 : 0,
            ),
            Wrap(
              spacing: 4,
              children: <Widget>[
                ...project.topics.take(5).map(
                      (e) => Chip(
                        label: Text(e),
                        labelStyle: const TextStyle(
                          fontSize: 12,
                        ),
                        labelPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
              ],
            ),
            const SizedBox(height: 10),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.bodySmall!,
              child: Row(
                children: <Widget>[
                  Text(project.language ?? 'Unknown'),
                  const SizedBox(width: 10),
                  const DotDivider(
                    radius: 1.5,
                  ),
                  const SizedBox(width: 10),
                  IconLabel(
                    leading: Icon(
                      Icons.star_border,
                      size: 18,
                      color: Colors.grey[600],
                    ),
                    label: '${project.stargazersCount ?? 0}',
                  ),
                  const SizedBox(width: 10),
                  const DotDivider(
                    radius: 1.5,
                  ),
                  const SizedBox(width: 10),
                  Text('Updated on ${_formatDate(project.updatedAt) ?? ''}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _formatDate(String? timestamp) {
    if (timestamp == null) return null;

    return DateFormat('dd.MM.yyyy').format(DateTime.parse(timestamp));
  }
}

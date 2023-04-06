import 'package:flutter/material.dart';
import 'package:github_graphql_api/shared/design_system/ds.dart';
import 'package:github_graphql_api/shared/strings/strings.dart';

import '../../domain/entities/user.dart';

class UserDetailsComponent extends StatelessWidget {
  const UserDetailsComponent({super.key, required this.user});

  final User user;

  bool get hasAvatar => user.avatarUrl is String;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(ds.spacing.small),
      children: [
        Row(
          children: [
            if (hasAvatar) ...[
              CircleAvatar(
                backgroundImage: NetworkImage(user.avatarUrl!),
                radius: 40,
              ),
              SizedBox(width: ds.spacing.small)
            ],
            Expanded(
              child: Text(
                user.bio ?? '',
                style: ds.typography.body1,
              ),
            ),
          ],
        ),
        SizedBox(height: ds.spacing.medium),
        Text(
          strings.userDetailsScreen.repositoriesSubtitle,
          style: ds.typography.subtitle,
        ),
        SizedBox(height: ds.spacing.small),
        ...user.repositories
            .map(
              (repo) => Text(
                '- ${repo.name}',
                style: ds.typography.body2,
              ),
            )
            .toList()
      ],
    );
  }
}

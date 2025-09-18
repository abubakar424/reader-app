import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/global_variables.dart';
import '../../../router/routes.dart';
import '../provider/provider1.dart';
import '../widgets/custom_profile.dart';

class ProfileUipdate extends StatefulWidget {
  const ProfileUipdate({super.key});

  @override
  State<ProfileUipdate> createState() => _ProfileUipdateState();
}

class _ProfileUipdateState extends State<ProfileUipdate> {
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ImageProviderNotifier>(context);
    final displayName = (profileProvider.firstName.isNotEmpty ||
            profileProvider.lastName.isNotEmpty)
        ? "${profileProvider.firstName} ${profileProvider.lastName}"
        : "James S. Hernandez";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: textTheme(context)
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomProfile(
              onTap: () {
                context.pushNamed(AppRoute.editprofile);
              },
              color: colorScheme(context).primary,
            ),
            const SizedBox(height: 10),
            Text(
              displayName,
              style: textTheme(context)
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Country: ",
                  style: textTheme(context).bodySmall,
                ),
                Text(
                  " Australia",
                  style: textTheme(context).bodySmall,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

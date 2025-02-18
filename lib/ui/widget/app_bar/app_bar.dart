import 'package:flutter/material.dart';
import 'package:todo_list/core/config/injector.dart';
import 'package:todo_list/layout/layout.dart';
import 'package:todo_list/ui/start_viewmodel.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppBarWidget({super.key});
  final StartViewModel startViewModel = injector.get<StartViewModel>();

  @override
  Widget build(BuildContext context) {
    final spacing = AppSpacing.of(context);
    final text = Theme.of(context).textTheme;
    return ListenableBuilder(
        listenable: startViewModel,
        builder: (context, _) {
          final user = startViewModel.userLogged;
          return AppBar(
            title: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                spacing: spacing.marginApp,
                children: [
                  ClipOval(
                    child: Image.asset(
                      user.image,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Olá!',
                        style: text.titleMedium,
                      ),
                      Text(
                        user.name,
                        style: text.titleLarge,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/detailed_developer_page_screen.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/detailed_developer_page_view_model.dart';
import 'package:mi_perfil_dev/presentation/utils/stf_view_model_adapter.dart';

class DetailedDeveloperPage extends StatefulWidget {
  static const String route = '/developer/detailed';
  const DetailedDeveloperPage({super.key});

  @override
  State<DetailedDeveloperPage> createState() => _DetailedDeveloperPageState();
}

class _DetailedDeveloperPageState extends State<DetailedDeveloperPage> {
  @override
  Widget build(BuildContext context) {
    return StfViewModelAdapter(
      create: (ref) => DetailedDeveloperPageViewModel(
        context: context,
        widget: widget,
        ref: ref,
        isMounted: () => mounted,
      ),
      builder: (context, viewModel) =>
          DetailedDeveloperPageScreen(vm: viewModel),
    );
  }
}

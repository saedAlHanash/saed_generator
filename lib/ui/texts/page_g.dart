import 'package:saed_generator/const_data.dart';

final pageG =
    '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';

import '../../bloc/${nameServiceSC}_cubit/${nameServiceSC}_cubit.dart';

class ${nameServicePC}Page extends StatelessWidget {
  const ${nameServicePC}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<${nameServicePC}Cubit, ${nameServicePC}Initial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {},
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(),
        body: BlocBuilder<${nameServicePC}Cubit, ${nameServicePC}Initial>(
          builder: (context, state) {
            return RefreshWidget(
              isLoading: state.loading,
              onRefresh: () {
                context.read<${nameServicePC}Cubit>().getData(newData: true);
              },
              child: ListView(
                shrinkWrap: true,
                children: [],
              ),
            );
          },
        ),
      ),
    );
  }
}


''';

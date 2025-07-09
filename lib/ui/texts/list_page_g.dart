import 'package:saed_generator/const_data.dart';

String get listPage =>
    '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widget/app_bar/app_bar_widget.dart';
import '../../../../core/widget/refresh_widget/refresh_widget.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/${nameServiceSC}s_cubit/${nameServiceSC}s_cubit.dart';
import '../widget/item_$nameServiceSC.dart';

class ${nameServicePC}sPage extends StatelessWidget {
  const ${nameServicePC}sPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: BlocBuilder<${nameServicePC}sCubit, ${nameServicePC}sInitial>(
        builder: (context, state) {
          return RefreshWidget(
            isLoading: state.loading,
            onRefresh: () => context.read<${nameServicePC}sCubit>().getData(newData: true),
            child: ListView.separated(
              itemCount: state.result.length,
              separatorBuilder: (_, i) => 10.0.verticalSpace,
              itemBuilder: (_, i) {
                final item = state.result[i];
                return Item$nameServicePC($nameServiceCC: item);
              },
            ),
          );
        },
      ),
    );
  }
}

''';

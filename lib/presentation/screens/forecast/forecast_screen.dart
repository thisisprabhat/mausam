import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/bloc/forecast_bloc/forecast_bloc.dart';
import '/presentation/widgets/error_widget.dart';
import '/data/models/forecast_model.dart';
import '/presentation/widgets/loader.dart';
import 'components/day_card.dart';

class FiveDaysReport extends StatefulWidget {
  const FiveDaysReport({super.key});

  @override
  State<FiveDaysReport> createState() => _FiveDaysReportState();
}

class _FiveDaysReportState extends State<FiveDaysReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ForecastBloc, ForecastState>(
        builder: (context, state) {
          if (state is ForecastStateLoading || state is ForecastStateInitial) {
            return const Loader();
          } else if (state is ForecastStateFailedLoading) {
            return CustomErrorWidget(
              exceptionCaught: state.exception,
              onPressed: () {
                context
                    .read<ForecastBloc>()
                    .add(ForecastEventGetFromCurrentLocation());
              },
            );
          } else if (state is ForecastStateLoadedSuccefully) {
            Forecast? forecast = state.forecast;
            DateTime? initialDate;

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: 5,
              itemBuilder: (context, index) {
                initialDate ??= forecast?.list?.first.dtTxt;
                DateTime? tempDate = initialDate;

                final List<ListElement>? dayForecast = forecast?.list
                    ?.where((e) =>
                        e.dtTxt?.day ==
                        tempDate?.add(Duration(days: index)).day)
                    .toList();
                return DayCard(list: dayForecast);
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

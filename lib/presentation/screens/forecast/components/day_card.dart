import 'package:flutter/Material.dart';
import 'package:flutter_svg/svg.dart';

import '/data/models/forecast_model.dart';

class DayCard extends StatelessWidget {
  const DayCard({super.key, required this.list});
  final List<ListElement>? list;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '  ${list?.first.dtTxt?.day}/${list?.first.dtTxt?.month}/${list?.first.dtTxt?.year}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list?.length,
                  itemBuilder: (context, index) {
                    final weather = list?[index];
                    final icon = weather?.weather?.first.icon;
                    final time = TimeOfDay.fromDateTime(
                        weather?.dtTxt ?? DateTime.now());
                    return Column(
                      children: [
                        Card(
                          color: colorScheme.surfaceVariant,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  icon == null
                                      ? 'assets/svg/01d.svg'
                                      : 'assets/svg/$icon.svg',
                                  height: 50,
                                  width: 50,
                                ),
                                Divider(
                                  color: colorScheme.outline,
                                ),
                                Text(weather?.weather!.first.main?.name ?? ""),
                                Text(
                                    '${weather?.main?.temp.toString().substring(0, 2)}°C')
                              ],
                            ),
                          ),
                        ),
                        Text(time.format(context).toString())
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

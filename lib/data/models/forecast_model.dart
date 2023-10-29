import 'dart:convert';

import 'weather_model.dart' show Coord, Clouds, Wind;

// ignore_for_file: constant_identifier_names
class Forecast {
  final String? cod;
  final num? message;
  final num? cnt;
  final List<ListElement>? list;
  final City? city;

  Forecast({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  factory Forecast.fromRawJson(String str) =>
      Forecast.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        cod: json["cod"].toString(),
        message: json["message"],
        cnt: json["cnt"],
        list: json["list"] == null
            ? []
            : List<ListElement>.from(
                json["list"]!.map((x) => ListElement.fromJson(x))),
        city: json["city"] == null ? null : City.fromJson(json["city"]),
      );

  Map<String, dynamic> toJson() => {
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "city": city?.toJson(),
      };
}

class City {
  final num? id;
  final String? name;
  final Coord? coord;
  final String? country;
  final num? population;
  final num? timezone;
  final num? sunrise;
  final num? sunset;

  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  factory City.fromRawJson(String str) => City.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coord": coord?.toJson(),
        "country": country,
        "population": population,
        "timezone": timezone,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}

class ListElement {
  final num? dt;
  final MainClass? main;
  final List<Weather>? weather;
  final Clouds? clouds;
  final Wind? wind;
  final num? visibility;
  final num? pop;
  final SysPod? sys;
  final DateTime? dtTxt;

  ListElement({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.sys,
    this.dtTxt,
  });

  factory ListElement.fromRawJson(String str) =>
      ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        dt: json["dt"],
        main: json["main"] == null ? null : MainClass.fromJson(json["main"]),
        weather: json["weather"] == null
            ? []
            : List<Weather>.from(
                json["weather"]!.map((x) => Weather.fromJson(x))),
        clouds: json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]),
        wind: json["wind"] == null ? null : Wind.fromJson(json["wind"]),
        visibility: json["visibility"],
        pop: json["pop"],
        sys: json["sys"] == null ? null : SysPod.fromJson(json["sys"]),
        dtTxt: json["dt_txt"] == null ? null : DateTime.parse(json["dt_txt"]),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "main": main?.toJson(),
        "weather": weather == null
            ? []
            : List<dynamic>.from(weather!.map((x) => x.toJson())),
        "clouds": clouds?.toJson(),
        "wind": wind?.toJson(),
        "visibility": visibility,
        "pop": pop,
        "sys": sys?.toJson(),
        "dt_txt": dtTxt?.toIso8601String(),
      };
}

class MainClass {
  final num? temp;
  final num? feelsLike;
  final num? tempMin;
  final num? tempMax;
  final num? pressure;
  final num? seaLevel;
  final num? grndLevel;
  final num? humidity;
  final num? tempKf;

  MainClass({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  factory MainClass.fromRawJson(String str) =>
      MainClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        pressure: json["pressure"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
        humidity: json["humidity"],
        tempKf: json["temp_kf"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
        "humidity": humidity,
        "temp_kf": tempKf,
      };
}

class SysPod {
  final Pod? pod;

  SysPod({
    this.pod,
  });

  factory SysPod.fromRawJson(String str) => SysPod.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SysPod.fromJson(Map<String, dynamic> json) => SysPod(
        pod: podValues.map[json["pod"]]!,
      );

  Map<String, dynamic> toJson() => {
        "pod": podValues.reverse[pod],
      };
}

enum Pod { D, N }

final podValues = EnumValues({"d": Pod.D, "n": Pod.N});

class Weather {
  final num? id;
  final MainEnum? main;
  final Description? description;
  final String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromRawJson(String str) => Weather.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: mainEnumValues.map[json["main"]]!,
        description: descriptionValues.map[json["description"]]!,
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": mainEnumValues.reverse[main],
        "description": descriptionValues.reverse[description],
        "icon": icon,
      };
}

enum Description {
  BROKEN_CLOUDS,
  CLEAR_SKY,
  FEW_CLOUDS,
  OVERCAST_CLOUDS,
  SCATTERED_CLOUDS
}

final descriptionValues = EnumValues({
  "broken clouds": Description.BROKEN_CLOUDS,
  "clear sky": Description.CLEAR_SKY,
  "few clouds": Description.FEW_CLOUDS,
  "overcast clouds": Description.OVERCAST_CLOUDS,
  "scattered clouds": Description.SCATTERED_CLOUDS
});

enum MainEnum { CLEAR, CLOUDS }

final mainEnumValues =
    EnumValues({"Clear": MainEnum.CLEAR, "Clouds": MainEnum.CLOUDS});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

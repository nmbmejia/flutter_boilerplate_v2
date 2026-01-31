/// Home screen data model (M in MVC).
class HomeModel {
  const HomeModel({
    this.greeting = 'Hello',
    this.counter = 0,
  });

  final String greeting;
  final int counter;

  HomeModel copyWith({String? greeting, int? counter}) {
    return HomeModel(
      greeting: greeting ?? this.greeting,
      counter: counter ?? this.counter,
    );
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nkap/blocs/auth_bloc/auth_bloc.dart';
import 'package:nkap/data/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  MockAuthRepository mockAuthRepository =  MockAuthRepository();

  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  group('Authentication', () {
    //final weather = Weather(cityName: 'London', temperatureCelsius: 7);

    // Old way of testing Blocs - like regular Streams
    test(
      'OLD WAY emits [WeatherLoading, WeatherLoaded] when successful',
          () {
        final bloc = AuthBloc(authRepository: mockAuthRepository);
        bloc.add(SignOutRequested());
        expectLater(
          bloc,
          emitsInOrder([
            AuthInitial(),
            Authenticated(),
            UnAuthenticated(),
          ]),
        );
      },
    );
  });
}
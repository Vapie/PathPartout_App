import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';


final locator = GetIt.instance;

@injectableInit
void configure() => $initGetIt(locator);

void $initGetIt(GetIt g, {String environment}) {
 // g.registerLazySingleton<EpochService>(() => EpochService());
  //g.registerLazySingleton<InformationService>(() => InformationService());

}


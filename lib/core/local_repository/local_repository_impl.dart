import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:hoplist_app/core/local_repository/local_repository_interface.dart';

class UserLocalRepositoryImpl implements UserLocalRepositoryInterface {
  final DataConnectionChecker dataConnectionChecker = DataConnectionChecker();

  @override
  Future<bool> get isNetworkConnected => dataConnectionChecker.hasConnection;
}

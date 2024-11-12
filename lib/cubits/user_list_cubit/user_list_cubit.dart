import 'package:bloc/bloc.dart';
import '../../../models/user.dart';
import '../../../repositories/user_repository.dart';


class UserListCubit extends Cubit<List<User>> {
  final UserRepository _userRepository;

  UserListCubit(this._userRepository) : super([]);

  Future<void> fetchUsers(int page) async {
    try {
      final users = await _userRepository.fetchUsers(page);
      emit(users);
    } catch (e) {
      // Handle error appropriately
      emit([]);
    }
  }
}

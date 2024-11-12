import 'package:bloc/bloc.dart';
import 'package:perfection_company/repositories/user_repository.dart';
import '../../../models/user.dart';


class UserDetailCubit extends Cubit<User?> {
  final UserRepository _userRepository;

  UserDetailCubit(this._userRepository) : super(null);

  Future<void> fetchUserDetail(int id) async {
    try {
      final user = await _userRepository.fetchUserDetail(id);
      emit(user);
    } catch (e) {
      // Handle error appropriately
      emit(null);
    }
  }
}
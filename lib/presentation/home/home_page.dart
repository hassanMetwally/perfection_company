import 'package:flutter/material.dart';
import 'package:perfection_company/presentation/user/user_detail_page.dart';

import '../../cubits/user_details_cubit/user_details_cubit.dart';
import '../../cubits/user_list_cubit/user_list_cubit.dart';
import '../../models/user.dart';
import '../../repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserRepository _userRepository = UserRepository();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    context.read<UserListCubit>().fetchUsers(_currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
      ),
      body: BlocBuilder<UserListCubit, List<User>>(
        builder: (context, users) {
          if (users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    width: 60,
                    height: 100,
                    child: ClipOval(
                        child: Image.network(
                      user.avatar,
                      fit: BoxFit.cover,
                    )),
                  ),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => UserDetailCubit(_userRepository),
                          child: UserDetailPage(id: user.id),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

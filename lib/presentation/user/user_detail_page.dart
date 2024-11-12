import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/user_details_cubit/user_details_cubit.dart';
import '../../models/user.dart';

class UserDetailPage extends StatelessWidget {
  final int id;

  UserDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<UserDetailCubit>().fetchUserDetail(id);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        centerTitle: true,
      ),
      body: BlocBuilder<UserDetailCubit, User?>(
        builder: (context, user) {
          if (user == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 250, // عرض الحاوية
                      height: 250,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(
                          child: Image.network(
                        user.avatar,
                        fit: BoxFit.cover,
                      )),
                    ),
                    SizedBox(height: 40),
                    Text('${user.firstName} ${user.lastName}', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10.0),
                    Text('Email: ${user.email}', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

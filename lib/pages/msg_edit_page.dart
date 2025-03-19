import 'package:flutter/material.dart';
import 'package:flutter_grateful/bloc/msg_edit_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grateful/cubit/search_friend_cubit.dart';
import 'package:flutter_grateful/pages/search_friend_page.dart';

import '../models/msg.dart';

class MsgEditPage extends StatefulWidget {
  const MsgEditPage({super.key});

  @override
  State<MsgEditPage> createState() => _MsgEditPageState();
}

class _MsgEditPageState extends State<MsgEditPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  Privacy _privacy = Privacy.public;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Message Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) => MsgEditBloc(),
          child: BlocConsumer<MsgEditBloc, MsgEditState>(
            listener: (context, state) {
              if (state is MsgEditSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Message Sent: ${state.msg.text}')),
                );
              } else if (state is MsgEditError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.error}')),
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Text Field
                    TextFormField(
                      controller: _textController,
                      decoration: const InputDecoration(labelText: 'Text'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    // To Field
                    TextFormField(
                      controller: _toController,
                      decoration: const InputDecoration(labelText: 'To'),
                      readOnly: true,
                      onTap: () async {
                        // Navigate to the search page
                        final selectedValue = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => SearchFriendCubit(),
                              child: const SearchFriendPage(),
                            ),
                          ),
                        );

                        // If a value was selected, set it in the controller
                        if (selectedValue != null) {
                          _toController.text = selectedValue;
                        }
                      },
                    ),
                    // Privacy Dropdown
                    DropdownButtonFormField<Privacy>(
                      value: _privacy,
                      onChanged: (Privacy? newValue) {
                        setState(() {
                          _privacy = newValue!;
                        });
                      },
                      items: Privacy.values.map((Privacy privacy) {
                        return DropdownMenuItem<Privacy>(
                          value: privacy,
                          child: Text(
                              privacy == Privacy.public ? 'Public' : 'Private'),
                        );
                      }).toList(),
                      decoration: const InputDecoration(labelText: 'Privacy'),
                    ),
                    // Submit Button
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<MsgEditBloc>().add(
                                  SubmitMsgEvent(
                                    text: _textController.text,
                                    from: 1,
                                    to: 2,
                                    privacy: _privacy,
                                  ),
                                );
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                    if (state is MsgEditLoading)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

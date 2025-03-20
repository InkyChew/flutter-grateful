import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grateful/bloc/msg_edit_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Message Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<MsgEditBloc, MsgEditState>(
          listener: (context, state) {
            if (state is MsgEditSuccess) {
              Navigator.pop(context);
            } else if (state is MsgEditError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
          },
          builder: (context, state) {
            if (state is MsgEditLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MsgEditInitial) {
              _textController.text = state.msg.text;
              _toController.text = state.msg.to.toString();
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
                      value: state.msg.privacy,
                      onChanged: (Privacy? newValue) {
                        state.msg.privacy = newValue!;
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (state.msg.id > 0)
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<MsgEditBloc>().add(
                                      RemoveMsgEvent(state.msg),
                                    );
                              }
                            },
                            child: const Text('Delete'),
                          ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<MsgEditBloc>().add(
                                    UpdateMsgEvent(Msg(
                                      id: state.msg.id,
                                      text: _textController.text,
                                      from: state.msg.from,
                                      to: 1,
                                      privacy: state.msg.privacy,
                                    )),
                                  );
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Something went wrong.'));
            }
          },
        ),
      ),
    );
  }
}

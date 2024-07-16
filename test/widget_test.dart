import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Assistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SmartAssistantPage(),
    );
  }
}

class SmartAssistantPage extends StatefulWidget {
  @override
  _SmartAssistantPageState createState() => _SmartAssistantPageState();
}

class _SmartAssistantPageState extends State<SmartAssistantPage> {
  String assistantResponse = '';
  final TextEditingController _controller = TextEditingController();

  Future<void> _fetchAIResponse(String query) async {
    final apiUrl = 'https://api-inference.huggingface.co/models/t5-base';
    final headers = {
      'Authorization': 'Bearer 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',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({'inputs': query});

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        assistantResponse = jsonResponse[0]['generated_text'];
      });
    } else {
      setState(() {
        assistantResponse = 'Failed to get response from AI service';
      });
    }
  }

  void _submitQuery() {
    if (_controller.text.isNotEmpty) {
      _fetchAIResponse(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Assistant'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Ask me anything:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Type your query...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitQuery,
                child: Text('Submit'),
              ),
              SizedBox(height: 20),
              if (assistantResponse.isNotEmpty)
                Text(
                  'Assistant: $assistantResponse',
                  style: TextStyle(fontSize: 18),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

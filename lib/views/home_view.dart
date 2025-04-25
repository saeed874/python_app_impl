import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../controllers/data_controller.dart';
import 'login_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // Fetch data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DataController>(context, listen: false).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final dataController = Provider.of<DataController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authController.logout();
              if (mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginView()),
                );
              }
            },
          ),
        ],
      ),
      body: dataController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : dataController.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error: ${dataController.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          dataController.fetchData();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : dataController.items.isEmpty
                  ? const Center(child: Text('No data available'))
                  : ListView.builder(
                      itemCount: dataController.items.length,
                      itemBuilder: (context, index) {
                        final item = dataController.items[index];
                        return ListTile(
                          title: Text(item.fullName),
                          subtitle: Text(item.userName),
                          leading: CircleAvatar(
                            child: Text(item.id.toString()),
                          ),
                        );
                      },
                    ),
    );
  }
}
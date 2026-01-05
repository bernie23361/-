import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // OSM 核心套件
import 'package:latlong2/latlong.dart';      // 經緯度處理工具

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenStreetMap Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const OsmMapPage(),
    );
  }
}

class OsmMapPage extends StatefulWidget {
  const OsmMapPage({super.key});

  @override
  State<OsmMapPage> createState() => _OsmMapPageState();
}

class _OsmMapPageState extends State<OsmMapPage> {
  // 定義地圖中心點 (預設：台北車站)
  final LatLng _initialCenter = const LatLng(25.0478, 121.5170);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenStreetMap (無需 API Key)'),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: _initialCenter, // 初始中心點
          initialZoom: 15.0,             // 初始縮放層級
          // 限制地圖操作範圍 (選填)
          // minZoom: 5.0,
          // maxZoom: 18.0,
        ),
        children: [
          // 1. 底圖圖層：使用 OpenStreetMap 的官方圖資
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.flutter_map_web', // 建議填寫您的套件名稱
          ),
          
          // 2. 標記圖層：在地圖上繪製圖示
          MarkerLayer(
            markers: [
              // 標記 A：台北車站
              Marker(
                point: const LatLng(25.0478, 121.5170),
                width: 80,
                height: 80,
                child: const Column(
                  children: [
                    Icon(Icons.train, color: Colors.blue, size: 40),
                    Text("台北車站", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  ],
                ),
              ),
              // 標記 B：台北 101
              Marker(
                point: const LatLng(25.0339, 121.5644),
                width: 80,
                height: 80,
                child: const Column(
                  children: [
                    Icon(Icons.location_on, color: Colors.red, size: 40),
                    Text("台北 101", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
          
          // 3. (選填) 版權宣告圖層：OSM 要求顯示版權
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () {}, // 可以在這裡加入開啟 OSM 官網的連結
              ),
            ],
          ),
        ],
      ),
      // 浮動按鈕：回到中心點
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 這裡可以加入回到中心點的邏輯，簡單版先不實作動畫控制器
          // 若需要完整控制功能，需要宣告 MapController
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}

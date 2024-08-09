package com.example.hack_3d_create_app

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import com.jme3.app.SimpleApplication
import com.jme3.material.Material
import com.jme3.math.Vector3f
import com.jme3.scene.Geometry
import com.jme3.scene.shape.Box
import com.jme3.system.JmeSystem
import com.jme3.export.binary.BinaryExporter
import java.io.File

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.app/model"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "create3DModel") {
                val width = call.argument<Double>("width") ?: 0.0
                val height = call.argument<Double>("height") ?: 0.0
                val length = call.argument<Double>("length") ?: 0.0
                val filename = call.argument<String>("filename") ?: "model"
                
                try {
                    // 3Dモデルの作成
                    create3DModel(width, height, length, filename)
                    
                    // モデル作成が成功した場合に結果を返す
                    result.success("Model created successfully")
                } catch (e: Exception) {
                    // エラーが発生した場合にFlutter側に通知
                    result.error("MODEL_CREATION_FAILED", "Failed to create model: ${e.message}", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun create3DModel(width: Double, height: Double, length: Double, filename: String) {
        // jMonkeyEngineを使って3Dモデルを作成
        val box = Box(width.toFloat() / 2, height.toFloat() / 2, length.toFloat() / 2)
        val geom = Geometry("Box", box)
    
        val mat = Material(JmeSystem.newAssetManager(), "Common/MatDefs/Misc/Unshaded.j3md")
        geom.material = mat
    
        // エクスポート処理
        val exporter = BinaryExporter()
        val file = File(filesDir, "$filename.glb")
        exporter.save(geom, file)
    }
}
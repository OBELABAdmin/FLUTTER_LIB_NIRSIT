package com.obelab.nirsit_plugin

import android.content.Context
import android.net.ConnectivityManager
import android.net.LinkAddress
import android.net.Network
import android.net.NetworkCapabilities
import android.net.RouteInfo
import java.net.Inet4Address
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** NirsitPlugin */
class NirsitPlugin :
    FlutterPlugin,
    MethodCallHandler {
    // The MethodChannel that will the communication between Flutter and native Android
    //
    // This local reference serves to register the plugin with the Flutter Engine and unregister it
    // when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "nirsit_plugin")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(
        call: MethodCall,
        result: Result
    ) {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "getWifiNetworkInfo" -> result.success(getWifiNetworkInfo())
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun getWifiNetworkInfo(): Map<String, String?> {
        val manager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val networks = buildList {
            manager.activeNetwork?.let { add(it) }
            addAll(manager.allNetworks.filterNot { it == manager.activeNetwork })
        }

        for (network in networks) {
            val capabilities = manager.getNetworkCapabilities(network) ?: continue
            if (!capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI)) continue

            val linkProperties = manager.getLinkProperties(network) ?: continue
            val ip = linkProperties.linkAddresses.firstIpv4Address()
            val gateway = linkProperties.routes.firstIpv4Gateway()

            if (!ip.isNullOrEmpty()) {
                return mapOf(
                    "ip" to ip,
                    "gateway" to gateway,
                )
            }
        }

        return mapOf(
            "ip" to null,
            "gateway" to null,
        )
    }

    private fun List<LinkAddress>.firstIpv4Address(): String? =
        firstOrNull { address ->
            val inetAddress = address.address
            inetAddress is Inet4Address && !inetAddress.isLoopbackAddress
        }?.address?.hostAddress

    private fun List<RouteInfo>.firstIpv4Gateway(): String? =
        firstOrNull { route ->
            val gateway = route.gateway
            gateway is Inet4Address && !gateway.isAnyLocalAddress
        }?.gateway?.hostAddress
}

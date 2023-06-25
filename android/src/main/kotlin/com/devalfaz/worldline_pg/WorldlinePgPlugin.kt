package com.devalfaz.worldline_pg

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result as MethodChannelResult

/** WorldlinePgPlugin */
class WorldlinePgPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "worldline_pg")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannelResult) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }

            "getRequestHash" -> {
                val orderId: String = call.argument<String>("orderId") ?: "";
                val mid: String = call.argument<String>("mid") ?: "";
                val trnAmt: String = call.argument<String>("trnAmt") ?: "";
                val trnCurrency: String = call.argument<String>("trnCurrency") ?: "";
                val meTransReqType: String = call.argument<String>("meTransReqType") ?: "";
                val enckey: String = call.argument<String>("enckey") ?: "";
                val responseUrl: String = call.argument<String>("responseUrl") ?: "";
                val trnRemarks: String = call.argument<String>("trnRemarks") ?: "";
                val addField1 = call.argument<String?>("addField1");
                val addField2 = call.argument<String?>("addField2");
                val addField3 = call.argument<String?>("addField3");
                val addField4 = call.argument<String?>("addField4");
                val addField5 = call.argument<String?>("addField5");
                val addField6 = call.argument<String?>("addField6");
                val addField7 = call.argument<String?>("addField7");
                val addField8 = call.argument<String?>("addField8");
                val addField9 = call.argument<String?>("addField9");
                val addField10 = call.argument<String?>("addField10");
                val merchantRequest = WorldlinePG.getHash(
                    orderId,
                    mid,
                    trnAmt,
                    trnCurrency,
                    meTransReqType,
                    enckey,
                    responseUrl,
                    trnRemarks,
                    addField1,
                    addField2,
                    addField3,
                    addField4,
                    addField5,
                    addField6,
                    addField7,
                    addField8,
                    addField9,
                    addField10
                )
                result.success(merchantRequest)
            }

            "getStatusHash" -> {
                val orderId: String = call.argument<String>("orderId") ?: "";
                val mid: String = call.argument<String>("mid") ?: "";
                val enckey: String = call.argument<String>("enckey") ?: "";
                val pgMeTrnRefNo = call.argument<String>("pgMeTrnRefNo");
                val url: String = call.argument<String>("url") ?: "";
                val responseParams = WorldlinePG.getStatusParameters(
                    mid = mid,
                    orderId = orderId,
                    pgMeTrnRefNo = pgMeTrnRefNo,
                    url = url,
                    enckey = enckey
                )
                result.success(responseParams)
            }

            "getDecryptedResponse" -> {
                val response: String = call.argument<String>("response") ?: "";
                val enckey: String = call.argument<String>("enckey") ?: "";
                val decryptedResponse = WorldlinePG.parseTrnResMsg(
                    response = response, enckey = enckey
                )
                result.success(decryptedResponse)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}

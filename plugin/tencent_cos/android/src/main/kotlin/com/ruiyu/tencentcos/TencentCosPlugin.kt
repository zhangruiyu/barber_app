package com.ruiyu.tencentcos

import android.util.Log
import com.tencent.cos.xml.exception.CosXmlClientException
import com.tencent.cos.xml.exception.CosXmlServiceException
import com.tencent.cos.xml.listener.CosXmlResultListener
import com.tencent.cos.xml.model.CosXmlRequest
import com.tencent.cos.xml.model.CosXmlResult
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.util.HashMap

class TencentCosPlugin(private val registrar: Registrar, private val channel: MethodChannel) : MethodCallHandler {
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "tencent_cos")
            channel.setMethodCallHandler(TencentCosPlugin(registrar, channel))
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        Log.e("TencentCosPlugin", call.method)
        when {
            call.method == "TencentCos.uploadFile" -> {
                val localUrl = call.argument<Any>("url").toString()
                Log.e("TencentCosPlugin", localUrl)
                val qServiceCfg = QServiceCfg(registrar.context(), call.argument<Any>("region").toString(), call.argument<Any>("appid").toString(), call.argument<Any>("secretId").toString(),
                        call.argument<Any>("secretKey").toString(), call.argument<Any>("sessionToken").toString(), java.lang.Long.parseLong(call.argument<Any>("expiredTime").toString()), call.argument<Any>("uploadCosPath").toString(), localUrl)
                val putObjectSample = PutObjectSample(qServiceCfg)
                putObjectSample.startAsync({ progress, max ->
                    val data = HashMap<String, Any>()
                    data["progress"] = progress * 100.0 / max
                    data["localUrl"] = localUrl
                    channel.invokeMethod("onProgress", data)
                    Log.e("TencentCosPlugin", "progress =\$progress%$progress")
                }, object : CosXmlResultListener {
                    override fun onSuccess(cosXmlRequest: CosXmlRequest, cosXmlResult: CosXmlResult) {
                        val data = HashMap<String, Any>()
                        data["localUrl"] = localUrl
                        data["url"] = cosXmlResult.accessUrl
                        channel.invokeMethod("onSuccess", data)
                        Log.e("TencentCosPlugin", "onSuccess =\$progress%")
                    }

                    override fun onFail(cosXmlRequest: CosXmlRequest, qcloudException: CosXmlClientException?, qcloudServiceException: CosXmlServiceException) {
                        val stringBuilder = StringBuilder()
                        if (qcloudException != null) {
                            stringBuilder.append(qcloudException.message)
                        } else {
                            stringBuilder.append(qcloudServiceException.toString())
                        }
                        val data = HashMap<String, Any>()
                        data["localUrl"] = localUrl
                        channel.invokeMethod("onFailed", data)
                        channel.invokeMethod("message", stringBuilder.toString())
                        Log.e("TencentCosPlugin", "onFailed " + stringBuilder.toString())
                    }
                })
            }
            else -> result.notImplemented()
        }
    }
}

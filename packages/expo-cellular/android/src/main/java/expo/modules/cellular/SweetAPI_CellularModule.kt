package expo.modules.cellular

import android.annotation.SuppressLint
import android.content.Context
import android.net.sip.SipManager
import android.os.Build
import android.telephony.TelephonyManager
import android.util.Log
import expo.modules.core.Promise
import expo.modules.sweetapi.Module

class SweetAPI_CellularModule(private val mContext: Context): Module {
  override fun definition() = module {
    name("ExpoCellular")
    constants {
      val telephonyManager = telephonyManager()
      mapOf(
        "allowsVoip" to SipManager.isVoipSupported(mContext),
        "isoCountryCode" to telephonyManager?.simCountryIso,
        "carrier" to telephonyManager?.simOperatorName,
        "mobileCountryCode" to telephonyManager?.simOperator?.substring(0, 3),
        "mobileNetworkCode" to telephonyManager?.simOperator?.substring(3),
      )
    }
    method("getCellularGenerationAsync") { promise: Promise ->
      try {
        promise.resolve(getCurrentGeneration())
      } catch (e: SecurityException) {
        Log.w(name, "READ_PHONE_STATE permission is required to acquire network type", e)
        promise.resolve(CellularGeneration.UNKNOWN.value)
      }
    }
    method("allowsVoipAsync") { promise: Promise ->
      promise.resolve(SipManager.isVoipSupported(mContext))
    }
    method("getIsoCountryCodeAsync") { promise: Promise ->
      promise.resolve(telephonyManager()?.simCountryIso)
    }
    method("getCarrierNameAsync") { promise: Promise ->
      promise.resolve(telephonyManager()?.simOperatorName)
    }
    method("getMobileCountryCodeAsync") { promise: Promise ->
      promise.resolve(telephonyManager()?.simOperator?.substring(0, 3))
    }
    method("getMobileNetworkCodeAsync") { promise: Promise ->
      promise.resolve(telephonyManager()?.simOperator?.substring(3))
    }
  }

  private fun telephonyManager() =
    (mContext.getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager).takeIf {
      it?.simState == TelephonyManager.SIM_STATE_READY
    }

  @SuppressLint("MissingPermission")
  private fun getCurrentGeneration(telephonyManager: TelephonyManager?): Int {
    if (telephonyManager == null) {
      return CellularGeneration.UNKNOWN.value
    }
    val networkType = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
      telephonyManager.dataNetworkType
    } else {
      telephonyManager.networkType
    }
    return when (networkType) {
      TelephonyManager.NETWORK_TYPE_GPRS,
      TelephonyManager.NETWORK_TYPE_EDGE,
      TelephonyManager.NETWORK_TYPE_CDMA,
      TelephonyManager.NETWORK_TYPE_1xRTT,
      TelephonyManager.NETWORK_TYPE_IDEN -> {
        CellularGeneration.CG_2G.value
      }
      TelephonyManager.NETWORK_TYPE_UMTS,
      TelephonyManager.NETWORK_TYPE_EVDO_0,
      TelephonyManager.NETWORK_TYPE_EVDO_A,
      TelephonyManager.NETWORK_TYPE_HSDPA,
      TelephonyManager.NETWORK_TYPE_HSUPA,
      TelephonyManager.NETWORK_TYPE_HSPA,
      TelephonyManager.NETWORK_TYPE_EVDO_B,
      TelephonyManager.NETWORK_TYPE_EHRPD,
      TelephonyManager.NETWORK_TYPE_HSPAP -> {
        CellularGeneration.CG_3G.value
      }
      TelephonyManager.NETWORK_TYPE_LTE -> {
        CellularGeneration.CG_4G.value
      }
      else -> {
        CellularGeneration.UNKNOWN.value
      }
    }
  }
}
package com.devalfaz.worldline_pg

import android.util.Log
import com.awl.merchanttoolkit.builder.StatusReqDTO
import com.awl.merchanttoolkit.dto.ReqMsgDTO
import com.awl.merchanttoolkit.dto.ResMsgDTO
import com.awl.merchanttoolkit.security.VTransactSecurity
import com.awl.merchanttoolkit.transaction.AWLMEAPI

class WorldlinePG {
    companion object {
        fun getHash(
            orderId: String,
            mid: String,
            trnAmt: String,
            trnCurrency: String,
            meTransReqType: String,
            enckey: String,
            responseUrl: String,
            trnRemarks: String,
            addField1: String?,
            addField2: String?,
            addField3: String?,
            addField4: String?,
            addField5: String?,
            addField6: String?,
            addField7: String?,
            addField8: String?,
            addField9: String?,
            addField10: String?
        ): String {
            var objReqMsgDTO = ReqMsgDTO().apply {
                this.orderId = orderId
                this.mid = mid
                this.trnAmt = trnAmt
                this.trnCurrency = trnCurrency
                this.meTransReqType = meTransReqType
                this.enckey = enckey
                this.responseUrl = responseUrl
                this.trnRemarks = trnRemarks
                this.addField1 = addField1
                this.addField2 = addField2
                this.addField3 = addField3
                this.addField4 = addField4
                this.addField5 = addField5
                this.addField6 = addField6
                this.addField7 = addField7
                this.addField8 = addField8
                this.addField9 = addField9
                this.addField10 = addField10
            }
            Log.d("worldline_pg", "objReqMsgDTO: $objReqMsgDTO")
            val objAWLMEAPI = AWLMEAPI()
            try {
                objReqMsgDTO = objAWLMEAPI.generateTrnReqMsg(objReqMsgDTO)
                val merchantRequest: String
                return if (objReqMsgDTO.statusDesc == "Success") {
                    merchantRequest = objReqMsgDTO.reqMsg
                    Log.d("worldline_pg", "Merchant Request: $merchantRequest")
                    merchantRequest
                } else {
                    Log.d("worldline_pg", "Error in generating request message")
                    "Error in generating request message"
                }
            } catch (e: Exception) {
                e.printStackTrace()
                Log.e("worldline_pg", "Error in generating request message")
                return "Error"
            }
        }

        fun getStatusParameters(
            orderId: String,
            mid: String,
            pgMeTrnRefNo: String?,
            url: String,
            enckey: String,
        ): String {
            try {
                val reqDTO: StatusReqDTO =
                    StatusReqDTO.builder().mid(mid).encKey(enckey).orderId(orderId).url(url)
                        .pgMeTrnRefNo(pgMeTrnRefNo).build()
                Log.d("worldline_pg", "reqDTO: ${reqDTO.reqMsg}")
                val encryption = VTransactSecurity()
                encryption.initEncrypt(reqDTO.encKey)
                val urlParameters =
                    "merchantReqStrT=${encryption.encryptMEMessage(reqDTO.reqMsg)}&mid=${reqDTO.mid}"
                Log.d("worldline_pg", "Url Parameters for: $urlParameters")
                return urlParameters
            } catch (e: Exception) {
                e.printStackTrace()
                Log.e("worldline_pg", "Error in generating response parameters")
                return "Error"
            }
        }

        fun parseTrnResMsg(response: String, enckey: String): String {
            return try {
                val objAWLMEAPI = AWLMEAPI()
                Log.d("worldline_pg", "encryptedResponse: $response")
                Log.d("worldline_pg", "encKey: $enckey")
                val trnResMsg: ResMsgDTO = objAWLMEAPI.parseTrnResMsg(response, enckey)
                Log.d("worldline_pg", "decryptedResponse: $trnResMsg")
                trnResMsg.toJson()
            } catch (e: Exception) {
                e.printStackTrace()
                Log.e("worldline_pg", "Error in parsing response message")
                "Error"
            }
        }

        private fun ResMsgDTO.toJson(): String {
            val sb = StringBuilder()
            sb.append("{")
            sb.append("\"pgMeTrnRefNo\":\"").append(escapeString(pgMeTrnRefNo)).append("\",")
            sb.append("\"orderId\":\"").append(escapeString(orderId)).append("\",")
            sb.append("\"trnAmt\":\"").append(escapeString(trnAmt)).append("\",")
            sb.append("\"authNStatus\":\"").append(escapeString(authNStatus)).append("\",")
            sb.append("\"authZStatus\":\"").append(escapeString(authZStatus)).append("\",")
            sb.append("\"captureStatus\":\"").append(escapeString(captureStatus)).append("\",")
            sb.append("\"rrn\":\"").append(escapeString(rrn)).append("\",")
            sb.append("\"authZCode\":\"").append(escapeString(authZCode)).append("\",")
            sb.append("\"responseCode\":\"").append(escapeString(responseCode)).append("\",")
            sb.append("\"trnReqDate\":\"").append(escapeString(trnReqDate)).append("\",")
            sb.append("\"statusCode\":\"").append(escapeString(statusCode)).append("\",")
            sb.append("\"statusDesc\":\"").append(escapeString(statusDesc)).append("\",")
            sb.append("\"addField1\":\"").append(escapeString(addField1)).append("\",")
            sb.append("\"addField2\":\"").append(escapeString(addField2)).append("\",")
            sb.append("\"addField3\":\"").append(escapeString(addField3)).append("\",")
            sb.append("\"addField4\":\"").append(escapeString(addField4)).append("\",")
            sb.append("\"addField5\":\"").append(escapeString(addField5)).append("\",")
            sb.append("\"addField6\":\"").append(escapeString(addField6)).append("\",")
            sb.append("\"addField7\":\"").append(escapeString(addField7)).append("\",")
            sb.append("\"addField8\":\"").append(escapeString(addField8)).append("\",")
            sb.append("\"addField9\":\"").append(escapeString(addField9)).append("\",")
            sb.append("\"addField10\":\"").append(escapeString(addField10)).append("\",")
            sb.append("\"pgRefCancelReqId\":\"").append(escapeString(pgRefCancelReqId))
                .append("\",")
            sb.append("\"refundAmt\":\"").append(escapeString(refundAmt)).append("\"")
            sb.append("}")
            return sb.toString()
        }

        private fun escapeString(value: String?): String {
            return value?.replace("\"", "\\\"") ?: ""
        }


    }

}


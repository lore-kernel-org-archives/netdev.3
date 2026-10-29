Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793272279;
	b=Bn3jFs0yld0pKIUeRanhCmkq7mb6SYgJ54VYQ+JNou1czHByyMeQnnGfwXGDnEdMabq4
	 38N1nJoPT8vuPn3baG3MG8iUt2Ib7U+889Z6KM0v6vQCgR0kx67Dg8fYrCW3bf+Kf8UIq
	 dW5/qVFHDuo7nSZAGe9vkBvJfmYjxJnOCYhgLAUciXsXzHfjiTkPsCl9PXC1VukBQMfk0
	 C9XpVWXEazMHrM3hIfEWpNIYBUuKc65G/j+vpURKbW/7mOs73xJwhmUTeOcVRngY9loSW
	 gI12TGg0pFX0X6phgNQKgk9mqqttBdDcK0fs2lxJLVKZc31+S73vwaGHY2gOff0G52Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793272279;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xvIsNDweHBCtSTHMTawIeoOjWb1OTtE/4WnhwFaWBsQ=;
	b=gyg0SV0nqVez0o82WfVRXFKAjQy1UU70hqbRm0tJyxaGb+LeEmYz2+pH2L8NDl0aCHQg
	 WLWPWOyERY6tcVb7dlMXuyMsNeZtPNf98IZTVKxOcIyj2qZl6vun3eF4guBxolxU61Osl
	 zdU/MsGPnUR547Aa62gh0RbhkQJFFX0RYh87lCXRB6orNS3TfRUJp/a4vLTsUe/G0Br4G
	 cKMjozc2A5ZYBcGeMr02uXJmMj4o5bo1GVCBY+6O+07eO+WVChLJ67yYEyIEvFz6K/1JK
	 I93l2xDpmqdIZ+acsQzuhqeufGv9jkR+PBtP0w0aWrTXTyPqr/nc028t3MYOI7PTEew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C2a5xaSw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="O+3m/h7I";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AB6606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05AB6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C2a5xaSw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O+3m/h7I
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TA3jOv3607116
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xvIsNDweHBCtSTHMTawIeoOjWb1OTtE/4Wn
	hwFaWBsQ=; b=C2a5xaSwSSEgUjAuMOhFvycUmxAD2CSNT7lifxYcgzUfh+wL8wi
	HVNqAqdYmq8cfrgvoc7iu44N9xlwzgFZYUuo5BNTrbTxYrtox2VaXGh2xdX8hrCw
	hrI6GFvObLa1AyZO30K7sPa/8+NsVJsuDsmtyixEuszMm6rUvlaNwq+gupqFEqqC
	CMEITGty+wGSLt/bOo+nsMU7HqZeBvfEfe+xMPERL7Pp+JJXJQfAJuUTetIfNhEE
	cf0WM0d5DvM6QD+PoiwujcDG396BSK+hs4iQuJruZ/malGbdsXFuRcT/ePa3JBSW
	oqQwrgSOXbo34MzJYyzcsNcB7KaUsKTD9vg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm42fg7qu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:11:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f2c0e6653so159230685a.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 04:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793272277; x=1793877077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xvIsNDweHBCtSTHMTawIeoOjWb1OTtE/4WnhwFaWBsQ=;
        b=O+3m/h7I2RSg6Jykt5bGXTksXjHoGdNHCyEw+NhlepGKFUsMxojmxhqlWmkjJnV/Rq
         7bb5v2x2jqcb7kK1SMLdG6vts5Vxv5ah1xcCFAkke+VtOIDnJWhzShtlMZZwo8RyKImr
         pbb1QpwAWwO5IObHKXhG1gU+2baTrKSrhlG2Fj6XqUt/8Tg7mjzPXeGPWWjIB8XZsTDL
         eLuPQTlciT//8LqBP6DUW7vANhZIPx+8tPlqJ8kMKYt3CHju5vBJHR5ndWWW0lgvLQJb
         aY41UpRsT5DNCwXhFA7eKwEpM1SyzXjsvFazvZzQyJ/VPUn6YYTwhCne6BWcYrVFzhiH
         vqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793272277; x=1793877077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xvIsNDweHBCtSTHMTawIeoOjWb1OTtE/4WnhwFaWBsQ=;
        b=YXX0ET4Ti18JILNjW2QNpQ8icAsFn8a3TihE+eCoTXpW8Dlv5nptUD25h6XIkCrfDG
         njkw8U93RKzv4EgTYhnsT58Y4sMq0rm/XURiBffm9i2ZRvGGZquPFajNgBVVOMNVoiEB
         M1vb57oyTAydYr1qs0ItGLjDE+z05PxnqOAM0O0Gtb4794SAWsBFvrQkZGw9ENTlPacD
         nOxvASll5JbS8RDWUeNM01OkW9fia8z9bDMFaWIzuQ6KBuFLE3N6wRUcPeRXhbccMpnM
         MbktzLNqoFq77qKO3RNKffp3KNG5w2lfKtO+/H6gJ2ldRCe45rI6EYMq2XCM/lI9EbkP
         qOgw==
X-Forwarded-Encrypted: i=1; AKwUvBwBPrveXnirLRld3ftF3ASN40cs+05YGzrT4c2WmLXGldxFV7wOYYsD5GX9gDm+gQpHq4oEH6o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLN0IvFX30n0JdqBE0y888fDsp3rRGxdGLrB1BAWGCc7i4X66Cg
	Iz8oMscG4tUw7hvjXtL/o9uzLfm2o5XjKAMwYBDG4iJhnVwo+fLJnO2vx9cxyOKENflL+zRg+yi
	n+g/NT+uUj2kVh4p3TpMC7i0Pio8osiYDUDNdgsG+kVoOuU1oMeOus2PwAy8=
X-Gm-Gg: AYBFou14ftCvZIC/EbFqL+7pt7JB9ryzl7cjW+tJ/CBNj0CWu+7fpC7O/fIQ4Rh/Ww5
	0LWuvhcqGkP7+RCkMUhpIGmayy/9jRGfmY+j4Co1OeGqWkw/jsYDuncDNm3ZKhXRPLPaZnch+lF
	t1o1xYkz97DWEf9ouF95Du8DczKR6wrR9xN1+2VL5l9r29/NaKV06nFAPmkWkdVEPJonNdbx+rY
	R4ClZOJTBwbaZrpYLO32VGQ+Kr/PecCidjApa0Ho5JFDTGqPKVTzG2Gd5Z7wotYlMtna4k7URAn
	Bmf0UwjGtRFwGr/muJaIjcHNIIJfAN0p78KMqOW3s/Sbpb38Cud7P86wV5OLo85KybBMppw6+x4
	h+oYSGTXsGMMcf+FtsSpPYXwsc2bUB9PrsQY5pIzP9JPpPS7oWgJK/N6+n/L9IQ==
X-Received: by 2002:a05:620a:4553:b0:93e:e175:ee92 with SMTP id af79cd13be357-94408d42475mr785080585a.39.1793272277137;
        Thu, 29 Oct 2026 04:11:17 -0700 (PDT)
X-Received: by 2002:a05:620a:4553:b0:93e:e175:ee92 with SMTP id af79cd13be357-94408d42475mr785076885a.39.1793272276717;
        Thu, 29 Oct 2026 04:11:16 -0700 (PDT)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94eb8dc84sm45707065e9.2.2026.10.29.04.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 04:11:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] net: ipa: Drop unused qmi_elem_info arrays
Date: Thu, 29 Oct 2026 12:11:00 +0100
Message-ID: <20261029111059.85020-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2618; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=7I0Y7JHmJ29bNgzq7Jmf9HeVPua9HONMiPF5u8lP2+Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq4ynDRfNne/u3D58VUP/DTooW+TgoYSjkrWBQk
 qUq3Ce6woqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCauMpwwAKCRDBN2bmhouD
 12hDEACG5WcuL2D3Li2t+0dIcJbpZYDsQq3Ri3KL6102x/pbMuqWhTrsH1uz+mzlvxkFnCu6xbj
 xISVGGGCKIFoYnM8SQbTkRnYjXQUFY3DGEuxFf0YznXY1+r60X0NX1ony/tq1vXQH2bLy4sNbn0
 ojYWUaDKvheojdWyBU5zlN8wrMqUlFGu1UIcBV82pxLOoscb0HP0s/wAgra6cPdqvFnud7XO+bF
 4sUhrmIatwWSvODgWGTS1V1VzeyNtOL6BHJvsTOIwf3lWJKCJYgoaA1ZS/7xIJ1lFUoLxrqcIhM
 VFdczVIWMftQ3+NAmDSppluo8Jq6+RU7foIOdg2kcu9M04pBVxB1ztYTFeevtCoLLlLc1OvIa+u
 6flzSYwLMHv8G5w4J1XD+/AbNR+DAUOYTx/Z0q2uZpk9aukY3wurvHpxkwKx9oHlMshc9VtRUbc
 bgUAuMu37EMbKhQRZACF39mrhbN8ELAOEWXUdyPdCDJfETZqLggp5n8oVWWcCpRVVqTOUQ5+WMn
 hxGYb6pGui6TBuDicd95nuEMj+GmbVvRqCfxybT6zPm3WlAdUZ9ca8Q0X+gQjPJ4+eXGfeuZYlp
 7J2ujdEOwbkSPdrzS6bSg+xFDqtUA8oaa/NXEu7OQhPlJjkzX9J9s8R0Dig9NBK0CXxHMZaHgno U/ejEa5jYUhZkbg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MyBTYWx0ZWRfX8DitkjnBl26Q
 dghpIoce0hd/qIEewbdIrFrezmEzb0LFVzylJAtpwwFM+aHAVFo18l8c8pjxYek5EBpuPrWG9bO
 4me9Gr3WwsFyGI7mfYNdkANwrdVO7oNmifE3HKxkzjSnZtvgnIsXX5FEd/4MVb806q2D4cpsWk0
 kBCC1V1tWqtI32vtRlFV7n8A4BMVV4djbbOM/VvR82GCErcmFveUvlzgYcTnJxUDwY5TcMJO9m7
 fgpyGy0xN9oKvbDdtXO2BjwiMmvRcO59DVgQcRrZy/5Rv6NwK4nL3bL08xynsFs6JzmfQ350yi2
 bwFlDHC3AKLVOZKfVpkOgS2ymOg06Qc/vKF0bwMnUtznueiTcGLD3B9803ToxAgtRmiT1A9CdBH
 NiOK53hBUfzK9ljqnFt7eJaZy89BKtUa6P8gyuOxCAq/lB8RVGeRaqfDuGzQD+VP/L9hinJz7fp
 jVbTLl9qlhQ1z0j4CZA==
X-Proofpoint-GUID: NIDoreAsmNxGaJ2B6-eSdVXGmrf6Z1f7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MyBTYWx0ZWRfX1Pl5deVenL+m
 nC3U+bRYq1d3kDIY2F5jn3HPX5veuL1r6TpJkjlY5uanNiJhutv2gUIb/Lypcy2YyWOkrJ9T8Rg
 /8Mmftywt/Q41QNeyBfJxZtteu9L3pw=
X-Authority-Analysis: v=2.4 cv=UN9Ijyfy c=1 sm=1 tr=0 ts=6ae329d5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=KKAkSRfTAAAA:8
 a=e1SKIdZ0hHplv5p4F20A:9 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: NIDoreAsmNxGaJ2B6-eSdVXGmrf6Z1f7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290043

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

'ipa_mem_array_ei' is not used anywhere, so can be dropped completely.
'ipa_mem_bounds_ei' and 'ipa_mem_range_ei' are not used outside of their
units, so they can be narrowed to file-scope.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ipa/ipa_qmi_msg.c | 25 ++-----------------------
 drivers/net/ipa/ipa_qmi_msg.h |  3 ---
 2 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ipa/ipa_qmi_msg.c b/drivers/net/ipa/ipa_qmi_msg.c
index 51dc13a577a5..e2401d8475b6 100644
--- a/drivers/net/ipa/ipa_qmi_msg.c
+++ b/drivers/net/ipa/ipa_qmi_msg.c
@@ -188,7 +188,7 @@ const struct qmi_elem_info ipa_init_complete_ind_ei[] = {
 };
 
 /* QMI message structure definition for struct ipa_mem_bounds */
-const struct qmi_elem_info ipa_mem_bounds_ei[] = {
+static const struct qmi_elem_info ipa_mem_bounds_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_4_BYTE,
 		.elem_len	= 1,
@@ -208,29 +208,8 @@ const struct qmi_elem_info ipa_mem_bounds_ei[] = {
 	},
 };
 
-/* QMI message structure definition for struct ipa_mem_array */
-const struct qmi_elem_info ipa_mem_array_ei[] = {
-	{
-		.data_type	= QMI_UNSIGNED_4_BYTE,
-		.elem_len	= 1,
-		.elem_size	=
-			sizeof_field(struct ipa_mem_array, start),
-		.offset		= offsetof(struct ipa_mem_array, start),
-	},
-	{
-		.data_type	= QMI_UNSIGNED_4_BYTE,
-		.elem_len	= 1,
-		.elem_size	=
-			sizeof_field(struct ipa_mem_array, count),
-		.offset		= offsetof(struct ipa_mem_array, count),
-	},
-	{
-		.data_type	= QMI_EOTI,
-	},
-};
-
 /* QMI message structure definition for struct ipa_mem_range */
-const struct qmi_elem_info ipa_mem_range_ei[] = {
+static const struct qmi_elem_info ipa_mem_range_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_4_BYTE,
 		.elem_len	= 1,
diff --git a/drivers/net/ipa/ipa_qmi_msg.h b/drivers/net/ipa/ipa_qmi_msg.h
index 644b8c27108b..1924ac2dfa90 100644
--- a/drivers/net/ipa/ipa_qmi_msg.h
+++ b/drivers/net/ipa/ipa_qmi_msg.h
@@ -253,9 +253,6 @@ extern const struct qmi_elem_info ipa_indication_register_rsp_ei[];
 extern const struct qmi_elem_info ipa_driver_init_complete_req_ei[];
 extern const struct qmi_elem_info ipa_driver_init_complete_rsp_ei[];
 extern const struct qmi_elem_info ipa_init_complete_ind_ei[];
-extern const struct qmi_elem_info ipa_mem_bounds_ei[];
-extern const struct qmi_elem_info ipa_mem_array_ei[];
-extern const struct qmi_elem_info ipa_mem_range_ei[];
 extern const struct qmi_elem_info ipa_init_modem_driver_req_ei[];
 extern const struct qmi_elem_info ipa_init_modem_driver_rsp_ei[];
 
-- 
2.53.0


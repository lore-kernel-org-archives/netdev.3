Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268E84B1262
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471111; cv=none; b=U7+0nWPVnJ85w8Nn2AAFP9tUnyq6WWxXvc3T/SHO3ZG12E8dFcZHYGcHC8bMrUiSYILoPhkkz3uVmlOm+tHb+6vWhehrmRpeWAxyJCvwsV6Z7yGpgt7eO2HmjAR+4n8pOyf4lItyMRNeFXmhyrX+GkatG7TCR9ggrudsD9IbvSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471111; c=relaxed/simple;
	bh=Fc8DPTCRSdH6TiRTxXzABfwA6hiMN7wUWSgkQoT/pb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eMiJCNBFAJKZtK0A5pgFFA7g3xEL+Q5Pwu8Lj7xULy3nZce1ioPsCP/1GtN10daByk0AzzHN3fE+QyIuVRfaJRgKWGOCd7eprkHlkjYZ1i5QmbjQNhQSvmaUZX6BaMaGuNrDzjtObhe18t5TllmGa5GcvnleyVpalxqKp476qXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mxMNi3XD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Oj34WcjE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mxMNi3XD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Oj34WcjE"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698EVwRN3517996
	for <netdev@vger.kernel.org>; Thu, 8 Oct 2026 14:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W5VbzzqxEuqAL7ZI39slBiv+oJQ2DZO8sYucQl9fLu0=; b=mxMNi3XDSKq9VvA9
	usoQYlGxvEmlWbFIgEhxTehCA7RsC45S+kTlLW4U7XY5lM8ZbEHWhJf60cVcAt6E
	3wnE33TKS+uJ/8Y7zTLlBs/i/WZE96JPur0elsF5RK0MKkyCYLpCo7xK6QwEpwC3
	Bcd9Cda5VaNMpExtGgH2lF3CCMDg2dG3IPrNOlfDoCyVY4QuZNvEVLNNAAAchrqN
	gCN7hOBJFOt+Z2PReOdpAyUCEcTeejU1sTQtZMnm2eWqLkk1Bt6N5AebKxWx2H3Z
	V+SHrkZxNh5hTxSKKKAemIZi61ia1M6kyoJunE2SJlwadsySkWP120qc3mBuGP0z
	QKxFXQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe83ar8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 14:51:40 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-837aaa9a3f6so9893297b3.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791471100; x=1792075900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W5VbzzqxEuqAL7ZI39slBiv+oJQ2DZO8sYucQl9fLu0=;
        b=Oj34WcjEXliV3xIhdjE8IZPsZd6OE42CXQdBfExpqLTLzYhdI2FrpoVn6ynH9h/nHd
         Flu/LoDMRf7uNoESviCoEn0knGaXRlBK7zaGqfYeuSCb+ogeb26Xu1nY9LCjnu07vqHH
         UiUdW4pOdDWXwlJCEX+7l4T68TXtGa5YzxogIbaSmM1ZxnxiIT4LnX8cQWEpcMRTl/hK
         hDRbK3T41HQqwZIeObLXGn9wAGrVhKrYMfQ6iqfe0/WuFerYE8As50tIWRWCDXg+W4F1
         zJJwxfJyyhOHCSM3opMGld/3mQp0XtBGH+wkQxWtsAequLrU5O4EaoxwB4TIe2JY1V/7
         4DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791471100; x=1792075900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W5VbzzqxEuqAL7ZI39slBiv+oJQ2DZO8sYucQl9fLu0=;
        b=VTPfhFQZXQiBjfNFV3BP9PW++h3r4DIS3m0MARSpmEEjO/WeZn84MTMyYkkfDft07m
         4u/WawREBuSx8/xK72bMlDSQXMgkZYbZxliKry4thonuXWp4XrQTSpkjInV+zmKMImVc
         iLEyyHjJoJinhEetcjf/kGrM5vKYUOAhRvzbsGOO4MbMb4EQqJSX8rJu17szNKPnY2RT
         45Jp0DOMcibuZL2pk8OTf9P2+ZKZs/QknFFCujZuFKsLmeyYcql4T22AbTmaHThggyvx
         GbGQlr+obPJPx+9WS6KqSq3Czvb1TzalW0wDI3rsUF86TPZ9gEojcmmW+ERDhF+/6HpW
         9bAw==
X-Gm-Message-State: AFuF++kHUDx4FWN5A+OFXjykizyHBWOPQ92cqHdy3t9n3HKJOq7hkaia
	9P+NnGP8E8Zm9g++/Vq5S6bDC93saME0LQg2J6DLnhldJwkMztgoK/QTOvJZdcHK60I/yKZ8ruL
	eQep1vsty8TQSkwpkf7XFwSkJcr7VJ1hgs8SOvWOP+9sEmY5qJMJMx1BCG0E=
X-Gm-Gg: AYBFou0ldcx8ZG4pyh15SjdaFYoHPdvhk8QDMFYqF1lDUXjh4W/1y+C+G4vsLp5BxtH
	PrBvLpT9qsqIPNs/6WTf60Z47zzZK8AhRnRYJyU0qEel8YWrMttKWUK9Qd6hV7Pd7u2eTz8eVr/
	T39zdWvZsLxo1e6exBruodOgo7EMFZH5g3J4zgueQDm8+fMbi/UoFRLpU1NbrsUvoL3cZUC/Ziz
	VFSpyRr44Y0k7+hfjgEXvHqg9jSXWHPZUqB2n14pbeP/MAPTrJA+zbTwZUKUFGLZ+Eo1D4XHyDg
	E1/tcS35Qv96XoAFzZ0egWu2iP7EktY2t6wHlFewzahiukEurNyNbkvsz8q9/+2XKI91WLvqNFQ
	33TjZdEkm4Po0CZsFVPKXk3Uc9isWkjEtpp3/sHYKyW0=
X-Received: by 2002:a05:690c:39d:b0:87f:32fa:aa08 with SMTP id 00721157ae682-8b06e42a786mr13089817b3.14.1791471100113;
        Thu, 08 Oct 2026 07:51:40 -0700 (PDT)
X-Received: by 2002:a05:690c:39d:b0:87f:32fa:aa08 with SMTP id 00721157ae682-8b06e42a786mr13089497b3.14.1791471099385;
        Thu, 08 Oct 2026 07:51:39 -0700 (PDT)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b05ab62607sm20903407b3.22.2026.10.08.07.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:51:39 -0700 (PDT)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 07:51:33 -0700
Subject: [PATCH net-next 01/11] dt-bindings: net: qcom,ipq9574-ppe: Split
 EDMA reset into sys and apb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-qcom_ipq5424_ppe-v1-1-16caf43e44ee@oss.qualcomm.com>
References: <20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee@oss.qualcomm.com>
In-Reply-To: <20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lei Wei <quic_leiwei@quicinc.com>,
        Suruchi Agarwal <quic_suruchia@quicinc.com>,
        Pavithra R <quic_pavir@quicinc.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, Luo Jie <jie.luo@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791471094; l=2271;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=Fc8DPTCRSdH6TiRTxXzABfwA6hiMN7wUWSgkQoT/pb0=;
 b=b+FpFRVL4POiYtkzHxu3F+D0thVdUcIWdbmDDfdbjkg6daS+Aig9EGSgJwCFpKD+HAcwR430s
 EDNzq1gNVbOCDT5MxBO6gBENfqK7kpAjXDKvLIHd1biYWQWbM18/0j6
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1OSBTYWx0ZWRfX0etwOvvHiAvp
 ndxmGI/HoYVEQWWUIlepcu+Bmh/ALXg9C5HU0gSvvtt4oJ3aKf2L0BU+TC91nupBgk96GV9bAzK
 6/GIaU1KW/D5a50tMncmTTHlIsM8pP0Q+KISQX4ICsZBKNX5Pob+7pSMQpnyelxnAd9BT812HNy
 6Eh5Voj/sVMNN7srTlwl2BtArHqMrgZ0HxtPkLc/bIrKkOqRUkgbysuNt1d7F4fNSdbuPioxGPG
 eLfSK1S0GMBSHMNOTfwqZu6J9ATqJ2JPt7saomi2vgey/RWQ7myzuk20rS1gZiaDJPJUWKlBJ7P
 78LIMj09vSDY1q2hWd+NCv1EQF5+K+xMi75Yb4Hws4xXX7ddrAvd0BSA3WWfqwMOpzjtWj5L0D0
 BPFVEti2rMiAfn2nO9s2PFdMrJkeeidBBIVSjNh4/7PH7fZMPZMKkVLkfjg6OmQH2BEZGWg8Mmf
 sydFBZNTk5P8VCSCoww==
X-Proofpoint-GUID: vrSbu9RWpcCQly0ELGMbRj_OnkzhHc6s
X-Proofpoint-ORIG-GUID: vrSbu9RWpcCQly0ELGMbRj_OnkzhHc6s
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1OSBTYWx0ZWRfX0n80vEVSb1h7
 E+Tc9VObcUzJDX5CYrVHOODhmLVJlh2dnZD/eYPUh4dXC2OMDMVVH1dk6TBAj3M6lxiS54uledQ
 7DZvP7b0K+hmOcN/pujMhqHMnsmyEJk=
X-Authority-Analysis: v=2.4 cv=MPT1C8Zl c=1 sm=1 tr=0 ts=6ac7adfc cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=0cszTrF_nvGlpc-19gIA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080059

The EDMA reset is described in the binding as a single reset, but the
hardware has two separate EDMA resets, the system reset and the APB reset.
The reset used in the example is a combined reset that covers both of them.

Describe the EDMA resets as two separate entries named "sys" and "apb", in
the same way as the EDMA clocks, and update the example accordingly.

The EDMA driver has not been merged upstream yet, and no in-tree device
tree uses the ethernet-dma node, so there is no existing user of this
binding and it is safe to update it without breaking the ABI.

Fixes: 1898fc572118 ("dt-bindings: net: Add PPE for Qualcomm IPQ9574 SoC")
Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 .../devicetree/bindings/net/qcom,ipq9574-ppe.yaml        | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
index 6d0b21a10732..c899f4b56945 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
@@ -144,8 +144,14 @@ properties:
           - const: apb
 
       resets:
-        maxItems: 1
-        description: EDMA reset
+        items:
+          - description: EDMA system reset
+          - description: EDMA APB reset
+
+      reset-names:
+        items:
+          - const: sys
+          - const: apb
 
       interrupts:
         minItems: 65
@@ -170,6 +176,7 @@ properties:
       - clocks
       - clock-names
       - resets
+      - reset-names
       - interrupts
       - interrupt-names
 
@@ -273,7 +280,10 @@ examples:
                      <&nsscc NSS_CC_PPE_EDMA_CFG_CLK>;
             clock-names = "sys",
                           "apb";
-            resets = <&nsscc EDMA_HW_RESET>;
+            resets = <&nsscc PPE_EDMA_ARES>,
+                     <&nsscc PPE_EDMA_CFG_ARES>;
+            reset-names = "sys",
+                          "apb";
             interrupts = <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>,

-- 
2.43.0


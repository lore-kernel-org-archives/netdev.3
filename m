Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD9D4ACC93
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471119; cv=none; b=K19d9eS8cUydp1XxmDeAVgnEIFZW0sECssusatkwZQiu5F/CVDc5zLJ15u+XTLL6e2VFagjpy8do7cBAUgP7uWSTBQTU9TciczkLNk60vNS46AemmGDs6mnGnc9EOTWoqOHbR7rc0pUdbMq6hbEl6vqrxXVEUHdU7syKpGb+dQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471119; c=relaxed/simple;
	bh=4ejXIHXllm/OX7toaawMvjc9fLMF06Wvz+3UPeI3Nfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fC/MBnxyRpJzJONWQL4Ntr6wqCW2XAVxR4i6jNgSTsRAckXXLCv4h8LGNMbjzhSUAyc87wurqIqFLqJwXQFwrqe8HFsar7jfDcK88dessSfb6RqRAGhcO0rXzuVS9asWdyBA3MJBVWzyCrUzo1ut210sJgT9+VvDTzy3Wjt2ffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d+trr0U4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CQKNfogD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d+trr0U4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CQKNfogD"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698EVXUY1685111
	for <netdev@vger.kernel.org>; Thu, 8 Oct 2026 14:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p8wa6N7QHPrG2N+PjfUfKP3nkKREIO0fyU3OWbjBzVg=; b=d+trr0U48J1ceIBI
	sbH/u7BnmaaXMuyqqnIrEtMudn/2iGiqQlxC8DRPlrWBq13xIvaTkXAeIgJQyyjd
	mO/eixiI7lmRCM3Axvs8Pn7VjHU/GxCa1pbPPnuClAIGr+HJr+b8ISTXLyY7QNw8
	6xqhMWJQMuHpfFjl6xhbgJ4gWYroCw6REJKsFFra33zpuiqSMjkw5vDzC1Ls+HlO
	D8FY/QfQpI8Ya6BHUjIbhcg1XE3SA/jV3Ns3t1n1TYKhKUlAdyy7MYeX5zQdqTkE
	7u9PhHDXLo0DmnLnYjVz4KYgOdoRMumMvFvZ8hP8akG/VDse8iyF8XjdkOGATNXp
	vdkuUw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe33a4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 14:51:46 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8ab4b1c09e3so49443387b3.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 07:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791471105; x=1792075905; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p8wa6N7QHPrG2N+PjfUfKP3nkKREIO0fyU3OWbjBzVg=;
        b=CQKNfogDOT0+8vgTXK7zlfikX5Is+Sf3zEJj8bEPlQnIqBN7/FOkVjEiwNN+243NKZ
         g6zBPEc88M09Rp4oml2ZNlHpH8cimLtocgVYWxxCff7w89E88RWrULsR9igh1EQpmzrA
         M62HeJcGUfymFQTqcPtWRz2PA7OsQFbA5KmZZQaCSdqxCKRX5ixRn3dbZX487e2VRnvB
         pJtmeYy3A59GMUPganC/FAetYR0u9NW4bGeR7ErfgdJStIC9LLvdqkdXFLimSM/FKyJc
         DIKkz1hUIszIZGilvqezHZ5uSlgXqMnj/FQZAQa/eY08U6s65XZ95rNMBD5c7SR6oCK5
         s1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791471105; x=1792075905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p8wa6N7QHPrG2N+PjfUfKP3nkKREIO0fyU3OWbjBzVg=;
        b=z1RonWEGrErNx1gJ0TleXzj5HCGBYpFgsNn+jiVWe3YPo3UPp+UMZoJhUNdNGIqKfe
         qW8K1yWprxhYwD4/Q09bS+mCxoo7jqu0CKlD2OZYVr8tJzvex1Mhpf7zD1uKCN9ksfEq
         mVUjB3IiqCw1J3eZJR+PNakiNgp2v3vbN98FJbUqY+pNB+tHU2aj3naLNnUI5tloapQn
         z9INBWZHBt98bovHXfXx25RkB/L8PPEmoMyOaU9qs1SXMtPwR3SzVdxU/0SSmK4wWqpk
         sx9czi81pMBLCUMHK8w+4yZSBjxe19UFWwv9V2EDQjgjB1Xy9vKtyu23zsUMyNo8YyhP
         jZpw==
X-Gm-Message-State: AFq9FYK/AN1R3abUDykxHme1Zl4++GjvFv0F2Ums2M+wKwKqviFLg/et
	jAT4/ocljSciKdAqtJZZSg5+1zTkyMw9RHAWOvM+umXIQOagm3FAmwdO/A0Ad9EgrdE/6/7AXgX
	PrBX9gOmYcvIOfIaeK8ZH/78aSQo7zAQG+eKTE21fCa3vYRP+RUffvtmOAXo=
X-Gm-Gg: AYBFou3lLi3nAwerRXai6fup3hwFVk/+Aq6HOo658lrORVqeBig6x8qxG+iXhI2IxMk
	xGjcx3Nvf7Aav7knesHDHnUXI/RS2d2flskzVkAGwnI8NVeLwzlgLifRofMQN5ucRxm2VywOV+z
	6gArMp478+Lcd5NxpiTfLCpOjmu9w7GNvgY+3lV7qsvbV9YGLCEqo/SKArG5Y5Yq6QGsN95TJgr
	01HhQgAA0GgN7ykfRZZc8KojsQ1dgKDxu4ZnRE0nWzzhuQpoBtQNXWwEMqwg+lW5nqKBsnfagbd
	m6EtALgrTPQLZ703fH212Efs4L427a0+0XA2zIrqz7rGDXpP2Kf1cJ3HW9czRZg+up2CdDer8sq
	62+0GiQ71pGEAMKFUBQOW56n2KhPiMiG1WM0tKrs2E4U=
X-Received: by 2002:a05:690c:4902:b0:866:7724:3bcd with SMTP id 00721157ae682-8b05b01cd14mr39157307b3.16.1791471104961;
        Thu, 08 Oct 2026 07:51:44 -0700 (PDT)
X-Received: by 2002:a05:690c:4902:b0:866:7724:3bcd with SMTP id 00721157ae682-8b05b01cd14mr39157097b3.16.1791471104208;
        Thu, 08 Oct 2026 07:51:44 -0700 (PDT)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b05ab62607sm20903407b3.22.2026.10.08.07.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:51:43 -0700 (PDT)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 07:51:35 -0700
Subject: [PATCH net-next 03/11] dt-bindings: net: qcom,ipq9574-ppe: Add
 IPQ5424 PPE support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-qcom_ipq5424_ppe-v1-3-16caf43e44ee@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791471094; l=5017;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=4ejXIHXllm/OX7toaawMvjc9fLMF06Wvz+3UPeI3Nfs=;
 b=L1EmTXZqUYIEviKnSUJ5xS6ppzQFL+i8pPyCv4ceiHPry+wkpyFsjyroR8d4yQHm0JMNe8Ls0
 B0+V2ALB2R2DMPhBFO74PZ5az02oFHCSix/DSKQjPlWanVZJIfaCfrH
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1OSBTYWx0ZWRfX12noR99CAQR5
 wYu/pmpZNLQiK110rFUS5Klm7kW4N7UwUO5X9K4PNIlwrQqJKSlWP1XX0J89IGskmULV9XvU/vF
 Muv0XFNuWTItK7p2PrQW+ycf8JU+cyTsvupoB9t3laD2d1uqsUvoEpNLTKr6GxzVhhYrB9/iLTh
 DICZTxLpuhW2pxAGFnSZyC2fLAzEwV48KxtnnDyq6mp7lillpyU74OEUbF4BF53t558crhz/vfI
 +n+cIqurSng6rNBgfSFWUW6zQAgSHZj0X7ZtkpYrfxre+RuTU+cbp3U5dqCZDnf3RpMiqOJZeF+
 Njnao8JqrEn/0WRgAp60WaReNApvKdl6LR/vS6bev8ZXHBQs4UIiKGvAnMA5x3OQUIms1Hc7ja1
 4kIdSEnWAccW5FfUKWuy63l7tPW30ZP4hW6oGJsxUJDUcjvyDMn3J4pZdUGEoMT32Rh9lb5fZWJ
 lXKzgM2nwG3UGmwjdkg==
X-Proofpoint-ORIG-GUID: _yBifqGnKGDRJ82VwhTZRvp_sEv_A9mM
X-Proofpoint-GUID: _yBifqGnKGDRJ82VwhTZRvp_sEv_A9mM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1OSBTYWx0ZWRfX1EEmPWf7Ox7H
 di2oLV9kjVNOYhO+UfiM3iC1Scqw4613dkLVLJnle8v1QabXPG5xLJjYdgr+pZTFM8jMuuIMvQy
 A3uHsswuYJNUJLwJMUREos6CBeoe/vg=
X-Authority-Analysis: v=2.4 cv=KcdHIgYD c=1 sm=1 tr=0 ts=6ac7ae02 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=88jBO_RzNVI78HEcs5sA:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080059

IPQ5424 integrates the same PPE switch core as IPQ9574, but requires a
different, smaller set of interconnect paths, and has only 3 front panel
ports plus the EDMA FIFO interface, without the EIP FIFO.

Add the IPQ5424 compatible, describe the interconnect paths of each SoC,
and limit the Ethernet ports of IPQ5424 to ports 1-3.

Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 .../devicetree/bindings/net/qcom,ipq9574-ppe.yaml  | 87 +++++++++++++++++-----
 1 file changed, 70 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
index c899f4b56945..e5d218fc5d82 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
@@ -74,9 +74,14 @@ description: |
     +------->|             QCA8075 PHY             | | PHY4  | | PHY5  |
      (clock) +-------------------------------------+ +-------+ +-------+
 
+  The IPQ5424 PPE reuses the same switch core, but wires up only 3
+  front panel ports (GMAC0-2) and the single EDMA FIFO interface; it
+  has no EIP FIFO and no ports 4-6.
+
 properties:
   compatible:
     enum:
+      - qcom,ipq5424-ppe
       - qcom,ipq9574-ppe
 
   reg:
@@ -105,24 +110,16 @@ properties:
     description: PPE switch miscellaneous interrupt
 
   interconnects:
-    items:
-      - description: Bus interconnect path leading to PPE switch core function
-      - description: Bus interconnect path leading to PPE register access
-      - description: Bus interconnect path leading to QoS generation
-      - description: Bus interconnect path leading to timeout reference
-      - description: Bus interconnect path leading to NSS NOC from memory NOC
-      - description: Bus interconnect path leading to memory NOC from NSS NOC
-      - description: Bus interconnect path leading to enhanced memory NOC from NSS NOC
+    minItems: 5
+    maxItems: 7
+    description:
+      The number of interconnect paths depends on compatible, 5 paths for
+      qcom,ipq5424-ppe and 7 paths for qcom,ipq9574-ppe, enumerated in the
+      allOf conditionals below.
 
   interconnect-names:
-    items:
-      - const: ppe
-      - const: ppe_cfg
-      - const: qos_gen
-      - const: timeout_ref
-      - const: nssnoc_memnoc
-      - const: memnoc_nssnoc
-      - const: memnoc_nssnoc_1
+    minItems: 5
+    maxItems: 7
 
   ethernet-dma:
     type: object
@@ -182,7 +179,7 @@ properties:
 
   ethernet-ports:
     patternProperties:
-      "^ethernet-port@[1-6]+$":
+      "^ethernet-port@[1-6]$":
         type: object
         unevaluatedProperties: false
         $ref: ethernet-switch-port.yaml#
@@ -236,6 +233,62 @@ required:
 
 allOf:
   - $ref: ethernet-switch.yaml
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,ipq9574-ppe
+    then:
+      properties:
+        interconnects:
+          items:
+            - description: Bus interconnect path leading to PPE switch core function
+            - description: Bus interconnect path leading to PPE register access
+            - description: Bus interconnect path leading to QoS generation
+            - description: Bus interconnect path leading to timeout reference
+            - description: Bus interconnect path leading to NSS NOC from memory NOC
+            - description: Bus interconnect path leading to memory NOC from NSS NOC
+            - description: Bus interconnect path leading to enhanced memory NOC from NSS NOC
+
+        interconnect-names:
+          items:
+            - const: ppe
+            - const: ppe_cfg
+            - const: qos_gen
+            - const: timeout_ref
+            - const: nssnoc_memnoc
+            - const: memnoc_nssnoc
+            - const: memnoc_nssnoc_1
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,ipq5424-ppe
+    then:
+      properties:
+        interconnects:
+          items:
+            - description: Bus interconnect path leading to PPE switch core function
+            - description: Bus interconnect path leading to PPE register access
+            - description: Bus interconnect path leading to CE AXI
+            - description: Bus interconnect path leading to CE APB
+            - description: Bus interconnect path leading to NSS CSR access
+
+        interconnect-names:
+          items:
+            - const: ppe
+            - const: ppe_cfg
+            - const: nssnoc_ce_axi
+            - const: nssnoc_ce_apb
+            - const: nssnoc_nss_csr
+
+        ethernet-ports:
+          patternProperties:
+            "^ethernet-port@[1-3]$":
+              properties:
+                reg:
+                  maximum: 3
+            "^ethernet-port@[4-6]$": false
 
 unevaluatedProperties: false
 

-- 
2.43.0


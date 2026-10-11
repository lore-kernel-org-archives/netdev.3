Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F24A443E24
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723791; cv=none; b=JLXsRP6FXUUGjc94n74EkT2aK+c9U4TOvY2XkHT2V3TemJh06saN9lUS3Lcv/5eyzMOO6nmi0KsN6m0ZhZ63TCtVpTPl3XEbjzurvB4zNsLgQ0Dlaluq4XvzR38odhBoakj/GAGlhGqWQCcXXMUxABbgtxBVBbCzxgkJ48onf88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723791; c=relaxed/simple;
	bh=cyX9O++D1EW+PrctAEPAFu+x0C4bmnpkICuaDGScBns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sJ05G25eoea/ZfX8oRoljV21xcUNXS0mIBljjKQYzK/K4eese86a6QMQ4UrR/UxoglHLfi6WumAV/NXFv2Yxq6DmcZvf6n/igteXC3iUp5s9/W0wPygX3yaUlxy46cFFAUIks1f5lkihvWX8yPsjSCDXU1WWXIkuR4ammdL06TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NArvvHeW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OW6VDL/D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NArvvHeW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OW6VDL/D"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69B85cHG2382175
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yv8ZETeGGwp5WARcyvfI9zIu0Wbuse6bPCkxPkgvqJU=; b=NArvvHeWhe1b9kw5
	lqx0SDOJLmE0vfCEwDChq7AxKVk9zVPRjkM5rXpFxjSjHQhh3wxdkxyEEfrOoZyM
	n20aWg41hBmHqB28I5+wcJGoC7hTx6HsFVaa8P/ZmQUaEXxNfpHffD7QTkJlOAHG
	tNWpZVKvsgj/WdKa73Gr1hKP4tC/NcnMIk3WFCWLezJs+vaAQNXm61X2USTPiOjo
	omsl8JYrO7GEELpayuYju3ZV2ZgUqZHQmrp4/rDsb95vzJjq0wPrL1HYw82oablC
	mVGRfx3e4Rz+q6fdwTONfAXhCuHNmBguvMgpM2ap9+Mmno1gebvWsb7FbxjAPzL8
	mXhYrQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7e4eaw8j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:03:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3592749a017so696123eec.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791723788; x=1792328588; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yv8ZETeGGwp5WARcyvfI9zIu0Wbuse6bPCkxPkgvqJU=;
        b=OW6VDL/DsJPyxrkNu+NLZCaALdwTBdbahxBCCComIyKtzCuv47DaTgF9ySAoUdXRXl
         yflGQgYrg7X/6a+Np2J8dVlb2aid5JMnOnQUU8lZmD0uMWHWhoq7QUDOygzKHyi88a7x
         evNFvXZWjtc3HpDqsnqQGhinYDabOlI9HZ0/hw0Vjf5buYTzZAT00kyxPnDIEM/tnJrN
         jgPR60616cYuOU0+A5gtvjp3EDz3svH1ZmAfzODBOsg3ScfWVw81+KJN6G+dxt0ymIPg
         zyFCTLYTBjpchtQHwzNH6hs24A+decavNm3I28uzwHHdJqj6OwZtd4+hiB4lybjUDwr5
         Lb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791723788; x=1792328588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yv8ZETeGGwp5WARcyvfI9zIu0Wbuse6bPCkxPkgvqJU=;
        b=rP1Hf0N8sVps1A1qy818+H33B13S5fdhappvBHeJkag2LhnD83Ba3/38lpFKwbHbf6
         Qbcj4ozWNR9uL17ym1c5y6cUSjyYc+CzVY956fQfBVm8qXkRxdMSXZlyEKe8X6CD8XAx
         r9xyn4GVW7XoIhQ06Q2RL7AKaI45E0pFc2EKPLugV11xfbcaIrgEYoYOGattb661UzuI
         jCKYkvIoNuPl+/NRuL8DaRiOy1khHIJyVi+fO9jYf4EYA9BHxmookE37EW6+beFpCjQP
         TytXY879FHR3sf/xOQ9uAsByaQ2O2QoUQPjC9pxoeppwbt+dj5bhVoyaCksagPAqhphq
         EeLg==
X-Gm-Message-State: AFq9FYIaH+e75koiZSe1T5WKquChdPjNkh7R7JTN+DVLIh+VPw0VhdF3
	G05RJde2WHbKcJVvylX7XBx5Y2hT0u9l//NXdgOrpQmFlYKmoHmb78HeA122Rna+wm9e1cZvoOs
	MgvKzIRb6vjZKSCDP56luV07BNDqirTlS9JciR7rFWS3282rRBWLkUAkYz/g=
X-Gm-Gg: AYBFou3PioSqe+EZ/9B6sNhzMcGR+PwzjG32B6nGxMFa5GCx59SkOhMeX44fsrnk0f4
	IsUhmdSsXRmGBzjW7QOTLORL/fv9O3gg8Fej0PEr26FteUYGAtyXH4bJWtrf7kuZabOC8MAnkf4
	0RYbkUWJ6p5oOuSMfG5Xz5bh4TyNzh5OKIoWvI8TMA/R/6GJzgPkTi4VMAJzsylpQqhDuvqNqhk
	8by/gqsZAD1EPQoeQQf+1e7ZMbDTGkonN4n9Y3ExmmJOxBe2cvfm0kdDfAIX+eTo+/1v16eGDB7
	3mEG1BqVZDHHqLBG2RG62Ee5Xz1Ne9NeOBC6mu9O2zIvzoilhS4capedGS2NcGJNAKzkHjMC/EE
	WRhSf081r/+AOgZBi8Py6ajDRC5FzguYp0Xk/2QKbsJY=
X-Received: by 2002:a05:7301:2127:b0:359:27e6:b684 with SMTP id 5a478bee46e88-35927e6b814mr3597220eec.3.1791723787487;
        Sun, 11 Oct 2026 06:03:07 -0700 (PDT)
X-Received: by 2002:a05:7301:2127:b0:359:27e6:b684 with SMTP id 5a478bee46e88-35927e6b814mr3597158eec.3.1791723786533;
        Sun, 11 Oct 2026 06:03:06 -0700 (PDT)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm27009074eec.3.2026.10.11.06.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 06:03:06 -0700 (PDT)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 06:02:09 -0700
Subject: [PATCH net-next v2 03/11] dt-bindings: net: qcom,ipq9574-ppe: Add
 IPQ5424 PPE support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-qcom_ipq5424_ppe-v2-3-8c7b057e2c43@oss.qualcomm.com>
References: <20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43@oss.qualcomm.com>
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791723782; l=5173;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=cyX9O++D1EW+PrctAEPAFu+x0C4bmnpkICuaDGScBns=;
 b=q9XCCwp5weL800g9Ws0+7uUbJ0scjfKL1KATc/UNBnNr0m/H81AQX2socHZ5PdwswDiFQpny5
 TQp2P5FTWHFAqEsc7pp0OaMs6Q5cznp1BirVW/KqCknTmJplf+xlkJH
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1MSBTYWx0ZWRfX3fp5Dy3PlWZR
 5fidiJ0BlevXgN18wfN9m8OyXwewcjoxHk89MqQaZ6mPg96vB31mJoJWD+TT7WtrjlU/hyM0jTz
 VCOQs6B1Nan5qwL0VP0bYLvsh8gVKhNhCrGji1KBzH9KpBhzw8D40fDv79VtLWi5M24F8zlQ6Di
 0jes5VWEoC0bF+4nTJncrAbi+voT5ljHlGkjuyKpPER9yoiT1qlYJErxwgaS+5ou8qV2M/AQWwn
 aI3x1IjzwPQd15/IjxCLG3d1jc1O4jSELTynUq6ui9huBOzpS+I53Rl6Dt85fdAd3Zfc85IjNbY
 6boCZy6J3iD6A9iQI5CzGDFI4sCQy6PVlN9vyysT5sCju40Ok2nCuk60w4RwVnUcdheXcNgzAQr
 CEvA+6jfjIW7mGzrDlq/xFNoQsQ8sP8yrffiEs3zXBJXihpY9jH3bZQ+dDP5zejYNzMuK4RbpII
 xQZ9UTTVGBjoKvmuNgw==
X-Proofpoint-ORIG-GUID: AiKhmWwJQxrJcSRx_5xkTiJWtVpmMbEw
X-Proofpoint-GUID: AiKhmWwJQxrJcSRx_5xkTiJWtVpmMbEw
X-Authority-Analysis: v=2.4 cv=W5utxhWk c=1 sm=1 tr=0 ts=6acb890c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=z2bihl_UAZW2wbEoO2AA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1MSBTYWx0ZWRfX7btRdCyz4S2h
 fLSjOTRRB4UExAK+EU+mrHNFIW6hxKbdV2Wd+26+BzLDimBIlxCrOokJ3RK+vuTv28sNnNz0416
 2mfzLxWUZCoFF3dYQMCEe27IbGRf68w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110051

IPQ5424 integrates the same PPE switch core as IPQ9574, but requires a
different, smaller set of interconnect paths, and has only 3 front panel
ports plus the EDMA FIFO interface, without the EIP FIFO.

Add the IPQ5424 compatible, describe the interconnect paths of each SoC,
and limit the Ethernet ports of IPQ5424 to ports 1-3. Also match all
Ethernet port nodes, so that ports out of the supported range are
rejected by the reg limits instead of being left unchecked.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 .../devicetree/bindings/net/qcom,ipq9574-ppe.yaml  | 86 +++++++++++++++++-----
 1 file changed, 69 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
index c899f4b56945..96e9b9420892 100644
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
+      "^ethernet-port@[0-9a-f]+$":
         type: object
         unevaluatedProperties: false
         $ref: ethernet-switch-port.yaml#
@@ -236,6 +233,61 @@ required:
 
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
+            "^ethernet-port@[0-9a-f]+$":
+              properties:
+                reg:
+                  maximum: 3
 
 unevaluatedProperties: false
 

-- 
2.43.0


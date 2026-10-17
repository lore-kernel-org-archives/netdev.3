Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4118E3BB104
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792230355; cv=none; b=nk6p4bcnU+zqzsG7lCXfU9gReEeAujx9KH7omOxQZsrJulTIJbPxSlPQagtx/0UQjPNcR9LB2gfUllUUU50LyRc5TOAnTAw1GW0Annp1bPHKyjz95pxRAst5+jOEcMoLt2c8i9Fa7eKYELrPlxOSZurRgdZceobuoQ4BYrrOXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792230355; c=relaxed/simple;
	bh=7H1dQan4dtYXbkBmTtDxfLj4GbZbSaGELvYCjH5tXhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SI+Q9b6uI68P6NLTN5aeeliwmf4hgMe3nPUu1YWzhErCwwmpUA6bllHeBdaLwY8svYHkQ+ndjmvMT9BPEJrvAhWDKu+WPfKtLS+j0NQ+VHt7ncHOr7xgBbLRWpJJWb24A5jgZZBO7p5bwT6NSNMY73rBoNaXfhzTxXUgSrA5wDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XJhtJmtc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XmEJVTO9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XJhtJmtc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XmEJVTO9"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H6oTNd3701949
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N5JsDfOM/FZljuyIYonxoFSWj6Bl/lINX9Srt6X9Eks=; b=XJhtJmtcW9wyS2D8
	wluey3x0dO8JuICXbqhbYG4oCdepQjsu6hB4XndxdZzr9uj18X56jb/hi1xs3rM3
	0ypTyLj0083+4OJNwU/MX37RBzmNZV4sFgfLN21VU6kPqc8Vr4fm3WqNuvjV7NQv
	NZyTtPXjzNktZdjhP1xV+DdUNW5uFY4ow8KfvPfBQcxn/mClzLgbTlirtK52Ih7V
	K4XPNPmUhXGe4u0/htP1PtCApsqrLCEMJna8OZ/U6Kx4QkSX5qgMFTVLad3W5FlN
	l1Rwv5hpu9TntGMVbgQV35zxL8r8p72ENtTZZ4J+5bHc/cU7zLms43insmq0b2hu
	YUocbw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc2a9gg0w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:45:53 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1299374eec.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792230353; x=1792835153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N5JsDfOM/FZljuyIYonxoFSWj6Bl/lINX9Srt6X9Eks=;
        b=XmEJVTO95FFUEPM5MWt9m+sHaSmxhygS1joREuPsaWbt9RBD6yrTxHU63d93YaKap3
         FkW3OLPqHS+FmLfG5Yb8xw/hXXqHksTmumrjb0uvyPXvAElzOOLQS5SpsQU7anb7oc2q
         8EI6TiTK/CUtPV2o73wP4+ZAidCUaVOaRPwX3nTOZQZYgbuQ5X0f/ivoBamDuG2aBpcb
         BokHONQjjpdPwyn8F9W6IPdeKIDBRAjH8jDsWwpFRKrTuPVqsQ51z1mmGvdqR5W/9xN8
         6YzS9vd3XThSrv9uzfrTYSnr4y63eHOFo08Eim71xb59PmyPkGSy/QSH8pQrs1zxXXPX
         FxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792230353; x=1792835153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N5JsDfOM/FZljuyIYonxoFSWj6Bl/lINX9Srt6X9Eks=;
        b=fYQDcb2uiQaag70bpEOQRqKmmFoxsOPbdbUxrbPIsdD+kH/2O01VabJ5BC0F4CUdUl
         FAbPqNxv1QEUcwRLXXV6V1sas5nNWp65hGfOrH551GUaC3lXph5LCa+jx9o/1jcuQc5E
         6t124WalAa2bb1aRBPhTTPb/DT6Z6fKg7IU8LpKwCwp5EFtIbmep6E0RGZPLBzaNsOXa
         liTa2EOZ7WHRE0leiRCXhWtvvPwOh92gV4YV5Y1T3OzhJHtKpIS6RK7k6/2/DDVmJ6hX
         IAGaUJy5UUgaP2V91s9JuhkebpvMaNq5dE4kalXmV/S54U31AGAKHp9DXq9IBBZV1nix
         4VjQ==
X-Gm-Message-State: AFq9FYJgV7wH3c7o1lhhFGTPGMHhl4EMIdhCiSK1f1y/qba1GjtIwwaB
	GesQoDJyOsjLrsycPRkbLcfDda3mI+L7RVZ6HZNT0dHVph+cG2EjXkLQpKDOshYUCzdHEhk+Q7z
	ef3wnaVjvnKvekHPocj2KKZkP3n01Flsq8n5aVvMxLoFiQV92h24tMDjFBn0=
X-Gm-Gg: AYBFou0ZN7uZGNKzsR1xmBCMLysyL6jNDjbVz+gYqICDlKi4pzqHepryYZTw6ZEoZGq
	egXXc2qc6zwa9AHdiqkvi4a6a/dYmEzL8M5/V/6OZY2CYc4PMdP6UQZEizdANDSYPK93SjCa1UB
	jxKQXDYk0FCHjN/45ffeEzZVCFvCrfpKdTrj0Wo0uRpzQmEskeVE/C9GNcK1AbMSMFVsnWmixoQ
	BqMEHMZi4ELYr8xKpXVdgihBMSSfjIWDAodDWkCuGdWQYYWdB04IE6Sh36r4wJgo66FWUcaBLMv
	SCPmF2QcR/UbiMpOLJGsiUr+u4NQvVUEhWSRGgEhZo44PurA6kE1SKrUkY+8usk2FjayqkVI/cX
	zPxGsil4GV90cnlpeUSqAJTaeaPEP7A==
X-Received: by 2002:a05:7022:ea47:20b0:143:2719:566e with SMTP id a92af1059eb24-18515a66a98mr3299712c88.42.1792230352664;
        Sat, 17 Oct 2026 02:45:52 -0700 (PDT)
X-Received: by 2002:a05:7022:ea47:20b0:143:2719:566e with SMTP id a92af1059eb24-18515a66a98mr3299673c88.42.1792230352015;
        Sat, 17 Oct 2026 02:45:52 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f58c2sm19450327c88.11.2026.10.17.02.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 02:45:51 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 15:15:13 +0530
Subject: [PATCH net-next v3 2/9] dt-bindings: net: qcom,ethqos: add
 qcom,shikra-ethqos compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-shikra_ethernet-v3-2-26a8beb44b8f@oss.qualcomm.com>
References: <20261017-shikra_ethernet-v3-0-26a8beb44b8f@oss.qualcomm.com>
In-Reply-To: <20261017-shikra_ethernet-v3-0-26a8beb44b8f@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792230324; l=4186;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=7H1dQan4dtYXbkBmTtDxfLj4GbZbSaGELvYCjH5tXhs=;
 b=Nl8ymVl6J93gLBLMvJKMojOsdAWgSXv8yLIYcYzfWJuRm11xD4pZL9pkdLz2/iYRlOwWCptYV
 MA4l3Neu2TABWN7m0CtopijlW4CzxsG32zYUmwWQPHuy19ER29nM39W
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAzOCBTYWx0ZWRfX/GMV2eLJ4Q1R
 siOciexvCidN5L2smkzKvnpCbOoLfNycc4gQ3ESTDypeREIGNzCFISXgduYkbCXIBWcFSDLgUqu
 /EA5chBifQwfbJWm6hKgZTwWSoimZdU=
X-Proofpoint-GUID: tlQ-0vYL3QX0_hZXWLORuugUTzPrki4R
X-Proofpoint-ORIG-GUID: tlQ-0vYL3QX0_hZXWLORuugUTzPrki4R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAzOCBTYWx0ZWRfXzEVfuoWXyUn+
 Rdooja6uoPWtAimxdTc6dmsPC//AEuSTURWHGvpfX2W2Jsm/RqPFxtTz7zztHjKY9G1O3ghykdv
 B3WEEm5EIkDepg9YRPlEYKDmE5M9N8uZTS26nFL3PgGpY82rgotfiW/YDOW7E9r7gFkeoGNUD1Q
 c2D4KRTDkMlF+K8q8R6Y7/ut02VYfNf9eMGqmcmSyyzSoFVzIuFzdBS4j/7Sb8dM/QQnkVN4GA2
 XlSRo+74jZed2gsmmu4ajBwrtJjAty5HdLs33W06zyiW7vAhuJ7/pbplQuKUYEVWpc3C/ZUE8t5
 NVcNhVDWplPVJnR5mCQKmJbbYLeLiKFgbmFgLrpwp8pbWaiQtBpihq8ys0ndV19GYtHB0sPMSN3
 nkkdoOHblW5HRRLTR8lIPDaXIdQGfZzcGbrsTtAdFfY8DfMpxd0sECLc/qfaS+tWggY7SZ+kHW2
 8bysFWbD9TCQOLBG66Q==
X-Authority-Analysis: v=2.4 cv=PMeaavqC c=1 sm=1 tr=0 ts=6ad343d1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=iZY8vWlYZPOy4iMPn4IA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170038

Shikra's EMAC requires two additional clocks for NOC interconnect
access (axi-noc, pcie-tile-axi-noc) beyond the standard four, and an
OPP table with required-opps to vote VDD_CX to SVS when the NOC clocks
are enabled.

Add qcom,shikra-ethqos to the compatible enum and use an if/else
block to constrain Shikra to exactly six clocks and require
operating-points-v2, while leaving existing compatibles unchanged.

Add the relevant compatible to the binding document for snps,dwmac as
well.

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 .../devicetree/bindings/net/qcom,ethqos.yaml       | 55 ++++++++++++++++++++--
 .../devicetree/bindings/net/snps,dwmac.yaml        |  2 +
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
index 423959cb928d945aa3e758a3c803d12bd61ec42b..1167f11adbf30c234186a415004a75a774aa4492 100644
--- a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
@@ -14,9 +14,6 @@ description:
   dwmmac based Qualcomm ethernet devices which support Gigabit
   ethernet (version v2.3.0 and onwards).
 
-allOf:
-  - $ref: snps,dwmac.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -32,6 +29,7 @@ properties:
           - qcom,qcs404-ethqos
           - qcom,sa8775p-ethqos
           - qcom,sc8280xp-ethqos
+          - qcom,shikra-ethqos
           - qcom,sm8150-ethqos
 
   reg:
@@ -57,9 +55,11 @@ properties:
       - const: sfty
 
   clocks:
-    maxItems: 4
+    minItems: 4
+    maxItems: 6
 
   clock-names:
+    minItems: 4
     items:
       - const: stmmaceth
       - const: pclk
@@ -67,6 +67,8 @@ properties:
       - enum:
           - rgmii
           - phyaux
+      - const: axi-noc
+      - const: pcie-tile-axi-noc
 
   iommus:
     maxItems: 1
@@ -81,6 +83,11 @@ properties:
       - const: cpu-mac
       - const: mac-mem
 
+  operating-points-v2: true
+
+  opp-table:
+    type: object
+
   phys: true
 
   phy-names:
@@ -92,6 +99,46 @@ required:
   - clock-names
   - reg-names
 
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,shikra-ethqos
+    then:
+      properties:
+        clocks:
+          minItems: 6
+        clock-names:
+          items:
+            - const: stmmaceth
+            - const: pclk
+            - const: ptp_ref
+            - const: rgmii
+            - const: axi-noc
+            - const: pcie-tile-axi-noc
+        operating-points-v2:
+          description: |
+            The OPP table specifies the rates for the NOC access
+            clocks in "stmmaceth", "axi-noc", "pcie-tile-axi-noc"
+            order.
+      required:
+        - operating-points-v2
+    else:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          items:
+            - const: stmmaceth
+            - const: pclk
+            - const: ptp_ref
+            - enum:
+                - rgmii
+                - phyaux
+
 unevaluatedProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 2218a492817fd3d864e0bc529b83fdcbb4ed023b..20b1da2f1096c94215902834a1ea014fb4ae44b2 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -75,6 +75,7 @@ properties:
         - qcom,qcs404-ethqos
         - qcom,sa8775p-ethqos
         - qcom,sc8280xp-ethqos
+        - qcom,shikra-ethqos
         - qcom,sm8150-ethqos
         - renesas,r9a06g032-gmac
         - renesas,r9a08g046-gbeth
@@ -585,6 +586,7 @@ allOf:
                 - qcom,qcs404-ethqos
                 - qcom,sa8775p-ethqos
                 - qcom,sc8280xp-ethqos
+                - qcom,shikra-ethqos
                 - qcom,sm8150-ethqos
                 - snps,dwmac-4.00
                 - snps,dwmac-4.10a

-- 
2.34.1


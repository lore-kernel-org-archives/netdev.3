Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0603C060B
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461669; cv=none; b=WdQmN8gkLlAAY8N5UHP+3RgoXYACuzmpWkPvc63DzqKO5R0R9XZY0fXV0ACZ9Ej7NNFTantTlEjQkY55somkqBrHKwAZ14xfnowOxi/z+zzkJjw0EwRb07x7QMCXoCdiyJcEXFbsux0ksB9GTFuRncgcBgCjMKgvtSBHJBgUXtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461669; c=relaxed/simple;
	bh=1tqS6Dvk6HqdQruGW7WjMOOIlEWgJQuXPAL9e/OSA7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QGjeeJYRNySxgLbOwwrFxckWyt6V6kkbD6sW6s1JO32piWDAIv/HSMyqKKsGGyz6aVmYLQpyQxukLJA4pt2hiXQUHxdNTKb1j9q/rTggXgHZwZOn0Pi5aaREVWKOHe9FHFRwU64oX43NelGGhV/88tdQBUR1sAHV5VN8vet2p6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E313RZY4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ICESgcLb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E313RZY4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ICESgcLb"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G37Jr2088756
	for <netdev@vger.kernel.org>; Thu, 3 Sep 2026 18:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kIQdmFx4PDOd5O9ixmJ7nfhs+TOQEPZyJ9aGwi2TRlY=; b=E313RZY4M8xF9E10
	U6BrPtcvoIRnxtIOC+OX7G777UqJ1Y7bC/ZxTmQppLcTY0htJDiXZXhOyT8x+j5e
	/QE8/msIOVGDOq61VQ53RbZCzg6QaUFkwyGYwh9Q+5k6SP78UtbSxQU2FJj1bDMN
	SDM7OXjcrqyaxs2xFICbreLzaoFg0Qlwb4B4AJDkr4FXSKx02vMUqwIBXHmu1bcy
	wcSvnNHLvmavQn6VtFFthmarBQktRaygiQDW2BDhlfBXmOlj5NyfR8FUFQ0MY5hF
	LEP25+e1gbz/aCygEgEF/Wa/93yZsFvHX8Yj6nPYBhCX1DYhV3laHEVN+Y1UkxR3
	BSICgA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf9b19qyt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 18:54:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d63bad3d09so2283595ad.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788461661; x=1789066461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kIQdmFx4PDOd5O9ixmJ7nfhs+TOQEPZyJ9aGwi2TRlY=;
        b=ICESgcLbxBMlc26HX7FITvWnvOxFGcVNOTZXwxKHAjg2MOa7v4V5SpafDObInxZpMZ
         BWlWGyhPAAMw86MGRwzwxe1bfzeoOpuWadL9asZfxhRngIzwKlkr/zDUIAqWabzBlPM0
         1uxak5s+cx2E+fxE/gu8lXsUzFYo1mbrMi4iJ782HYqvBI46rQBZNWb+PFX5edLuTsat
         M8W5MGSBP2p8YC9HNpizOyScQJuFQ0vFzCcSZ9Kkra0oFyjRPMmqIsCLGHT7ahzF2SH0
         3v1IkUAyERER8aA8LKiwS16xa36ETbOwY0qA8+Aa9J+64BSu4NoXKvkjUzbM5K1yMTjk
         EAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788461661; x=1789066461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kIQdmFx4PDOd5O9ixmJ7nfhs+TOQEPZyJ9aGwi2TRlY=;
        b=D2TWC/bjxdcgXuV7x7QB8zqoly9989E1Fc/OmwfkqZIeHnZ3NUZU3R/2tSqWfdyk/y
         YtIYpPubMHdBKOy8M9zWOaAiMAlSSa4XgwC+ol2bcV70IO5o6NBDuMi/5ZYnyzbfsv8S
         K+E9jF7g+ggyrWm4kP5NbXmePz/LxJhmOVe2hWzoU0+f+WjYaJWEgkquCt3xkBae+4So
         FSwnD4viIfAdwhvUpOB3j0L3TpYh0U2M7FxR6hCxlzaoPRsEokQlscUrnEvc9KaT/JDS
         oDyF38QlhJ2SBI6uacVBnv99VijPAR47fHBLVMU0Kd9HiBheppkr7nVfiUxrB4qrGmrl
         JH+g==
X-Gm-Message-State: AFuF++lfgsbt9vX37hy/xn1dgjB+RfJC5NUb4d9noBOEjkJMcktDHzDw
	Wh+6fA+LeNUWmnqU81f+BM+IdZHydrUF0eVlCV1kujoGzomEhBJu59Pnc1SA73GCm4r2lXWPpIe
	o2hDyS8dtJIG02rFRjaA56+MSF9A2K0/FeY5MN1XYLf+E0tmBUVoFTTl3sb0=
X-Gm-Gg: AYBFou29QY8KaoGRRXUDztRUNy7XweMsHjfkN4PCQQ4PIqmylDxubl2uukxF0m3Gi29
	DAFDdmLcT/ACfGqYKIINQ/QEAUXqQG6AsL7EYba/kzjbmqV3O33KVL6/B1kbdxBZ6M8NU9mIfCF
	vlwtvAxKPl0JPILOFnZ93l8YzYOKgto6FziFEZ1lgwe1kBEO+ldTZoRH6liyBmQEeKPdjyU9/UZ
	fv5i89wWMkHu+kvdGhSorqipPB/0tCwZoex+75h2ZUmkc0/NxH52chQoV1DPnIBSZKBo8f2JHEB
	vH6vGRmW9u9KS0cbFBhCItJHucIwMAohxi+4Aqux7LU9QUKi3/tQWVqQQ9h/vffVWzsb3n9HLyz
	i7Lt8YEdUrT1FkdUa7bIOqRyVyoZioQ==
X-Received: by 2002:a17:90b:3d89:b0:396:5fce:8e24 with SMTP id 98e67ed59e1d1-39b260d2ea8mr821457a91.4.1788461661141;
        Thu, 03 Sep 2026 11:54:21 -0700 (PDT)
X-Received: by 2002:a17:90b:3d89:b0:396:5fce:8e24 with SMTP id 98e67ed59e1d1-39b260d2ea8mr821208a91.4.1788461659491;
        Thu, 03 Sep 2026 11:54:19 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ce1csm778829eec.4.2026.09.03.11.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 11:54:19 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 00:13:45 +0530
Subject: [PATCH net-next 3/9] dt-bindings: net: qcom,ethqos: add
 qcom,shikra-ethqos compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-shikra_ethernet-v1-3-a50765996035@oss.qualcomm.com>
References: <20260904-shikra_ethernet-v1-0-a50765996035@oss.qualcomm.com>
In-Reply-To: <20260904-shikra_ethernet-v1-0-a50765996035@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788461628; l=3972;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=1tqS6Dvk6HqdQruGW7WjMOOIlEWgJQuXPAL9e/OSA7c=;
 b=uzzl30Innk14VtQSk9wQipDRrLbmYFSpW0vMYpn4cBqiZtNV4lHQqwUJ3zYEt9gFMIbtiq2Xc
 WtYNlxhoAu3Dui4ZaxT1Cs/tTxLtdD+4EBW3mDPTd6R8AqCrTDYCtsG
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-ORIG-GUID: gS5eAEQd2_L_sHm0ufT6VfyAHHKgzzvb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfXzpUOkoIDrkUr
 3ltv8kYU7gQUmiyUc4541j97jlD6w0aVitOB/eC8UqgBps2AqBC/y32jUzDsLX+9FRz1QNLKKkS
 SgiJOMrm9Pq6BgNAmnxUy0bqTO0mFTI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX3oT/NnSfb/61
 P0QVDR76NBGkE5DEsa8AyfMwTdUbvt2BuKZHgdcd0/hQftTVCgMy4tTRnS5R+Dvl9zU85F4UPKj
 FJnubgAXvvdzxYlstt85fzA3IJMAb5wQdV87A4SM56w2oK9mZF1R2uy4/fLRzjqJRfJCRbia/gg
 5Cra0Zmf4Cs2IMgSGDmvWyoadog/E9INpI9UcKvBQ7wtHXCYa+PepAsJZ6VshF6WgWVx22rXyQP
 i2n+UQNl0S5IQZHkmlBkfHmsiNgddlG/vjOAjX3rt/ga0EguWI9u/qNzG9DPJq78TrQpcL8PCkc
 zZaL9KmrYTqpzP6IpfiOadGlBprkS1UPgJCRizMYON1ZH0/ZbooVYCdck1XCEcu4drgwQZwvdQ8
 SBI7KYHZ8nqTBPakUuG6V7RddnP90fx/wTZ4aBLPlOvSloFnFtgElQQk1Pby3Is2OKUU0YrQDRl
 0N1byjEUDENZEsFIl6g==
X-Authority-Analysis: v=2.4 cv=NNTlPU6g c=1 sm=1 tr=0 ts=6a99c25d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=DJPLBmofjJW9p3Fp6mMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: gS5eAEQd2_L_sHm0ufT6VfyAHHKgzzvb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030165

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
 .../devicetree/bindings/net/qcom,ethqos.yaml       | 50 ++++++++++++++++++++--
 .../devicetree/bindings/net/snps,dwmac.yaml        |  2 +
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
index 423959cb928d945aa3e758a3c803d12bd61ec42b..ad2cc706fa74041486cd90c3d0eb1dde0acaa27c 100644
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
@@ -92,6 +99,41 @@ required:
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
index 2449311c6d28ed3fbf8c92526ce8b872900653f4..6a1aea371c0b42ef71f90d89276e15159c3b3277 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -74,6 +74,7 @@ properties:
         - qcom,qcs404-ethqos
         - qcom,sa8775p-ethqos
         - qcom,sc8280xp-ethqos
+        - qcom,shikra-ethqos
         - qcom,sm8150-ethqos
         - renesas,r9a06g032-gmac
         - renesas,r9a08g046-gbeth
@@ -632,6 +633,7 @@ allOf:
                 - qcom,qcs404-ethqos
                 - qcom,sa8775p-ethqos
                 - qcom,sc8280xp-ethqos
+                - qcom,shikra-ethqos
                 - qcom,sm8150-ethqos
                 - snps,dwmac-4.00
                 - snps,dwmac-4.10a

-- 
2.34.1


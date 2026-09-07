Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB4D43B4BB
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812655; cv=none; b=OmzX81EAeDNFsPhzBtTdXkBL1swkNiHEpitAISGSFVnnz7ILLCgRzZPzivxOGJe8DXKBb1aqBpiMY+mkZ3JOQowsBi/Xm5lo4A3g25ji+6Hjd05zgvoIoN+8twtcQOxoRMmcd75DpQJdasYk+nUSNqponjznaFF/ByTnBBAvjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812655; c=relaxed/simple;
	bh=1tqS6Dvk6HqdQruGW7WjMOOIlEWgJQuXPAL9e/OSA7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rT3U/reMD6TMFX3D83g/wOqCNqk4f7QdQvlwUAFei3mNocRNwiAjusizZitgEgsRvl2zUmJA3G6uUO0xlZX14RRDdEAXDkvQkO7s53Z3mrePueCvSj7tw/XpSmyHNFg5Awm7WfRS68D4AXITByk3ZJ61F+k22QtDbzDoym2lNVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ly8bzrqQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kanuK5ES; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ly8bzrqQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kanuK5ES"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687H7kJC4061906
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 20:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kIQdmFx4PDOd5O9ixmJ7nfhs+TOQEPZyJ9aGwi2TRlY=; b=ly8bzrqQLmKCfTbk
	Dgegf9qo1/QceiD70j29Iro/J0WLlveKFwBBuAHrPaUkrs/qS4/cWBw2RsOzkZ5V
	vBpPYorrbAJe8yLF/6x8Czso1h2DkzgxkgoAaEt/mrIOwrW4iKSAuXNTi3Fg8U8V
	qEjMSYrUlgnNFYgOIrBBNzEjh8JF3jhfJ563iRCbirj4F+5AmqTjLmmlqp4jn+mw
	zduDJUZufrm1BFlD+PYz1M3orc2+DYiFyF005X0kfDmUUTrl/af4GLpJjisdSzYJ
	xM8KfmiGeBe4tQG6dkXVOx20PkPrSRW4l6osrnSXCaEnu8fhVvrDlSOFgmBfwc2p
	ZfBWUg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj077gsmr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 20:24:11 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1eb205d31so1579613a12.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788812650; x=1789417450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kIQdmFx4PDOd5O9ixmJ7nfhs+TOQEPZyJ9aGwi2TRlY=;
        b=kanuK5EScl3tMQrOz87s8yUbw6ueHKAZMZscebNdZsoUfSmukqRaII3NWR12B7bnJ7
         RjwclfS3OBHmN+BSW4NM9RlknCh+PBYR5Cj/vQ/ya5GQ1ahHOTN0mIyYsh1Q94rmiqEw
         wBaUqF36G/YuZXYti3uQk4TMQq7iAxiYFgRtJBWuGzqm9QSB5XAGybncQlRTFxz2GflV
         Vn+sqD9h3DHvlHhygMnbKqEAFQIZEzZ5gXeP8twMiA2mSwh/vLyEl6oTAssHX6uAqyeK
         iRs8g7ig2bhAYddFsHFX8rnhXVFfTtiy3EEYyX0MKNGIR0H7BVJbYMQlRH7VS/g1+d6x
         NJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788812650; x=1789417450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kIQdmFx4PDOd5O9ixmJ7nfhs+TOQEPZyJ9aGwi2TRlY=;
        b=QJQJehQ0VS0FfakNfkj2mgf+PquvnlW514cGjW32u1mo9+NhOpCh5sJoCOwQSrOuPv
         OwqgMyma9EC9IGY/wjC2mMePokBWm5YDSxwzSqKpMDqcflpzsTCPbzfH4bZrmhvmzRiI
         aG7HjF220S5dsq9PU3RQ5LqZot2xAebhr+2KUwwZn04zsPm91bzVZ51eaSrrGG5micks
         KDNV1+UhXNn1H5Eji4qQ+qiICyCuZxoPN07xdoEkyMmREaNo3U7vGdXuYKrKwouRCmkw
         O+Lwn12RaU+EHuHwfvkeFnn0irwHzQROaYWY1Cq9SQGb5DMRjfFjrifCBs+xiV2SMJIn
         vU7Q==
X-Gm-Message-State: AFuF++kB/US7GZ1OwzHgWR1fwMd3qk3hsVx5akFVoUlVPWxtAXh3kR4N
	CMWRuoC8jIFg2WcUxUHzIP0tO39yoY72sz+1Eh83yAz3aJFxPa5Xsw9kEBo1QA7F/oE3L+IxYr6
	Gd550UdaVy/f3/CbNrn0O4PfSbhgehVjdJkOO7UyReTW0LZam0wLoXlzMkDU=
X-Gm-Gg: AYBFou3RpsdOiWu4x1+XxoEOPAjbRoEBkTJQtMNZKkhS5V7t+DwfTUHa5WgevWYdExP
	Df6mAqiHDtqZG3vF1PUu8YfhkvQSR5/L8QGWfMi9HC5Qie0G2nPfMrAbXwYjylsPVA9O8e18NSD
	xaB/n84TD4/EclgbK1P49UYAylzISDZzCEzmr3wrCIOHJZpFyn4uSMwPORXHRJN5frD7HqYCKEJ
	PndJtR+nZ6KHjHVTOzaslTWS+ERuD+svM8O6Iga0nxI+wV6cNK+cjzG962fCvgmrRfB9wSf4PkQ
	hl/mQ4jyMm09/jvQatprcwMyD695dHe728wKxxNYWes5px7f0HSHWDf5muyQ2V8hJpyvPnF6le1
	uC8ezDL4A+D+6qZ3mv3+uSgw8D5ss/w==
X-Received: by 2002:a05:6a20:1441:b0:3c3:9070:96b3 with SMTP id adf61e73a8af0-3da39cffff0mr39040594637.3.1788812650420;
        Mon, 07 Sep 2026 13:24:10 -0700 (PDT)
X-Received: by 2002:a05:6a20:1441:b0:3c3:9070:96b3 with SMTP id adf61e73a8af0-3da39cffff0mr39040530637.3.1788812649993;
        Mon, 07 Sep 2026 13:24:09 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm30482259eec.19.2026.09.07.13.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:24:09 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 01:53:15 +0530
Subject: [PATCH net-next v2 3/9] dt-bindings: net: qcom,ethqos: add
 qcom,shikra-ethqos compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-shikra_ethernet-v2-3-bbe3389d0652@oss.qualcomm.com>
References: <20260908-shikra_ethernet-v2-0-bbe3389d0652@oss.qualcomm.com>
In-Reply-To: <20260908-shikra_ethernet-v2-0-bbe3389d0652@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788812616; l=3972;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=1tqS6Dvk6HqdQruGW7WjMOOIlEWgJQuXPAL9e/OSA7c=;
 b=CrUJsHdZ6c2FYOwXEPMoV00IX+6Ep99Hv0mU9sSCTtavP+7P0xPU00RHkfInYorGHLTw+7fko
 6sEW89emChQDJtjxcn+QfkPpX09AxlVlDL6j/LdQlY8piS4N+gGFkCq
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDIyNCBTYWx0ZWRfX3ORZQ9e/21i4
 gvCEMQ+qoa+7rdiqArqg2emG1hPNaowOCu9uJPzSFqrfWBwU5Sf2LOoetRB5gEnQKMkY2SJ+TBr
 3OdgvOg8IYCV8/vlUgyDJJQzSWcYcpitH+VIujkobdD+s/7JX0KSCqsMlREnO21agSmjEWeXYZR
 2eIFu1UfLQOPWofKG3Qr5GL1kudJdqKXCHosO1xF53fuswWmJE5v6j5jtdCXSWYi/mDgkx+YbJ2
 6ZoDQbNVbya7LYChjVCflagPVa5z5kRPnSO4h5hGJfSKPOcov7o9K/n0wlpgW/kcHfiEM1IJoSh
 9BbqOVpL33bdLqHSv4Ph6crbT8jV195aJJqniYbh1/fKnTlKFzFAaPYGRFvWq853RW1oSF5P7vf
 vZkM6Bt6shUd6MdTo2dnpTQ4urhnM1Vse8UklQ0WUummQbql1G2PozyQOCvtbzO7w5tKfCqwY+n
 uNnHrrJkmDmALH3YJeg==
X-Authority-Analysis: v=2.4 cv=Xbe5Co55 c=1 sm=1 tr=0 ts=6a9f1d6b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=DJPLBmofjJW9p3Fp6mMA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: TOboPJNq7OxSv8DkBGzw2PoONnTyPEIY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDIyNCBTYWx0ZWRfX/AuGr/gusn2S
 o2MV2D6GWqLgBxWt4ITQW6JXHZaAOPBEA3c//q/MhootwF1Buq5Pk3DI/HW6D7Ve06v7hOHhNlv
 YByvR5jkgzF72D9taOoThCo414ZnElc=
X-Proofpoint-GUID: TOboPJNq7OxSv8DkBGzw2PoONnTyPEIY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_05,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070224

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


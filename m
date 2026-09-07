Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61426431E68
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812637; cv=none; b=jfymF1+2MwmiVIZk+IXQfr6hQoX0k0K5KzWb7xR+knfoyTfNQMsDJHspTu159pazhzffcQkRIO2bMzJozUpL7pLzgVto7P8iyomOaP0ZqccwlOXQVfWq8GQ+bvOprVEjCxL7Fp40XZvWvDKTaGOsOZ1x6SfH2Adx6ye6cUtfGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812637; c=relaxed/simple;
	bh=eZIUN/lYfehnQlzthxyb/UGydSLzCEUV422r4IFRfA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r56wRwCuTFIIoHAnTFFbhuG7/qTy9NH4uxCDM6CKMuHhcYGIvfpIuLPnyQYchz4QSU1oswLy3SoharPeS3eB5DbI4505S6fN9EguyLM+WQheuZE7wRdZ64tHzUScss4Xd7/1QujpW2iI6ocnjKG+FRtVhx+CGOBT1YHRyKtVLNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F3oZ67UX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XM0Tlw+B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F3oZ67UX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XM0Tlw+B"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687H7r5t702428
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 20:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jbfjPo2s6iAx/iJD/jmcJcwK+bjVeCVPpo0oSlaiXmo=; b=F3oZ67UX1RHwHaY2
	2ks41rJXj8oohRWvyNnEfwjfdVuApvjyXdYmoAMk9sd/oj4ncqnguZwxMA9A+dvz
	vXVnjuPDRyYgW1+CPE1yI2HXF3AuW2b0I4W78tij9xzE5PwyJVhGIhtmabNFnEYM
	JKIHJVxFm3In3WwwFb+W74rVd4F2nU43kE20GVQa+BPlxgElWN+pwzjA6SyxK/vD
	WxHwwW/SvxUWGhy3cy9sei1Yvl45QEu1poVZxFdiXc61obj/qyx64PS1ck+pGk8N
	layIBheZtLcYmS6SPSJYOm6sfkHG9USGAF9H9SiAX47oRC5lwjBKkaoksnXlJSMF
	81jmzg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghs86tpv8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 20:23:54 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so20473a12.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788812634; x=1789417434; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbfjPo2s6iAx/iJD/jmcJcwK+bjVeCVPpo0oSlaiXmo=;
        b=XM0Tlw+BBVbXRwGIH/8SyWMIEYRan/Q3tXniust7swc4SdeoAXZaMCQHlxh6lDnNgw
         DcKe++EuNFdA2xKUq6qrK+mcEynIy7uXdqRfESRLC7F8XEpT9eVapa17fp3CEztF1OMG
         KnAbgKiXzL2HHfxcuhewxR0oiULV8llSrmtNdYIuD9py/Xi4DZ6HMjGwhHgWUUXh2s8U
         F/tEqZxw+oFIGUDffiB3KiO/z9eqjbrucbioz7I66bYMq6CMwypxcd0Gz4YGN/P1OMor
         y+C93FNzjvJWefMXUTxDpaAbu5Q+zbiTyIpzLJrkcyTxwT/f5Ogmle1gMTFdycI/yo/Q
         npZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788812634; x=1789417434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jbfjPo2s6iAx/iJD/jmcJcwK+bjVeCVPpo0oSlaiXmo=;
        b=tChppLSEOrMs3VymcR/MqRCQG5GoBYA8OPiL8NDw5WxvdIsLL9Ik3pop2ionFq7mzp
         7tJnrUnXo40w76LVO+M0wMgH+TXuLlT2j1YcxgoNVLVUNConMizrtBeu5JlUeash1LKQ
         l7VAQlncAT8rNFZbDtK+svGAO/57VXTyuV5Nq1tQb+42oUq8B7TI+iC0EpIH9Hk5aHEA
         C0Wlx9eTe2kH6pdV8NGq+8wouTrtVwTHzRodwyTM41iNxyywQaeKeTcJuO3ME9p6aS+0
         IbM4ppmOOSf9Le+5i1Xht4V9pgPV7icp1hQGmef1jz/Isn/ytuCG1/n8WVs8glG2Oqgu
         Uypw==
X-Gm-Message-State: AFuF++lSypNv0I4i0ybtQqxgs2TToNLqcCHBaK6bIi8x78AlKPP7GAfn
	w9croZCyBLFnw5PwfUdm/2IKGTfT+bjPlq9fHyWZWM85yucih3rPqUU1iNiZZ1HkiPljsU0zb4n
	ePcm6X3EkSvalkXb+juOuQOfToQNf18djP+QsLBkYph4OaG0W/mR9iG5LiiM=
X-Gm-Gg: AYBFou2btETml0L5SVYqhH3XYSts7UTy0CaTwcSK7UoXbKFFd6xboPwefftq9MrNvmW
	+JRHDdqHUYEXvi47C4x8IO7npZDbRDh/Q1WwJH8ywl3dCmD15nfQa7PROExUbbIW8WLEq0by8v2
	mHKldCx/acKIFhjKgKJycraFTv0cVYx3Op5xoomc+uf9f3mFmY4eEc7baTBvHOfAwtfA0LDEhFH
	se5A5G6kKp/1tKiHP+rjsnawwQm0t9UyEMO3fxI5dVvXGmj0DVeBFqcojVL956PWAIK827stgoi
	QHXBpMZ1xWpZdNWh8eTCyrG9e1rZthBvMs4X8NDOCWwass6Rhr83FuC1jf6V+r76ZENYGTKb1m/
	jlE7qd3/n+WbR6jJfLeSF4tALPn6dqA==
X-Received: by 2002:a05:6a21:3e0d:b0:3da:7154:2ebc with SMTP id adf61e73a8af0-3da71543f94mr17530380637.7.1788812633770;
        Mon, 07 Sep 2026 13:23:53 -0700 (PDT)
X-Received: by 2002:a05:6a21:3e0d:b0:3da:7154:2ebc with SMTP id adf61e73a8af0-3da71543f94mr17530332637.7.1788812633303;
        Mon, 07 Sep 2026 13:23:53 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm30482259eec.19.2026.09.07.13.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:23:52 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 01:53:13 +0530
Subject: [PATCH net-next v2 1/9] dt-bindings: net: ti,dp83867: add supply
 properties
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-shikra_ethernet-v2-1-bbe3389d0652@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788812616; l=1977;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=eZIUN/lYfehnQlzthxyb/UGydSLzCEUV422r4IFRfA0=;
 b=EuF5sm/rCRNcDvnc0/rvFoyKCG0xmsve1yn8yP2rElyQjKuDHGy0wFbLRBR8A7X6m3So5bE+B
 uQ7Mpbc/lRHCURbTTlk4ukQleNVcUHRC9kRyYA8PFbgEBPjPxluUPRY
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-GUID: _nUpoL27vGzGgdQM2CHWo-bQksO1f0yx
X-Proofpoint-ORIG-GUID: _nUpoL27vGzGgdQM2CHWo-bQksO1f0yx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDIyNCBTYWx0ZWRfX+RTE6creF9Vs
 tPfj5OoEZF9FMHtOmY5NJN/e3s1CkUtiUcxNHiRMfBsZ8QiV5OazSKRQNaiKwuU+M46a0LcyWxH
 NbrBEEgmrnmREmN1XtWh6o5h0H7p5kE=
X-Authority-Analysis: v=2.4 cv=LseiDHdc c=1 sm=1 tr=0 ts=6a9f1d5a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=9lbML-Ic3bjincHAjDUA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDIyNCBTYWx0ZWRfX+Qp9LaR6fPgl
 fNGbbxmTBXywjdrwFRVpaCIcfsnRl2yWvwV2sBBANPzWByjMsgSHEg7PuaplGlT9pNUm0JvmS6D
 NU8zuOr+ngVb1xz0ci8XFyTQVMQ7raENwPfZbQ0JkiK3gF/EDW5M7VHVGpSojQv+bT2af1VXkgP
 c5VIAczmmvwTIz3g0mfCQnkYW3lAeKRQIYIDJtpfX8Ke/85KHUxK1AOll6KDyDXG82wt2ZDBN7l
 2bMI1G+7fwUyA9x4g8mTcwCSNwOkoMzca5scXng4ANdXpaUEgOP79OPdImk6vPuk+KgpQmbysUH
 +/8CPxyKTBY/WSvJ8TuLpV3PgUVE6iKZ42pbK+vTZxR3Hu4fEBWc62LJdjMprp5CGQe6t/e2+DP
 M0dot2DOfl5vLzSeJSNg48YsUSFxydON+gVsXQZdvFIYGOACZY3mGvSk38hJubM9TWCm0OJIuDz
 KiJlNVFSh8BbBB4oxIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_05,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070224

The DP83867 PHY has four distinct power supplies:

  VDDA2P5 -- 2.5V analog supply
  VDD1P0  -- 1.0V digital supply
  VDDA1P8 -- 1.8V analog supply
  VDDIO   -- I/O supply, which can be 3.3V or 2.5V or 1.8V

The DP83867E/IS/CS datasheet (section 8.3) describes two power supply
configurations - "two-supply" and "three-supply".

  1. Two-Supply Configuration: VDDA2P5 and VDD1P0 connected, and the
     VDDA1P8 pins are left unconnected.
  2. Three-Supply Configuration: VDDA2P5, VDD1P0 and VDDA1P8 are all
     connected.

VDDIO is a separate fourth supply present in both configurations. The
datasheet specifies that it can either be 1.8V or 2.5V or 3.3V.

Some embedded board design expose a GPIO-controlled regulator to control
any one or more of these supplies. Therefore, document all four of the
available supply properties.

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/net/ti,dp83867.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.yaml b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
index 4bc1f98fd9fe51260b767b0a1b8b7eaf974a9af9..e78f08ded3d0d449ab75bf33d814fd49587f8387 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
@@ -118,6 +118,20 @@ properties:
       Transmitt FIFO depth- see dt-bindings/net/ti-dp83867.h for applicable
       values.
 
+  vdda-2p5-supply:
+    description: 2.5V analog supply (connected to the VDDA2P5 pins).
+
+  vdd-1p0-supply:
+    description: 1.0V digital core supply (connected to the VDD1P0 pins).
+
+  vdda-1p8-supply:
+    description: 1.8V analog supply (connected to the VDDA1P8 pins).
+
+  vddio-supply:
+    description: |
+      I/O supply (connected to the VDDIO pins). The supply can be 1.8V,
+      2.5V or 3.3V.
+
 required:
   - reg
 

-- 
2.34.1


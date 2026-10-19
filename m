Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F2D4DD3A1
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405696; cv=none; b=Rt8twWr5YhUXrpKOu8S8V7HgSL3Rv6I+bX9gJt8xokGBwZTyQWjiQwfvA0l8Rf8z/Eln1UOcq75ulug5QSrC7mfs7wT6gcQ+dkr0rvefDN8MHAmBVEXCoAPvfBtZQ/OQaUSQE9GMHYCqTPg++oopmhVe5TtE3dVQEr+er9hGAQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405696; c=relaxed/simple;
	bh=O+iazLguLyovlIP3fa/uVTa9ArunFV5vRJNzz6i57mY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=alvYSFo9YZurZlt5FZfcvEbtp/Xk+Dy2ppqWG4Yga+5JvwPqcqrNiDfg4dwFJwiMPNdTE36qozCivEYuzKwPif6OznfJ30DwJCgLktisDUeh7kZaMZeyX8sxtF5BmMg7Nj71QRulehcKWjn0N0GzzGlP02iXkTlt49G4Lem0lXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TTf01I4S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ForPtr3l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TTf01I4S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ForPtr3l"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8PBff2236447
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IPvlp3jqlW0A24vumhBMxzUHc0LetsIebcnDpbuLGNU=; b=TTf01I4SaqmfK3RA
	M6YlxJsmIKUBJR++VzPlTz82S8acn9VMdmM2nFPxGBp/rOifXCJWJgAXAZ+zAU12
	l2Dfpx+ao7eMjxRmhGKSaZWqAn5WdT213XNiD8fR9+2OPeozHBTDhyuSW+Pc492w
	837dKSTfgPFt7JswE8ffDtgWbo3jgR1oNOTH3u+HGGD3G3tx+/6fBjYaIt71Pi3z
	l9J2KH3TyAcRk5ezFeluQOzvq82R5UNzQkjZrf0EawXcvQuXnp6ssN2ieplXwajA
	9Y/5mOi8e9xKBYVY194ghjxzs8WT0oScmPbfeshR2kV2GjEbnxAwM0GJH7qVmZM5
	zpYqAg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3x8mmp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:28:13 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e617b5e9b3so11577095ad.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792405693; x=1793010493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IPvlp3jqlW0A24vumhBMxzUHc0LetsIebcnDpbuLGNU=;
        b=ForPtr3l8LRWu4i63R8/YSqPg7qfOz/H+hsnWlCWmrk375yw7vNm3t9G4k2mX5hE6W
         vWit62j6FpcECSlX5D9npPm8Aj8TGlzXc8uNYhu87Jq6j2dO6wIJ6r9z1Ahzk/sV49hR
         8q4MTbtAOF33cciXkyH2WAALqD3VjuK7GZHD+g/y+KYlMgTSXeeY7FHQLT748XCBpd9e
         K+RYtWjB4gnMZdVnPr6usdpUtJ18XkcJd7616zgeipQUVgllozwYUXHbEARESnMgvxQV
         CiASA6j6q6SY5NrZ6fnTzdVZAbBcJV0GoWdVKr8YtXH+8PK82YYRg3Q6dG8g0OSHOTKF
         lnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792405693; x=1793010493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IPvlp3jqlW0A24vumhBMxzUHc0LetsIebcnDpbuLGNU=;
        b=XptQKbEUb6E+57QKcgbUHNwNxjyT1lZl2sSBcvUf2OSLznfRD3EoMVwuE+Zl/NmFKo
         QWE3jUg4d3ZXQdqQHSKqs2/oI0UJ2MwmdreBHTCQJed7jFxmu1mEn/b/HyfTlPA/WZfb
         24I9Ox5FJ5+YzGJ7LpmosOWVNOOCb0vmujxkbAT9e9lZ0JIZxu98JSiInkDROwoNPEBP
         HmuRCBwh/+Z/HQ53jmwuAT5OrEu33b1f4ndJBqI97/GfMvU2yWZEd7gz2u2syozrdj/P
         onwKG2DPLP5HteknTAsUe58FRmWWXj+6KjIpLeZdcFs9IUHnRU4T1My08gJdXCaQrLyN
         +aDw==
X-Forwarded-Encrypted: i=1; AKwUvBzXmU3QTVSszEhzcWGCTx8hguZpG5pIYAekT1M+NabpQ8VRJOBlA/N48YU6a/9hc0rFsdXF7bg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIddqWJsg+MZGGJJN2/szpGdpT2YSUGUdiPAyYZ60WVvuSM+4G
	f5Hr1d2/dACh87wIX5lAAAdznporIcT8tNwDl6vS9/MyJhjiS/AJ5UtbwWIerm2a+o+4t5GD4Jt
	L08394qleKczOANa137oWKQH6RirNzsCP/t+VxR3w2AM3U7NyZBUXhOeGYlI=
X-Gm-Gg: AYBFou3Fio/pQ8wCzD7OWhsxXhS9zYPzce/+fzL1YsAbF36aG+OUhFTg6fprk/MvA2c
	FgGw5Tdw704adtkIb7tWscHRXRN2d7PZ6LortQwQOV9YGqtGuyvW1xVG2374o8wyVBUM4GMAeia
	PvHvbPaXt7G7qD1w74y++1SEW+NDctpPUyDhV0DzfPo6YiEzDnU5i+jEPa0jK9YFBU40q9IYr2u
	Ci4ySe0FF1L9j/pfbVUB8ZkiGJUd7ZpHJwMjPNUQ3zjlDakkncKtFuYWTFnsOjPmqrHzUzNc7Om
	lni84PSOY2CNelu9Tq6cincw9b2lYqO1oPb2N5CGx52D+JMCmPZZiqpVM5/zQ2vCr28CYinc7P5
	RQ72dthGlmOoy1ig000ZAH//lzREuGh9AQcsM/Q==
X-Received: by 2002:a17:903:228a:b0:2e8:3d48:4d80 with SMTP id d9443c01a7336-2e9a6e53cb5mr60808675ad.45.1792405692691;
        Mon, 19 Oct 2026 03:28:12 -0700 (PDT)
X-Received: by 2002:a17:903:228a:b0:2e8:3d48:4d80 with SMTP id d9443c01a7336-2e9a6e53cb5mr60808465ad.45.1792405692132;
        Mon, 19 Oct 2026 03:28:12 -0700 (PDT)
Received: from hu-gthawre-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5d7ef1sm36359785ad.3.2026.10.19.03.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:28:11 -0700 (PDT)
From: Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:57:34 +0530
Subject: [PATCH 3/3] arm64: dts: qcom: lemans: Add Draco EVK board
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-lemans-draco-final-changes-bringup-v1-3-dcabe94f1074@oss.qualcomm.com>
References: <20261019-lemans-draco-final-changes-bringup-v1-0-dcabe94f1074@oss.qualcomm.com>
In-Reply-To: <20261019-lemans-draco-final-changes-bringup-v1-0-dcabe94f1074@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
        Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>,
        Ajinkya Inchure <ainchure@qti.qualcomm.com>,
        Anuj Tripathi <anuj.tripathi@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792405669; l=12809;
 i=gopikishan.thawre@oss.qualcomm.com; s=20261019; h=from:subject:message-id;
 bh=O+iazLguLyovlIP3fa/uVTa9ArunFV5vRJNzz6i57mY=;
 b=XkaMP1Vpd3wAeFpNxkU+P+6Q197FzQWviafUQzuepDW02Ri81m+zeA8kwMyJlm8ce+Gsus1xs
 Zp43wxICdmoBsMm5JjQrK8+VTQhYnHTOuMn0Cae7j8Me6TDKa1KyLsQ
X-Developer-Key: i=gopikishan.thawre@oss.qualcomm.com; a=ed25519;
 pk=l7diN2ZWn/39T24vZixhPPrGDEUF6RKc19MsWZubM6s=
X-Proofpoint-ORIG-GUID: _bleKyp-vj0mOLOnccLPFjO157S7d40c
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX/+cxMWZC09gN
 vFm5SkrR4xLgP/4hDXbdv0ZJP+yvNIuPTLtYlhUVfjtmb8aeVvac23ZFaxZv57dXLI12JPCgKh4
 BqmyeHxPFM1cxNR7qqGsamUnfeLZ0fQ=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad5f0bd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=56b0w_5mWSKF6VX4WC4A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: _bleKyp-vj0mOLOnccLPFjO157S7d40c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX8sYvQgfaQtDP
 uwj2KS/2S0Y1rQsNmy9KZrT9C5GOiAGoGxr6KNXKA73I+X04FVlxms7baDY8fbW7L7WR6ApdzOP
 ve0a0/m7QbSzz6D5wIcHKus8wmi9ReB/3FK883pMxHzz8HezpSHN0f0fBK3WHaYqvwowh7/r31I
 ntwatES9vtFhVNucE4+jn2hP0nVETk9v5SnpqYbDo608hpkWAx3BJApU6g33RUG5stGCNbTKoUb
 37p2Z0/HZ++KUO65dIC3lLm0mwzLxUlshx2wZ0xZ/LUKpOUhQwW6/+FCsSrOV3kL4/OHOe/0JV7
 FGx7diOpOz5auzRZdh9GJoyTH5Z+cxE7Gpm+Ahf+Gd8oI80hMrzM5wDfidPM/MQVI72DSu+zS3j
 8jsNveVn9YZZ6kZgjTJZQhAb1juBaz8XcSNu3IDxRVSAUgxvUa+ihycHilpVJ8eFHSLi0MAPdQM
 Qk2J8iLB82v0cvXxI7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190041

Add the device tree for the LeMans Draco EVK platform which combines
the LeMans Draco EVK SoM and Draco carrier board.

This device tree adds board-specific peripheral configuration on top
of the SoM, including:

- I2C GPIO expanders (TCA6416/PCA9534) on i2c2 and i2c18
- EEPROM with MAC address nvmem layout on i2c18
- Native DisplayPort output (DP0-DP3)
- Dual Ethernet (ethernet0/ethernet1) with HSGMII PHY over SerDes
- ST33HTPM TPM over SPI16
- AMC6821 fan controller on i2c4

Co-developed-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Co-developed-by: Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>
Signed-off-by: Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>
Co-developed-by: Ajinkya Inchure <ainchure@qti.qualcomm.com>
Signed-off-by: Ajinkya Inchure <ainchure@qti.qualcomm.com>
Co-developed-by: Anuj Tripathi <anuj.tripathi@oss.qualcomm.com>
Signed-off-by: Anuj Tripathi <anuj.tripathi@oss.qualcomm.com>
Signed-off-by: Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   5 +
 arch/arm64/boot/dts/qcom/lemans-draco-evk.dts | 543 ++++++++++++++++++++++++++
 2 files changed, 548 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 4e714251d5e6..f1713d53af5f 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -50,6 +50,11 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq9650-rdp488.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= kaanapali-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= kaanapali-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= lemans-draco-evk.dtb
+
+lemans-draco-evk-el2-dtbs := lemans-draco-evk.dtb lemans-el2.dtbo
+
+dtb-$(CONFIG_ARCH_QCOM)	+= lemans-draco-evk-el2.dtb
 
 lemans-evk-camera-csi1-imx577-dtbs	:= lemans-evk.dtb lemans-evk-camera-csi1-imx577.dtbo
 lemans-evk-camera-dtbs	:= lemans-evk.dtb lemans-evk-camera.dtbo
diff --git a/arch/arm64/boot/dts/qcom/lemans-draco-evk.dts b/arch/arm64/boot/dts/qcom/lemans-draco-evk.dts
new file mode 100644
index 000000000000..5238157ad002
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/lemans-draco-evk.dts
@@ -0,0 +1,543 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+/dts-v1/;
+
+#include <dt-bindings/pwm/pwm.h>
+#include "lemans-draco-evk-som.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. Lemans Draco EVK";
+	compatible = "qcom,lemans-draco-evk", "qcom,qcs9100",
+		     "qcom,sa8775p";
+	chassis-type = "embedded";
+
+	aliases {
+		ethernet0 = &ethernet0;
+		ethernet1 = &ethernet1;
+	};
+
+	dp0-connector {
+		compatible = "dp-connector";
+		label = "DP0";
+		type = "full-size";
+
+		dp-pwr-supply = <&vreg_dp0_pwr>;
+
+		port {
+			dp0_connector_in: endpoint {
+				remote-endpoint = <&mdss0_dp0_out>;
+			};
+		};
+	};
+
+	dp1-connector {
+		compatible = "dp-connector";
+		label = "DP1";
+		type = "full-size";
+
+		dp-pwr-supply = <&vreg_dp1_pwr>;
+
+		port {
+			dp1_connector_in: endpoint {
+				remote-endpoint = <&mdss0_dp1_out>;
+			};
+		};
+	};
+
+	dp2-connector {
+		compatible = "dp-connector";
+		label = "DP2";
+		type = "full-size";
+
+		dp-pwr-supply = <&vreg_dp2_pwr>;
+
+		port {
+			dp2_connector_in: endpoint {
+				remote-endpoint = <&mdss1_dp0_out>;
+			};
+		};
+	};
+
+	dp3-connector {
+		compatible = "dp-connector";
+		label = "DP3";
+		type = "full-size";
+
+		dp-pwr-supply = <&vreg_dp3_pwr>;
+
+		port {
+			dp3_connector_in: endpoint {
+				remote-endpoint = <&mdss1_dp1_out>;
+			};
+		};
+	};
+
+	vreg_dp0_pwr: regulator-dp0-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "VREG_DP0_PWR_3P3";
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&expander1 7 GPIO_ACTIVE_HIGH>;
+	};
+
+	vreg_dp1_pwr: regulator-dp1-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "VREG_DP1_PWR_3P3";
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&expander1 8 GPIO_ACTIVE_HIGH>;
+	};
+
+	vreg_dp2_pwr: regulator-dp2-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "VREG_DP2_PWR_3P3";
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&expander1 9 GPIO_ACTIVE_HIGH>;
+	};
+
+	vreg_dp3_pwr: regulator-dp3-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "VREG_DP3_PWR_3P3";
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&expander1 10 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	expander0: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	expander1: gpio@21 {
+		compatible = "ti,tca6416";
+		reg = <0x21>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	expander2: gpio@22 {
+		compatible = "ti,tca6416";
+		reg = <0x22>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	expander3: gpio@23 {
+		compatible = "ti,tca6416";
+		reg = <0x23>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	expander4: gpio@38 {
+		compatible = "nxp,pca9534";
+		reg = <0x38>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+};
+
+&tlmm {
+
+	dp2_hot_plug_det: dp2-hot-plug-det-state {
+		pins = "gpio104";
+		function = "edp2_hot";
+		bias-disable;
+	};
+
+	dp3_hot_plug_det: dp3-hot-plug-det-state {
+		pins = "gpio103";
+		function = "edp3_hot";
+		bias-disable;
+	};
+
+	ethernet0_default: ethernet0-default-state {
+		ethernet0_mdc: ethernet0-mdc-pins {
+			pins = "gpio8";
+			function = "emac0_mdc";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		ethernet0_mdio: ethernet0-mdio-pins {
+			pins = "gpio9";
+			function = "emac0_mdio";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+	};
+
+	ethernet1_default: ethernet1-default-state {
+		ethernet1_mdc: ethernet1-mdc-pins {
+			pins = "gpio20";
+			function = "emac1_mdc";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		ethernet1_mdio: ethernet1-mdio-pins {
+			pins = "gpio21";
+			function = "emac1_mdio";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+	};
+
+};
+
+&i2c18 {
+	status = "okay";
+
+	expander5: gpio@3c {
+		compatible = "nxp,pca9534";
+		reg = <0x3c>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	eeprom@50 {
+		compatible = "giantec,gt24c256c", "atmel,24c256";
+		reg = <0x50>;
+		pagesize = <64>;
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			mac_addr0: mac-addr@0 {
+				reg = <0x0 0x6>;
+			};
+
+			mac_addr1: mac-addr@6 {
+				reg = <0x6 0x6>;
+			};
+		};
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	fan_controller: fan@1a {
+		compatible = "ti,amc6821";
+		reg = <0x1a>;
+		#pwm-cells = <2>;
+
+		fan {
+			pwms = <&fan_controller 40000 PWM_POLARITY_INVERTED>;
+		};
+	};
+};
+
+&qup_i2c4_default {
+	drive-strength = <6>;
+	bias-pull-up;
+};
+
+&spi16 {
+	status = "okay";
+
+	tpm@0 {
+		compatible = "st,st33htpm-spi", "tcg,tpm_tis-spi";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+	};
+};
+
+&mdss0 {
+	status = "okay";
+};
+
+&mdss0_dp0 {
+	pinctrl-0 = <&dp0_hot_plug_det>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&mdss0_dp0_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+
+	remote-endpoint = <&dp0_connector_in>;
+};
+
+&mdss0_dp0_phy {
+	vdda-phy-supply = <&vreg_l1c>;
+	vdda-pll-supply = <&vreg_l4a>;
+
+	status = "okay";
+};
+
+&mdss0_dp1 {
+	pinctrl-0 = <&dp1_hot_plug_det>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&mdss0_dp1_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+
+	remote-endpoint = <&dp1_connector_in>;
+};
+
+&mdss0_dp1_phy {
+	vdda-phy-supply = <&vreg_l1c>;
+	vdda-pll-supply = <&vreg_l4a>;
+
+	status = "okay";
+};
+
+&mdss1 {
+	status = "okay";
+};
+
+&mdss1_dp0 {
+	pinctrl-0 = <&dp2_hot_plug_det>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&mdss1_dp0_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+
+	remote-endpoint = <&dp2_connector_in>;
+};
+
+&mdss1_dp0_phy {
+	vdda-phy-supply = <&vreg_l1c>;
+	vdda-pll-supply = <&vreg_l4a>;
+
+	status = "okay";
+};
+
+&mdss1_dp1 {
+	pinctrl-0 = <&dp3_hot_plug_det>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&mdss1_dp1_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+
+	remote-endpoint = <&dp3_connector_in>;
+};
+
+&mdss1_dp1_phy {
+	vdda-phy-supply = <&vreg_l1c>;
+	vdda-pll-supply = <&vreg_l4a>;
+
+	status = "okay";
+};
+
+&ethernet0 {
+	phy-handle = <&hsgmii_phy0>;
+	phy-mode = "2500base-x";
+
+	pinctrl-0 = <&ethernet0_default>;
+	pinctrl-names = "default";
+
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
+
+	nvmem-cells = <&mac_addr0>;
+	nvmem-cell-names = "mac-address";
+
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hsgmii_phy0: ethernet-phy {
+			compatible = "ethernet-phy-id004d.d101";
+			reg = <0x1c>;
+			reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <11000>;
+			reset-deassert-us = <70000>;
+		};
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x1>;
+			snps,route-ptp;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,route-avcp;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x3>;
+			snps,priority = <0xc>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+
+		queue0 {
+			snps,dcb-algorithm;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+	};
+};
+
+&ethernet1 {
+	phy-handle = <&hsgmii_phy1>;
+	phy-mode = "2500base-x";
+
+	pinctrl-0 = <&ethernet1_default>;
+	pinctrl-names = "default";
+
+	snps,mtl-rx-config = <&mtl_rx_setup1>;
+	snps,mtl-tx-config = <&mtl_tx_setup1>;
+
+	nvmem-cells = <&mac_addr1>;
+	nvmem-cell-names = "mac-address";
+
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hsgmii_phy1: ethernet-phy {
+			compatible = "ethernet-phy-id004d.d101";
+			reg = <0x1c>;
+			reset-gpios = <&pmm8654au_2_gpios 9 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <11000>;
+			reset-deassert-us = <70000>;
+		};
+	};
+
+	mtl_rx_setup1: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x1>;
+			snps,route-ptp;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,route-avcp;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x3>;
+			snps,priority = <0xc>;
+		};
+	};
+
+	mtl_tx_setup1: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+
+		queue0 {
+			snps,dcb-algorithm;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+	};
+};
+
+&serdes0 {
+	phy-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
+&serdes1 {
+	phy-supply = <&vreg_l5a>;
+
+	status = "okay";
+};

-- 
2.43.0


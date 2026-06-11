Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51F84D8DB7
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203095; cv=none; b=GsvpP8if6GkqVS28VO8D9sXf/3Ny7JrF/oShPddOQ8XLsHPdeg/7jGF4jkdLRllzFbr0hA4Cd1ib3Dk6En/o55HDptHUMW9zENQpn/vVRyeXRTxc1Lm2f0ql+wXXj37kiLD79IXoHfX/+akw0NuGXGBnUyod04Kj3LvIJvSmeHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203095; c=relaxed/simple;
	bh=myQOn368a4bEJkBKFi/AB/zdqSpCAE0Tjjhf3d8zs78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OcU2uM8ufDcs35UEnNa5xMsIImxO4IN6A2beWL+ENyOP8Y7ApN36vIE22WjQho9N6K6EEdDgoyQhYvvTXEADZMgA7VyDjLNwhfI5UjvVriNf+xiSUKaHivEyokJV/2BEn5/NGgTjpPBTQImcGGK65EDUEV1y0h5thUrRkR3wSsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oRWz4di9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fIaioEe2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oRWz4di9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fIaioEe2"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BIQIg71398539
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w+qgmHOGmRapWq0OUXXvIAYW2o7E/H8TFKc0cwHnGMM=; b=oRWz4di9ND6hN99G
	G3yEcSDwzj8xLcMa0+clj4YI8Gk7xkDWKM0Mk89+CbSb6nQs5u/pDSRyQPAAPQFK
	X3daIoEpaJmwI/nTcVjWiAx9+wVF4mTUQ3CxNjoI1VKJZGwnmljsdfnvGqBPyhlF
	523w/ifj/+K2hYwTAhlGy0HOoy9xNof8zOS2Q+GbpADle0GAMLtREemKNx9zORzP
	NjzDahAeP7oJ7g2kZ4pnrSw9vJROU3o0pOchDvYQ5MgujXC+rCIOvIpe7nt/X3Sk
	Mr3IkhrRp3ck958jOz/jHD90Yrc2NsvNnXyM5jdFBYE3LDf4vGqksG0fWaIzsZBK
	r+N2Xg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er0x7gfwg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:38:13 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-842208d5b0eso144894b3a.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781203092; x=1781807892; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+qgmHOGmRapWq0OUXXvIAYW2o7E/H8TFKc0cwHnGMM=;
        b=fIaioEe2Dhhz4MhdrdXMP7ODnVNyC1hbdYZ8Xf9/8pQRy2CLvbOQDeBHoXlNEhuXhY
         mvUNYQDn+ZKdAM14bIikg5e9inF+n7iEYTiQQQCKsqwrrnqGiTFrqfxOOXi8auN3yMEN
         HqO/6ro/oBJcf33QwPLu4G1BjnqV+kJNH3G+YZovCX/+2jICzQkhNlrlPYfN0SVkTIKu
         h9HZoEm0S1kVidv2cQiuSzAwMsrjvSBwuvIDyKy5lAc6ugZy11GjRJ2hZULAuipF9G5j
         n8id0iYu5zInISOJo76M+ij1p+ersNW5bGmiU40a2Bj+CTJFEXoyhMV2yKP1hmIB81GV
         cX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781203092; x=1781807892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w+qgmHOGmRapWq0OUXXvIAYW2o7E/H8TFKc0cwHnGMM=;
        b=rBHrSiz9GTMEjgFWCdjNmG1VpL3NNOmkzW615Qq6QclKktSSiTfNBQHmPa8bwhK68B
         oG4cUKkvSn5SrISQ23kii59aMSjZ2nFyIrnqOxRUUm6yrYou3zGGtZ22Gzhj5VcTKlzm
         U+f1/HuQ4lRIq8/qCldK4pwqnaso/wUlDH+4vsb1EiEdiI8VM3e3QzDjB43J6J8yeAy8
         offPbK3uop/Rgw8iNMSVr+tBZ5nC4DvCs0sURnsCIh//iI2vrSO4DsLUcONn3VgNW9R6
         Q0p0C/VKqSFVxpV99iQGYCGZ9gRjSMGA3QHtS/HYHAsog8oGs6alN2tBl9OcuN7MoafO
         0TJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xdPZNSYoVz0/CfJGN0OTizjZp7HKr6ZxG9AESWvwyRLZYYKvCz1JA0OOe766egcmwPyWPkl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyldHouPutm7wJJ70p8AmIrVns4n6uArkiLs13U/WrEJEdJCWM2
	Zf8JU6GJ7jV8s7RazznKHrYB9dP3K9osWKVFN2TXSajQW4tc1uNIHjGhboTAH33ag4ZLNBU7tjp
	302tlAHB2aX5TWTH9TWmEvS0PSrmwNGIQ/aayaSs1iOOQOozxRDKUuN6MB57lwSftF5vWUQ==
X-Gm-Gg: Acq92OGJDwcC1k2B8jvSiuAh6j8ZbPWkqArX9GGOZ1tHyB4rLrIqPF4JBy9aGH/4XQC
	pqkUv/e2Ek3df/QqqqsZYVqpTajz8UKDV+pI3ystD6izl73tY0bUfX5VDe1Zffs+i8YDziA2Igl
	9T29071ICxrP3JeUn6h8zSUumi/+KCrRn6V01j9I6mI8YTKb1ff/ZvEnLLOF+tzaAdOHpWFtNLS
	FUcyKLl2PWlTTjrXcl1g3WUKbJRUz6Zo/NSV2poTEcwS2DRefWEaYNN8u+n8nsdSSvdK0BVoDk2
	/P5oEhBElpEid2fPb1dX1IJIJEID5ShIBpiSF+omXquWesVtF4XRnoUYWJIn13CybC5Yo7Ssfgl
	Lr0JJoCtm0RnOuxhzvKABsbMT+hNBHG89u97b7a9aUC925vl/o48=
X-Received: by 2002:a05:6a00:2d9f:b0:842:6e9f:9dc with SMTP id d2e1a72fcca58-84336a9eda9mr4743095b3a.34.1781203092254;
        Thu, 11 Jun 2026 11:38:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d9f:b0:842:6e9f:9dc with SMTP id d2e1a72fcca58-84336a9eda9mr4743069b3a.34.1781203091712;
        Thu, 11 Jun 2026 11:38:11 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bbbfacsm2555666b3a.20.2026.06.11.11.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:38:11 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 00:07:05 +0530
Subject: [PATCH RFC 9/9] arm64: dts: qcom: shikra-iqs-evk: Enable both
 ethernet ports
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-shikra_ethernet-v1-9-f0f4a1d19929@oss.qualcomm.com>
References: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
In-Reply-To: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781203027; l=6213;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=myQOn368a4bEJkBKFi/AB/zdqSpCAE0Tjjhf3d8zs78=;
 b=6L7bDPM92n1GA/dkSKoqtFmo6gyQYaMeE5heucZ91kgX9VpAsVQwHgdprUw4av+2T6FNB/nz9
 +AyD4snXWCBAXT+Z8d1k+pmY4pSmAWMuwqYKYRYboWPIa4RtjbLydzp
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-GUID: e7AAdaF0NC-HsFqBS9-aP_IbHrezDLr6
X-Authority-Analysis: v=2.4 cv=c4abhx9l c=1 sm=1 tr=0 ts=6a2b0095 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=8zPImXEJHl8ypWhI0nAA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE4NyBTYWx0ZWRfX5tepXlnPEhxL
 Jm47U+XP872bPYC5RclM5bc2Kjn4dpNotYVadp9ccZkv0XubMn/YignzvVp9rEL3ywMnCnntvdr
 6eedSD5u1irmB7gpkIYVG49gGIY10J4CX8kDf+L7+/AaEzMLFe5ZqHUlf9+IJtN8ibqcV7xPP0K
 8f0JyrjPQuZytY+6VmQkBgg0HEbP7ttg7CdsYbOMeVXbyEn3foU9cxh8VVg5fyZHEfHj/c3og4v
 1Zkl2/740ygRG6BjVaCBP0lzy9DEgrX35LZbqyJr2KMobv0EynAwfN70st0ZVZm2QlrUpf6qABz
 0EbrZzGHcbCLnsnymdOjYCD7J4wthVuIMbnkGufHzjoH/A3jzr6hxnaIcwLAmrTyEepQ3OTMVGJ
 6SWDfomcFWH4NeRyFx+0L529a84300tjdya5IoFzPSa82YWKm4wp9d03NRiNcYmqeIbpQudgN4z
 7ueBJyoU7jryzRRvjCw==
X-Proofpoint-ORIG-GUID: e7AAdaF0NC-HsFqBS9-aP_IbHrezDLr6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE4NyBTYWx0ZWRfXyNsOlukeAPd7
 LqGnBeXN1wM3lLwA3duRlCUBn2IizJUJd6hqxU42RZLS2bRF9zJtcj3rrjqo0YFh5hXL2nQW8LC
 a0FHRa40k5dcMoOl6ynZ3lKjAmkK5dI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110187

Enable both Gigabit Ethernet controllers.  Each port has a dedicated
PHY with a gpio-hog to assert the power-enable GPIO at boot,
pin-control for the RGMII and MDIO bus, and MTL queue configuration.

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 235 ++++++++++++++++++++++++++++
 1 file changed, 235 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index fd691d53a0fa8179111b921bf3bacc08884b84fb..d69b63dbc8e44f1bcec064564236ea23673bfa1f 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -7,6 +7,7 @@
 
 #include "shikra-iqs-som.dtsi"
 #include "shikra-evk.dtsi"
+#include <dt-bindings/net/ti-dp83867.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. Shikra IQS EVK";
@@ -68,6 +69,178 @@ vreg_pmu_ch1: ldo4 {
 	};
 };
 
+&ethernet0 {
+	status = "okay";
+	phy-handle = <&ethphy0>;
+	phy-mode = "rgmii-id";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&ethernet0_defaults>;
+
+	snps,mtl-rx-config = <&emac0_mtl_rx_setup>;
+	snps,mtl-tx-config = <&emac0_mtl_tx_setup>;
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@7 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <7>;
+			reset-gpios = <&tlmm 135 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <50000>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		};
+	};
+
+	emac0_mtl_rx_setup: rx-queues-config {
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
+	emac0_mtl_tx_setup: tx-queues-config {
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
+	status = "okay";
+	phy-handle = <&ethphy1>;
+	phy-mode = "rgmii-id";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&ethernet1_defaults>;
+
+	snps,mtl-rx-config = <&emac1_mtl_rx_setup>;
+	snps,mtl-tx-config = <&emac1_mtl_tx_setup>;
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy1: ethernet-phy@7 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <7>;
+			reset-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <50000>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		};
+	};
+
+	emac1_mtl_rx_setup: rx-queues-config {
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
+	emac1_mtl_tx_setup: tx-queues-config {
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
 &remoteproc_cdsp {
 	firmware-name = "qcom/shikra/cdsp.mbn";
 
@@ -103,6 +276,68 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&tlmm {
+	ethernet0_defaults: ethernet0-defaults-state {
+		rgmii-rx-pins {
+			pins = "gpio121", "gpio122", "gpio123",
+			       "gpio124", "gpio125", "gpio126";
+			function = "rgmii";
+			bias-disable;
+			drive-strength = <16>;
+		};
+		rgmii-tx-pins {
+			pins = "gpio127", "gpio128", "gpio129",
+			       "gpio130", "gpio131", "gpio132";
+			function = "rgmii";
+			bias-pull-up;
+			drive-strength = <16>;
+		};
+		rgmii-mdio-pins {
+			pins = "gpio133", "gpio134";
+			function = "rgmii";
+			bias-pull-up;
+			drive-strength = <16>;
+		};
+	};
+
+	ethernet1_defaults: ethernet1-defaults-state {
+		rgmii-rx-pins {
+			pins = "gpio137", "gpio138", "gpio139",
+			       "gpio140", "gpio141", "gpio142";
+			function = "rgmii";
+			bias-disable;
+			drive-strength = <16>;
+		};
+		rgmii-tx-pins {
+			pins = "gpio143", "gpio144", "gpio145",
+			       "gpio146", "gpio147", "gpio148";
+			function = "rgmii";
+			bias-pull-up;
+			drive-strength = <16>;
+		};
+		rgmii-mdio-pins {
+			pins = "gpio149", "gpio150";
+			function = "rgmii";
+			bias-pull-up;
+			drive-strength = <16>;
+		};
+	};
+
+	emac0_phy_en_hog: emac0-phy-en-hog {
+		gpio-hog;
+		gpios = <66 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "emac0-phy-en";
+	};
+
+	emac1_phy_en_hog: emac1-phy-en-hog {
+		gpio-hog;
+		gpios = <53 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "emac1-phy-en";
+	};
+};
+
 &uart8 {
 	status = "okay";
 

-- 
2.34.1


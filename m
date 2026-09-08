Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B2E3812DE
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 06:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848649; cv=none; b=CFyW6WXdWLf7fh+Q3hTjWCi1px5JgLypAf19IRmC2LbCku6qcOlc3nm7R5pwxNKbHZ5ZTjMGUFVZfMOrZ89oKzAQp+zbEh8iBSeCQWUJNxmbzyxoLbkSacCBZxnaM5sKH5F1gc0WoRGVkx3cHwQ0mUtkuOGegUb0HcqMS6L42Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848649; c=relaxed/simple;
	bh=/GuuipV5ZjIiafj0VbQ5D4TqDt1Bb+9GgJneHFtZyeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W58fYN937rgw4aSfTveUNd0uejGB9D5F2eVgzgN4pkIM9n842R8NefbAYrfzTgeWiLT/TLf6ei2CGy21WKxM/pALqE7l7q7ocErrU1lAMTzUxrMVc57ky4C3DaT+oqeikQ91npSPo3oDxb60fomd8zZPnsh77aLd7bbuPM+jHG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UrxW20v1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cEqT5qrE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UrxW20v1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cEqT5qrE"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886M3JW2363272
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 06:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	92WfmraFgzjIJBF4u5643LYqw/A6RaaeXEKXfqpkMVE=; b=UrxW20v1T93CuZbG
	tXOZX3uiZN08UGyRutI9aaQQsG9VdTvT5VoE7XZf0UqS3WUucB0k/LYOGxr94wEp
	1ORaIytr+IVQpXaZNVvjS6bey6aunQSFT9o49U7mlqtPRXjKFceAlI5RvxHyj8D8
	rJVBjetvGYuslDasBx9Z5+VoqV1Nqh6JVcxYwV7zTGmCIKZSCe9+ZjOqqnB5d0O2
	4fLgHjqem+Weu/htvK7xkNL8w1h4L/hT7QxXvR9nRJ+ZatqMEGhXhjG+X7jfhxG+
	4AxVHHGJjQ3OJVV96KOiNQjKTFo8B9cAqzVynTd1lNnMoK7n5NCY6popsrafoZSX
	9yY3cw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjagughwp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 06:24:06 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7f4e52682f0so6149043a34.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 23:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788848646; x=1789453446; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=92WfmraFgzjIJBF4u5643LYqw/A6RaaeXEKXfqpkMVE=;
        b=cEqT5qrEulW4nr4Wh337VCpky54IgPQX1163tweQXAuShQkovkDrD4TMHXpUw7nMFZ
         08xlWaCcPBp2oTGv4y0nVMc2x+djIluxhzfhmigDX0wRaXgoFi50tAEZZwYS0Ps8ed7q
         3KwBVC2lbYTMamrNZYIpGFE97u7YhPT2dyXzxEpoYBtEv97u+7L73Nfj6H6TmlZ/T87C
         OmvJcGbaih6hLkIAfla5Pmh3AWJjjj/3C/R06hTvNB+QW9fE5H1vY6H87iI2yK98ryCM
         hHBxBOOHrrV92T6R/JnapG4Acgas8AUNVDNWYV3vdnRQNFup4yyrO0ButK4NpBgc7i2S
         Ulqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788848646; x=1789453446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=92WfmraFgzjIJBF4u5643LYqw/A6RaaeXEKXfqpkMVE=;
        b=H/210nmY6UO0DoAsjpPTN0B2cnEaWJ0KnCFlDECCPktbkI3MWCSHzVO0VoPoONBiOZ
         g/OGutSYVWizwHeGlT/5X9YyQd76ZFM/JUY1YRuz1gvPMeXlKNerEDpIKTPNxswOh4ZX
         c0I/bR6VSjgQiBvNbswC3+254nnegsEpnmZcmo71LR2iWhhtIQdalOfh51vfLV4EfDoT
         88Cw5mzhKKF9mGgmgSMc5ofilWyOFmyP9srHgEIeeXDcqPp6vtt+apm1NnV+SdjHJbVZ
         eHwt5bwTM13umdM/omsHC34C+wJhd7MU3TtKZ9FkH/bj21yEb89riLG5sj+0ciEVnsV6
         K6vQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbbqsx65eY7Zi5tq0y+VU/XoK1qOyjATMftCtjJCHAYYBAG3lj3w7WZRAU39wHwb1phNyBe7c=@vger.kernel.org
X-Gm-Message-State: AFuF++mCGAJIjT3iHI8eIwIciniuq9DF/yRxMEPrAUFtuTATUcsxEzHG
	/1geFk6x3CjVEqY7C8ML64matHTlio2zjqoyavAKbKCPxUGGJnWwz+5VBvD0BNghKeC4kwbCs9l
	c1db8KEScRoyvcvrwIRAfA9d4uwaujor0viLAz1OUYhj2kgyOmRIBvmgSLvS49M/cDko=
X-Gm-Gg: AYBFou3jHiNE2y4TkW7X2iCON2jrnhLaGv+rXpGNQRcjOrI0xTGOriPnQ4mh2bYBCXK
	y19dHl4LNJAE2NqUaogW3OToLqD8PqM6tK45B2nrXWOJk4O0Yuk/gjz6zhORYZcJaSbHUU+IUnj
	LVlqJ0XeclNl0taxc7K/tZAJUawSK0uLZ2HfKWetSzqOoZn1F02VevvniOmmTBfQgUa3ckc9xo5
	ICZEUiRG5IlV7Ro3cIkWfe1Ad2j4tDyiez5VRBAZL/1boIgLdozWd0diOu6QDXAtglnVAlt4QAP
	CwEjsukWIgFwsB+szIZE1IXwR3ly+mVmhiyvj2hyeUghqvirVjqt/un59bDINmA8dw627jmWvkX
	8/ELNT23RvaZfZX0/9WGoi4Nu2duO1w==
X-Received: by 2002:a05:6820:f004:b0:6b0:5233:f69a with SMTP id 006d021491bc7-6b6fdbca26emr16108749eaf.30.1788848646018;
        Mon, 07 Sep 2026 23:24:06 -0700 (PDT)
X-Received: by 2002:a05:6820:f004:b0:6b0:5233:f69a with SMTP id 006d021491bc7-6b6fdbca26emr16108729eaf.30.1788848645547;
        Mon, 07 Sep 2026 23:24:05 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14332405e92sm26266297c88.8.2026.09.07.23.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 23:24:05 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 11:53:33 +0530
Subject: [PATCH PRELIMINARY 4/5] arm64: dts: qcom: shikra-cqs-evk: enable
 the first Ethernet port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-shikra_ethernet_dts-v1-4-69c0c5c7c124@oss.qualcomm.com>
References: <20260908-shikra_ethernet_dts-v1-0-69c0c5c7c124@oss.qualcomm.com>
In-Reply-To: <20260908-shikra_ethernet_dts-v1-0-69c0c5c7c124@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Anurag Pateriya <apateriy@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788848616; l=1888;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=/GuuipV5ZjIiafj0VbQ5D4TqDt1Bb+9GgJneHFtZyeY=;
 b=NrHQqFlLLixabJfOk4HMei4evExRyJitvdtHpEl0Q1CLXvpmd4Qhf7hQym6cIY5TP1h8j5ICy
 yWPt1Zz2HXbDzuFM5VOMsoNGmnWDPBs45tgD0S+tCVZsyXgeJakM5AT
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Authority-Analysis: v=2.4 cv=TqLWQjXh c=1 sm=1 tr=0 ts=6a9faa06 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=O40WLhOeGaaPd3mYGW4A:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-GUID: CfDaZzqRA3yuXc4_UZcm53a05mzusUjf
X-Proofpoint-ORIG-GUID: CfDaZzqRA3yuXc4_UZcm53a05mzusUjf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA2OCBTYWx0ZWRfX5Bd4b24v/LEl
 7KQMBo5CPZkTp1wPVquUKpTad7uS7eDJ/I2SOuDPBGXwSZzpJFv7vQD66MVpbWEAFBmoSUSv3nX
 /K/DrHixXvJ95+tE+MEeA8MlmbVUIU8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA2OCBTYWx0ZWRfX8hNOSnJqaoOj
 cVlHaS0eg9RXESwUfrF8FgNqzT6ntGX+KBLHYGi3oLsXRuJjz+8MQndImJxYJ+Xp46jwi0cqkw5
 J2E3YdJfS7BZDWno0eoa+Jte2RnWbqkoqkJwyvU50QAjRbTbeIvwuKdmga9/EblfFRgtleIj+FE
 1g/Fhn1jGRwqAQU4gKNtEFrwwUo/rupCGWVxBGRDOQD274PpWaPYbrpT31K0J3Y7IVzUd+VwhlS
 UvkYkJwlghSz4bmToq/2SNIjA9Iqk+Q32yG/Z5Lu+bW/XlvpwZpclJE7vBhmPDcMjfLtKyOIJnr
 HgX3sED2iQ0PbSnPgfZBFnkNI+7d7ZtzJ0OUdyW7bBUx2ao1oDxl0U6i8rCrL0HFYIn5cbUS0Zp
 WGqC+si1vgPgFyJPJmQSZpIwwqVbBb1uQRpkBNnGHxfBS5ncMeBqpWqzJnlmvkoCFY/qVr+7WBj
 u+nsaN5g/EWga/I3YvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080068

Enable ethernet0 for the Shikra CQS EVK board with its DP83867 RGMII
PHY. The PHY is powered on using a GPIO-controlled 2.5V regulator.

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 46 +++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index e62ba5aef71ff5b15e55810ae3d80a81e15e44e8..7b30c67c68e8c7161bfdd25168fe882b394b5558 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -21,6 +21,42 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	rgmii_phy_supply: regulator-rgmii-phy {
+		compatible = "regulator-fixed";
+		regulator-name = "rgmii-phy-pwr";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		gpio = <&tlmm 149 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-0 = <&rgmii_phy_pwr_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&ethernet0 {
+	phy-handle = <&rgmii_phy>;
+	phy-mode = "rgmii-id";
+
+	pinctrl-0 = <&ethernet0_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rgmii_phy: ethernet-phy@7 {
+			compatible = "ethernet-phy-id2000.a231";
+			reg = <0x7>;
+			reset-gpios = <&tlmm 135 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <50000>;
+			vdda-2p5-supply = <&rgmii_phy_supply>;
+		};
+	};
 };
 
 &remoteproc_cdsp {
@@ -57,3 +93,13 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&tlmm {
+	rgmii_phy_pwr_default: rgmii-phy-pwr-default-state {
+		pins = "gpio149";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+};

-- 
2.34.1


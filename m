Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAE753F68D
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074409; cv=none; b=JxrdtqdWuxEUoyD1ZSNvs5LnVm3ZWGvTOjsxj3DvuOUa2mz7qw8m5FH0uIBopN5VVIksp6AbCyMjZffrjkSYF5QLCWqjVzHs91eOIqgUrVmMaJFJOiCWhHqOY66dM9BWhKVqQZkTbkA0sbarKah8LeE7HRdNG91CCz93D6XPjII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074409; c=relaxed/simple;
	bh=7oRRkiyidCwIvpqmvaABEOiBgTKSng/ezBEoQKDR8V8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ecfeJkvlfwZlR55o/GkwrGiLS1Ku/UfemOyzROyxYIK5tRpme/d1Sgl5EBiBnOB2AK+niGC1l4xnbNDblwOQJf2DCuI94Fg4HwP44b1Sz4Z3qNXRdi5spmaaL5kdPQCG8Ue5PZt29/P+2FUyrDke0VegITuSQ2cf5zlwX6bWn6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sogn1RWg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Eb4uebjz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sogn1RWg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eb4uebjz"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FAPu8R1596370
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nX8NHCdH1mIPZ8Y18DIA0kViNrTV399Gnyrkc+b8WE8=; b=Sogn1RWgHxcxg1pp
	Z5d3c+Qq0Badn10+/9vMC4yk8oGB1T2GgMV+HVF/RGEaiARDbqSQc6+IZ8kU/Srg
	GLK2I2DEsUTqoMlfy8P7/T4NklP6q/Kcq6EKKBeGDQYceqVm1t/V7j0ZaoHQ9632
	EKWx7E5wIt+32amyoGkpGOfKAUzIF1rNnBk20DsiTLyMZLh1YsYACbJlpVBkYG9l
	/7gNO5sshWnNACTslxvYFPwdhK45MjbXkElGzxMJ8FWt/MNrVYb7ecyYi64Sih9B
	W2JkRBskDaJY7IEMIVOBBAVtEYtxllEZ8oUAVcFZQFc3GVN/Emp60S/9+XOS7T2M
	RT1nJA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2v8x9q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:26:36 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7cc0418036bso147780137.3
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792074395; x=1792679195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nX8NHCdH1mIPZ8Y18DIA0kViNrTV399Gnyrkc+b8WE8=;
        b=Eb4uebjznzcbjSOlmxymYPJ7vcXVF2DGDUljfX3M7VK4FnL6J0HHMGvl1xRRfFoLnK
         KvjWJhU1DnfOIdiIKvnRkG8MO4v//kFWlqUOmRY4bn7pxbh36XhoOZfHYqy3XWfA8sHj
         T1KDO2mVi+64XMa9LbHMOGj2C4J4sCPjhoxxojem3dt888Se9LaOPJppoZFk0Xhs6KEg
         Fp2wN//7bhr6FTWlMFFn/+1aLPYfAexEfyFuBpfKmu5ZqMhZH0roAhZXb4hnBzuJjMHL
         QIg2x/GGTFga62MKRfIobhD5ntZGAL2ZQ7L2gME0OcJyKtCO4C/MufTwOHRg1XuafFPH
         aghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074395; x=1792679195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nX8NHCdH1mIPZ8Y18DIA0kViNrTV399Gnyrkc+b8WE8=;
        b=gfazoBkFpzAyruiIzRy2iwoizWI02qPGDdVo8DRNnAwYaGWm8BjuDeMyZcWUEiftFk
         DSnqT7m/YapiBUMDuHgtBX2JvseUJsk5xBv5DB/YRfyKyMPlv1jJ2HWEAVgUWgxHsT+k
         Xu96M7SxfMxQtuFWPuyNJgiZZ5dXkZqlRJRj3hSIMIQ1twQA4n5Pxbn5F6KW6c9V/X4m
         cxczU/5uZJ1sDFrb4hpSbVCdKpt00UwK0KbcafoQJdg/hFfJGnx30br0Ek/d9gGLjonf
         Nl0THnHdwiW2+K6PlKGy3zsIr5d8S4htFLJJw9Yma+/jubj8+JgnWIzJ3SJ4d4HfPlbF
         ALqw==
X-Forwarded-Encrypted: i=1; AKwUvBwKpMTx3hyoSTuwYT/iOnaQMO4t5AH32MtRySySTM1S+jpj+TjEHqhyAar10c9QcSRE1XNlBKw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJm7M+6Oekk0xfgMLxsaq8SWiI9CRevBpRgXnCMveA675+yaVb
	xzlVwK1cQQDo7RegSgwh7aZ92CydUURBiO7EbCga8Y+krqLB3sChdpkKdB85ynekoRNSt77X/aS
	TF0xkt8WbYw+pxyAEHd0o7xNRvO9dhgfNlV2qPYt8jtFpe7m9k5wW1pjTFg8=
X-Gm-Gg: AYBFou12+VwHOr7SB43Eu92xzYu8ppoTpW3C+s2mp9/MXiiQ5lKRFIglZQ7v+xxKRwN
	1mYrvCGWi8puBr0bawk8mqYvU3coxsOJvtfbPIqb3ZWnBKAepqwj+LGNgOCnipH0Dv/TLN51Xc/
	hxNu8pYPkgLqhl+EynYGbSmNBieOlkL7SqSjhddMZSD+o0p2+3DaWR/Rwv7SM7A/7bOVUi0Rxht
	8YTl0UlQ6kTtovfCpZvM6SFJB+aA9W7pz3ap76hbNmdQfLb1x4TA+CvpdCfh1DZqayRbJ3/vErV
	p7phOcSe8BWC3XqrUAwP7Jk/wASSFPYF2QJTKhJ/qLzGaPPxcjU17ionVlS9IhD30wqgxKqpkmV
	vbSVucybTtDrsmFhQ4rgH/Csx2C2baIcFMvKsmsf37wX6GGvGXOxtsSrkEyRvw7mpoxfm3Mapbj
	FPtcYI5QyEJW6MQ3OtdgiCEiWgSFa6eHpBqz241FXkEBKcjPG+V+A=
X-Received: by 2002:a05:6102:a15a:b0:7cb:bbcc:e52 with SMTP id ada2fe7eead31-7cbbbcc11d8mr1668721137.0.1792074395021;
        Thu, 15 Oct 2026 07:26:35 -0700 (PDT)
X-Received: by 2002:a05:6102:a15a:b0:7cb:bbcc:e52 with SMTP id ada2fe7eead31-7cbbbcc11d8mr1668710137.0.1792074393563;
        Thu, 15 Oct 2026 07:26:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5402:5e0b:9ef0:9b5b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd6428b3sm69083145e9.1.2026.10.15.07.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:26:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:26:06 +0200
Subject: [PATCH v11 7/7] arm64: dts: qcom: arduino-imola: Add NVMEM layout
 for WiFi/BT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-block-as-nvmem-v11-7-f890ac74f87d@oss.qualcomm.com>
References: <20261015-block-as-nvmem-v11-0-f890ac74f87d@oss.qualcomm.com>
In-Reply-To: <20261015-block-as-nvmem-v11-0-f890ac74f87d@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1NyBTYWx0ZWRfX4Pjm1Kt7+yWt
 CmLW7YPTk8uy7arEeLiywq+tce5cE6pZiexoyKIXQxAwVlwkxhQZpUaNGGphXv7kwwzhC5WDXwd
 zWCpJGdPF2ELwUQKTrD07udUj76V7IIlqdL2YielQPhKQmDlWeIZn7ibWZskJc7GxEj5RFl4EW9
 xj7iE774x87JbvMeYCQr8AEIhS6Rki2FeIfwoCYjvDAqCWNmXdl55sgw+Ak6ggMx+G1BxGC7Sbx
 rpTLZQsZSKqPiTw5VFakjyqmDWTwDzG+cy65idsjKh8Ze3fAXTpGOloWDwuUZAvY5ryXSxkss9p
 aCVQ+OeDR6rQLb+YDxLDQ3Sx7I/eUlmff/4zwM82A+Pv3DgmNlUcZrSTqPoEUPrhIz02nDkP5cz
 O/9p21HquA14jhQb1ZgzyX1MK4m23hfMtzEm3KnWN8kGOuxjBwG0DFBaXUfEdP1UehUIehTv8S4
 youeqKWksfThGDH86Cw==
X-Proofpoint-ORIG-GUID: _BCcNbi3HykbCeOOktHEokiAho7d8Qu-
X-Proofpoint-GUID: _BCcNbi3HykbCeOOktHEokiAho7d8Qu-
X-Authority-Analysis: v=2.4 cv=G/CJgNk5 c=1 sm=1 tr=0 ts=6ad0e29c cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1NyBTYWx0ZWRfX6dj6fLtYoLjU
 EyHgrP4xRbl4eA1Pgb7DjmTXir4Nym5udAhwgZH+f5wIVV+6qEcHV8aN+hsPkG4M53Xb5Crs+dF
 LgAzUD9lSnVmX5tHGbPAoJeFSINZExY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150057

On Arduino Uno-Q, the eMMC boot1 partition is factory provisioned
with device-specific information such as the WiFi MAC address
and the Bluetooth BD address. This partition can serve as an
alternative to additional non-volatile memory, such as a
dedicated EEPROM.

The eMMC boot partitions are typically good candidates, as they
are relatively small, read-only by default (and can be enforced
as hardware read-only), and are not affected by board reflashing
procedures, which generally target the eMMC user or GP partitions.

Describe the corresponding nvmem-layout for the WiFi and Bluetooth
addresses, and point the WiFi and Bluetooth nodes to the appropriate
NVMEM cells to retrieve them.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index c472e13fceca4eb882a59af3be9f45022a923ead..582542c16f6c0ddd8e6fef3ef6b301ef33c5abd0 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -409,7 +409,33 @@ &sdhc_1 {
 	no-sdio;
 	no-sd;
 
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	status = "okay";
+
+	card@0 {
+		compatible = "mmc-card";
+		reg = <0>;
+
+		partitions-boot1 {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			wifi_mac_addr: mac-addr@4400 {
+				compatible = "mac-base";
+				reg = <0x4400 0x6>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			bd_addr: bd-addr@5400 {
+				compatible = "mac-base";
+				reg = <0x5400 0x6>;
+				#nvmem-cell-cells = <1>;
+			};
+		};
+	};
 };
 
 &spi5 {
@@ -512,6 +538,9 @@ bluetooth {
 		vddch0-supply = <&pm4125_l22>;
 		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
 		max-speed = <3000000>;
+
+		nvmem-cells = <&bd_addr 0>;
+		nvmem-cell-names = "local-bd-address";
 	};
 };
 
@@ -557,6 +586,9 @@ &wifi {
 	qcom,ath10k-calibration-variant = "ArduinoImola";
 	firmware-name = "qcm2290";
 
+	nvmem-cells = <&wifi_mac_addr 0>;
+	nvmem-cell-names = "mac-address";
+
 	status = "okay";
 };
 

-- 
2.34.1


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B5A4519AA
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427271; cv=none; b=LO4kbfyQWNwghOi20IuFkgnq2yLD4sIfOhdXsIxcxzkKphfwxqQwrUVSH5mRYFYnxsqZz6PVuYqH43CG4wGR6LAi/vUWXWs9kdBu8Kabf1lRMyGI8WxowQf4VmQo9biHu/ebVL4E7MR8HBHAzjiAp2RpgnE9lXTwW9/DN2c3oso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427271; c=relaxed/simple;
	bh=WoEsQQXEHcp3Z4NugaMqCjtqYrDzpmWHIggHogkIi2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9BzOQorfWe4dDz++VPhYFDskS+iJnniyLKaGTNdETSUpMJ4g76lGqDn4UYK+zr13tFaHNfd0qXcGHI21uFIt8phv+RPQQmPdA3fufdl6mRE64fmVgYx623qUdpodt1f5/4EXjECliuRVtXVDmRWnBchMo6vaDxFMeiR/LtOb4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=otwBB6sT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XIlShTwK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="otwBB6sT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XIlShTwK"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQqtH731410
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=; b=otwBB6sTYEC5Pwgk
	p/a56NEtduZLgnFOT+mUbwZmBYWofu/93DrVNEGesvn2u1NO1kpmMFM7Y/EP7vAQ
	AO13YWtHuG0oz/mSLBXD6mnMuDZhFC/5pqiqRnorHsmA68wDO/+wRCcq4UppCqev
	eT2yaes1u/23RpAQDNO1tmdcq1oYCaPSMEpD+D91MJQ+xu4fenU/TzQh73qK61Uq
	/TMmMHfwvxlyPIhE55OFFtX+GSYHkNr1kolzgGL3vrQdxzMPiTOEwTy9YG6N8coe
	3oW3PLoWqs2jRYri8450gqjUbt6X3pksaQFP7MsW5DgGcw87aHzTbVjCx0BCZt0R
	EdMuZA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8j7rfca-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:01:08 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-977cc430c86so810318241.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427267; x=1786032067; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=XIlShTwKkzIdXOFPe4qBOVxOT70qKjLoLWam7/CFqhqSajQQC/2ziVqrEo4e8+YtdX
         R01D6MOKpV0ENW7GOFnOIMLJXcWn7kwO6Su1VLxgvpFKrbNOUS95xuBODdy/jJt7RJiY
         8zF9TISp37I+Ob7kmTkIwkdxYmmfQvX3dqMT5+DyUZjwo/dtlcYRYuO25uoNk52csb0h
         iTW+28YL3U0/U3eYspmDAtbZEFdkA6KpkrnxbZoQgl5+BNQne2AvnFQzGdtKIyVMHfeM
         s3Ma9eXf+JDkO5UPAHT0TsNp0c4wUnnQ7DaY7kXVY7X3V4FuldjGxah8FvlAA65sB+qp
         aojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427267; x=1786032067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=RGOmHtbSa11cVhzGjOJAkkx3815fOEUTdkKJ60dzkoF0MMxukZunt2FpYRbdLOxEUs
         wob4NCywekLDItct++ehoqCZqqNwRf+sQ09nhKqyOAyW+uuBws9bYuRSaGxhjzy+nHKY
         hJG2Xel9LMko/pTmlsKap8iY1I+TOD9M/PgS0OOfg3eRrSPauJaJ0QoJHVo0o/S7OAtv
         Ec/yIV8QtoAppv/7dfuzekOt7JLjFDMeGAXbnjfLy1qnYYJoLsk7e6Dgx0OIg05P8aPG
         yHMkhi3aQxKwZXYqN2DyVtJ1dAv68xLfZiN4HxK97iMYjzhFEk92MuK+dUeIMxk9Fi8A
         JCnA==
X-Forwarded-Encrypted: i=1; AHgh+RqaQNZi2TTacSkpsSeDm+2mPQajZUmOmyG/XNElBxxyJuFx28uqvBmQo6eqyCjDrszu8MRN/Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEYBaREXG1T6BrwNH+6C+EbCYSDbvEnvbFzTCulRsc5iNYsF2h
	amy1fkAcMeItlv5ReVX++Cj+E9m6uY1YM6VYlpSP70xvKNdT9lPQw7ImUiKvZfg6xuTKbJqhDed
	lQycAEv2toGBO2MokBtkC7G/zYfOsFCgyJuyxAHO+JAMQeuDlINyhjRSzlSc=
X-Gm-Gg: AR+sD13ZieBwY7SABHySvcC6gNF0nGBZ95UHxB1ded+nbz3TWzZA+FckJgSS8l1EdFq
	KslI2R5+rWJVx+wQxsoScdSsh7OZVctDMUvsKSBEC7Hps60crvOnV72uKsdqf5TNH/3CLuPI1YE
	2/MrXr60/QrhXDlIWqwe+ddOTbkGnH4I5W5wfM1gu1Ks9t/q0rCN56fFAZ3SS1ekBDp2iwheKjW
	6fAw1Ty2m87AFI+PZgKfN+byFzRjhOGM/ndKz6lZVboElKAKKWXs3W+jcy2iRyNeMfa+/L/Lfr+
	MR2e8vIj3SzAtueZoTjQkO82LmxUV6Yb/AtC8h8HkTcZgvoFxCdL53rFrK65FHZzUEUCQeZqAIZ
	bmxV0wWliTFwySAP4WcY3cDz6EWwGQl8Ofir0SuoK3upzYiHeY+MiD3b+M5rEJUqFvOEuew6VGr
	u3D/1j2KyXHliCLtQ9I1MJu9pbhbxfTUluerSCNM8KOoBGzTYfUJXq
X-Received: by 2002:a05:6102:c09:b0:74a:84ea:4f6c with SMTP id ada2fe7eead31-7574ff6c30amr1313368137.15.1785427267061;
        Thu, 30 Jul 2026 09:01:07 -0700 (PDT)
X-Received: by 2002:a05:6102:c09:b0:74a:84ea:4f6c with SMTP id ada2fe7eead31-7574ff6c30amr1313267137.15.1785427266454;
        Thu, 30 Jul 2026 09:01:06 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:01:05 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:40 +0200
Subject: [PATCH v9 10/10] arm64: dts: qcom: arduino-imola: Describe NVMEM
 layout for WiFi/BT addresses
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-10-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
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
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX22tZWO1QdxyT
 VcgP07G5wIukWQw6wVTqzYtuYmhscZnmF4JCzTBBUFh+DUck8IzPqZRSQTSiMSYxxfqSDJWhBSA
 7g4v99tVmnD196dBnoZS3Ba3ZCUTVsaDjSQfq0UYceV/YTpkasClcLCM4+fd4g25IaLEVJiLGtW
 3kiItPwA46HtUIoYo6VOjeYXfTTLTmQvklrSyMWActK27pUhvzjxIhe/IafpTmG+iiEj2D/IokB
 aqY2F4ywK21bxoqe+d9JXw3VW8rUh9pvolNgOUaSdGf9vwTe7X8LnUUcu3dG54bRR1HRZBTSLyL
 6ZEomrRTzOtn04NYezOdi6bNNa7O5YfaWNKHmljL7I4pwQzde61cAnSyiCbPX2/TAglMHm0ZM5W
 pwVPxWTw6IOScnHoXtb/pWd+2cVVvXZ/G5sygHiMTIlonNZ1cxjqfJUY2EaFJw0iqiNCxYLLTee
 S23JtWXi8OQoBYZXwqQ==
X-Proofpoint-GUID: aG0udpDDASoyc1TMKumq3IApJuqMHm93
X-Proofpoint-ORIG-GUID: aG0udpDDASoyc1TMKumq3IApJuqMHm93
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX0Mk7rDHxcr4c
 00EJhBd4G0D9iTDU0RU0tip4wqIz6VDLkzxEHDgdBVwzTLqbEBhxskXUW196+0ARI8zS08M5AMr
 BRkoxWRLhKSSv3WiHGQr8EVXVdzbZ18=
X-Authority-Analysis: v=2.4 cv=LraiDHdc c=1 sm=1 tr=0 ts=6a6b7544 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300120

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
index bf088fa9807f040f0c8f405f9111b01790b09377..38839b8a361e76f6c1989924b16095b9d8815f66 100644
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


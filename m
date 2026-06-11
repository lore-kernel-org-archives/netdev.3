Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3D14C955E
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203083; cv=none; b=NH8PHAsoIkR3mdsuuPwup9P4Y2vRUlVSn0kivHuG/MtQSeRsw4T78rDHVT1wBBGBgdfDt/M2z1e0Oos/aSXxnl43+nhhOuh2HXIry5abVPFUR+PE0uvDh0yuzpXatmd/XT6NH80TOHEdgmuXALIppxOaH2tilm+ii4N4/g2fpCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203083; c=relaxed/simple;
	bh=37UU7e/cKf9GlE3GmqWgcpRWeSVBORd1mW2l04FMXQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=epKaDN22/+lE7PNszrpqr6QCZEMm88rYRAfF9N0uBxMGI1jGNRVhU5SiWb1KsN5d9iHbXf/apksS6aDOXVz04UTWguthaundz67vRbMjnmEtZD0au7ZAivkpXwypL7qhMIz7NLuGRnzyJJR9XhVSSk96tK8UsTr/+E90vYXoiNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eLReAkDq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T7XTgJtT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eLReAkDq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T7XTgJtT"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BIS4je1434230
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	biBbKAQ/jliorbg5WwizM2SwHjL/wKeTUXmlyHGAeBE=; b=eLReAkDqh7GSBx6+
	xK20IRF5mRcNLlRvEcUp0e3QWu4FpjLpKUl+SqlrxjnpJGUvc/PQMu8KW3qbsS6x
	FreFDqSjT8NKKRn5uksqe2h/jLtsogMc1OlJ4Yus7catu6wY6s5eSz7PvbEOVXJa
	t3HPUllcIxBaSNObfZdvHXsTHCh8UPdRQZP38xp/DQuBQtQA9HLn2/mCUwkQBN64
	O6Unn/nFmtPt0UthUFLr+ymQKGCmPKZ5GopyWUq1ahZATkzKZ4btyM6Lrsu1ItZ1
	hwWXv3srvkj7A5lcqSsHyf7qYo4W2P8OCdT1PWBE232y/RC8OoW+hIkHgBQ/uMie
	HyY7nQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqtb5jddt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:38:00 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8423f424d5bso142357b3a.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781203079; x=1781807879; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=biBbKAQ/jliorbg5WwizM2SwHjL/wKeTUXmlyHGAeBE=;
        b=T7XTgJtTfMF4k7fRzNozxkXOeNuuTKBpOfdFJQGPahMtd+7wNfVatxlyIpWE993X8C
         JCNS9EcMHmQPogOhr24sXNZn+UmkOD4bLkZ2bmk2zo4Kpt7BNEoa+ajAq+oTRlNzyzUw
         4aQSkZUqDG6axdn7cJzU7fx26SthCny9ZQop4Jr0IJ9S3/jR6Z54K8GBZTTbCL2TuAWg
         0WicgXEx8KfcXYJOHjaQOuCj+v4tNTWZIykGTNjR+ZtnWbmBypKBDUZzUdalbLZ3/B+X
         BOsCX88WQHR0WCGmxvyHGcl0WoWDlLnHcja4HyPtMQn1qQPThMEK8nxTpmC1eHxYH+qM
         YRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781203079; x=1781807879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=biBbKAQ/jliorbg5WwizM2SwHjL/wKeTUXmlyHGAeBE=;
        b=XWvvi9ZxD+SlCueY0sAtcsAg0GsWsU8FaI8cD10MmIP6FO9bqtXt4oVir+iKTsCNFN
         pDz5MKrZ9s8tEO6ug8E2qo3RNhPyJCSKLcVQn9eaIMv73iiYnFwf8bCpqpz7jz4h/e4h
         1hRLnVNuzJBLKQ4Gnil80HczWz7OOlETRWLx1moN7OAWTlWW5ebUXD5Vkhdk3mAd+zbY
         QQgE9DttUvahYF5a0Z3Nc4I439vks2Gkh04IQ7ok3KBQNQ1ajY8pW4TkLDWflSQI4y0M
         79sG/mnHns/7CYmLud+G0RopJ7xugnWgDnz4DV4kXKzi4NpUdftzmEwWbxdLG8lnqmPq
         9gVg==
X-Forwarded-Encrypted: i=1; AFNElJ8mzCAx2MFG3zNe9tyYM0W8VCUvKWjLRQNLZ1/lR0NBGk2vbvf2YssxRwUClVbK+QvqKw30rEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YweRegBfGjOAiQHH9eWJf8mqoVM+XRQhLEgNIxd2uR9T43ljNMl
	gvbLdOi771v9p+gpsZ5VQj5B89IXektIzkplcDB03vbNiyCLlOGa6xZw6X1L0NaUTowb0RX9Dt/
	UGRtWgi1CrRubS4O6DU3BiWtXAMQHClPYHFab24FwsvTmfzrpdGoMf5rWocU=
X-Gm-Gg: Acq92OFoIQ8WUxf2rMUWYaUXcvCHiVynBod68A0fX3elCqS8z9uI8iyCdyaK2kF3ayh
	zyHljjInVCP1ivbPgexi4cgpzQ6itPkpTjTRroGfLcLMz/1Vojzy82MU7J/b8LWHb2stgjddqsE
	QiNs59EALa8zblvSk4dOnXW6lk3hXC0F4kGSE2S7WRJtw8MRGgyTgZlXK7ecIDHVUU7KZ7iMpvZ
	MYw949wovBJw3Ga6QPwn8RQSDP78UaKVV2u0SsYaR/7i9npYVO8HjnaD3oexZHl7R0GgLNgitbj
	I7gffClFwpEqqIz8OzpPaV9Aqg97xJzmbBSA21bSJhyG9+LI0qA4LGMzPMTYsqeyCj79APfPQi3
	LsadbGxM6McceZ34R8rz13bDdGwAFjKqyUbTLr0WZYY/rs3fe/QM=
X-Received: by 2002:a05:6a00:3996:b0:842:2419:6bfe with SMTP id d2e1a72fcca58-843367c80d8mr4776308b3a.7.1781203079417;
        Thu, 11 Jun 2026 11:37:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:3996:b0:842:2419:6bfe with SMTP id d2e1a72fcca58-843367c80d8mr4776275b3a.7.1781203078859;
        Thu, 11 Jun 2026 11:37:58 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bbbfacsm2555666b3a.20.2026.06.11.11.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:37:58 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 00:07:03 +0530
Subject: [PATCH RFC 7/9] arm64: dts: qcom: shikra-cqm-evk: Enable ethernet0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-shikra_ethernet-v1-7-f0f4a1d19929@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781203027; l=3672;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=37UU7e/cKf9GlE3GmqWgcpRWeSVBORd1mW2l04FMXQw=;
 b=MhJgiFwQsYqNnejStdfMCaHyKzaDz3KQJdBU97MOITOsRWbwCfeLRz3OFGHS++DnH0f+vnXHf
 Ty6BeZNUQDlDwouL6b5BRIWwYgwZZ4xafmPFJxHHS99++YfNz4MQgiQ
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE4NSBTYWx0ZWRfXyVc4X/mKNIdE
 8mX6S+OxJarnKn30Bh48608yCFYWiqCuyottfL5USe1j6IZFM7HUliatgTdh4tHZ0+Xly5CCJ4T
 yYngPuBfE5sAhOphwkZVZk5zB0jE6pIMnyamj+NuTmfa/devgLZdidAVyQszoG/9cDAfgjKtTpp
 VO3zm5XDxNloOHqkskJg6kdTZ4+o3E3wP1gnk+sZ9o1pOPxBiHyH64U5NtHrwUl9YuvJK1TJqBq
 DizOtknrcd7psAYXQFvonV7re+770Fun78o3FfAlC/7gi+so0nN203z1qo4KgqTIciDCQF7qLQ7
 B+sP/2gpjZepSIeZYNDGRnWVoJg2Z78gmV3lDGro+JRW7TVublz8x/YJG1AanvX8dY5gwMVvc5e
 5q3tsjCimjJ3mzFddRoiV+MAJFGjOeoBjyxLt17U0GOoBE4wbGCiPAj0IbvASwFGKkgbIILj6Ui
 1G4jptFm7+i/byiGhCA==
X-Proofpoint-ORIG-GUID: hKpHKLlIBj7Sg7hFQXNGdtXQ2B7tSvFs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE4NSBTYWx0ZWRfX3E51xhmx1UQ9
 /Tjk1Hn3OJqhAun5eEMQZbRQw/qTJFNFV97W6gwx4ZSPxTccN+vjTQwg0F+0KhUZ8NzXQYuHSZh
 gV+rndyF9jFxJNtHNCQYPINJD2eO9/U=
X-Authority-Analysis: v=2.4 cv=e6g2j6p/ c=1 sm=1 tr=0 ts=6a2b0088 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=NHmBdxLQdYzBWVokJz8A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: hKpHKLlIBj7Sg7hFQXNGdtXQ2B7tSvFs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110185

Enable the first Gigabit Ethernet controller.  Add pin-control for the
RGMII and MDIO bus, a gpio-hog to assert the PHY power-enable GPIO at
boot, and the board-level ethernet0 overlay with PHY and MTL queue
configuration.

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 119 ++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index 683b5245923bbc1fb5df28ab7899d47a0cf8dbe7..6a6bcd2e712a1d4db5ceea4733751397779963c9 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -7,6 +7,7 @@
 
 #include "shikra-cqm-som.dtsi"
 #include "shikra-evk.dtsi"
+#include <dt-bindings/net/ti-dp83867.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. Shikra CQM EVK";
@@ -60,6 +61,92 @@ vreg_pmu_ch1: ldo4 {
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
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
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
 &remoteproc_cdsp {
 	firmware-name = "qcom/shikra/cdsp.mbn";
 
@@ -95,6 +182,38 @@ &sdhc_1 {
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
+	emac0_phy_en_hog: emac0-phy-en-hog {
+		gpio-hog;
+		gpios = <149 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "emac0-phy-en";
+	};
+};
+
 &uart8 {
 	status = "okay";
 

-- 
2.34.1


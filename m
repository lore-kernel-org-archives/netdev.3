Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1FC382388
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 06:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848638; cv=none; b=qmQZbQQ35OG21KgkhxRoc2JV7nDjry6WLdaMO/78np2cW5EhJ+R0SKM4KEl2Uz/G2WFtVHUXLqikGi06DdahEbwDQa0CQP7mDcZpIaP4ur4WAfXDRz8ey3V/OtrWaNUq/t9E/pTcgIDjrZYMdZpfHHfMNDv6FQyoLe+AIpHHQTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848638; c=relaxed/simple;
	bh=GQNafhw7SsElAAs1qp2DsVgJFQ9lddwuqnl7D1fxpKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SyQ2uGOjmgeJU2Xnx/mIh9edlJKQGNOl7ZoFNUmOdT4fzRcGu65UfVaAG9/hd2i9S5C/DHqmGD3CndngNevNGlT8BUTnRlYl5DzkZIpg87A6djSCxuTKYvBB5czAZrUBQUbS7jTV1a4MyJGlxvv1lyoDUeA0BpM5ZwygAgDeI58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SFtOrmV2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a0/bNUUR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SFtOrmV2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a0/bNUUR"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886LqKQ2154180
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 06:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0lIu+Ktu/jn9zS0EU0lMGL32bVWTggA6uIqxt6JqHBg=; b=SFtOrmV2PxexzCz1
	Y2nRa/muarc4VRoNc1IL/Ed63fOkivlj9fFbY/OYCuI7Jf96Vtvdzgx0eWcZOyQR
	HPip7i0Uyeg1QqZTUP6HaR34BLR1uzgKavJpXxCOb92oseaapo5xvklvZI9ezKdN
	rYxW9EyP+B3M0HeuVf/EiqjzeFgfhdL/yvsPr6VomV9j6t9NmIudehKmzy80ffiy
	ZLVQkbq20QVntMDeqp54SUgznS8/151ZNbWwqDbUru1h+bUgWAjyFFBEMz5BIdZA
	maXneuUC+Ex0CdrTH50pn0MlpjgvxpmCcXfxvvRuQx7pXa0GdKFIh71IE0S4sIRK
	A7b0UA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rwhy61-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 06:23:55 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c89704da8c7so5359935a12.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 23:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788848635; x=1789453435; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0lIu+Ktu/jn9zS0EU0lMGL32bVWTggA6uIqxt6JqHBg=;
        b=a0/bNUUR8/IphA6DueddWX46JqutWcM0Gz6df+XdoQNyTicN3JwH0UN+3kWaMXSFwF
         DlRGP3CMaQEZk6gouov3oxFVEIVN9ON45I5RtQP1ncXAWiI7cfJEjfLVQiMBnQDCkTww
         VHrAGWIQHSnFNDZ9tDDVZvJAfZQvQyTPhTl8AAs/VtMx6dNBSkjbGlKzVF5L4NUaEA1G
         vA4qiwOJpTf/IePHoGmbTMmZ0CnjPccfBIwODKrTc8k5Bzy5istkJW1Nt/Gue8s3ZW4q
         skDmdc4xzA2/y60PmQUL2+mjBvtEYc09QHJeZn6ppZD5w5AlhliR80O2HfLENfLhimoM
         T/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788848635; x=1789453435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0lIu+Ktu/jn9zS0EU0lMGL32bVWTggA6uIqxt6JqHBg=;
        b=l5NQD5Zuy55wgUxMDlnuzlP9AUhFuchkbXcHCyc2ltzlQxfyIBf/s3Dvzwec8n/ySu
         nMS1TJh/ZyMPCNUrt8BmBgGC3vflFuFnFQQsgIFoVE/oGWzwneQhqYEsN7FCW3Ycg7rB
         pHf6qowJz2YhfpMb9C0bMj1xCOaPAJt+IuVexR8yoSoUz8GeBY+WrhijgnsahGB5v+S2
         GGgcnbNGQ/f90ZGrH9Bz9rcVtzvEJO2k5tmyz3Q74YaT6s0iWz60fq0mTlBmNbot1Eyb
         NxDZ5BXp+bmC1RzG/Lfa6fiR5MuR3IhNW4zj5Z06l1njaZTXNO8PIpZUP9AKhyWngPR7
         Vb5w==
X-Forwarded-Encrypted: i=1; AKwUvBx/mCJn9y+KpQtfBCezqwipQpM/UsMV3vNIt4pQLGq+ok0GYU6KRsPIMkLq23jpPxdbYv+msa8=@vger.kernel.org
X-Gm-Message-State: AFuF++mUsd1kt3ymTWsn1aic87RGs6qxyi/aEyFccqEg8yHwkBRJwzmL
	APuiTfKV4NWEKV2KHgmkg63KMNgu4CsHNDIk6ax5tbcyoEbtfN/84f/Mj0bi3ZjPUgphF4bt6X9
	Q73EwQNsb6EK6B9cbyaEJFyCiWfImZ3AWeGoM8LmDdt63WvIpF/83t+tSz/llHM7z93g=
X-Gm-Gg: AYBFou1H+s2IrxHoSHwrzSz5+wR5lARRVlaAJQKPBDJ/+dyLArPG15lcuJdS6Wb5+2R
	cjLD9wzuYdC6+7Eq6n/6EglLOhsVO/m+jDFqXB4Meg3YAp8mScEIhjtOwQfybB3WygMGLfBt3kI
	lVNtPypBoGVUHE5WKcGGmNzd5haYoIdE13ZG28YR0wLGvfbx1SpekWjsAvihnNn1ZiMVjB4tN4U
	DoMsA6RK69jUnaH+yyzma55VYONW5RAAHsPFB39j6jQDb3nUZEoSCenJ5jEvgYDT/khCkZAO+qT
	X//mcc5p+tb9DPpuNGs0C4+F72fQan0haFvY8DgewzZplNyb2FBJMu1c/FC7p7B5+INlUFPOJ1+
	yUMaOgg6bNn8s1uLowwSXLvy+QdjoGA==
X-Received: by 2002:a17:90b:1d45:b0:398:9bd4:d1a with SMTP id 98e67ed59e1d1-39b262995b8mr40498350a91.25.1788848634540;
        Mon, 07 Sep 2026 23:23:54 -0700 (PDT)
X-Received: by 2002:a17:90b:1d45:b0:398:9bd4:d1a with SMTP id 98e67ed59e1d1-39b262995b8mr40498273a91.25.1788848633957;
        Mon, 07 Sep 2026 23:23:53 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14332405e92sm26266297c88.8.2026.09.07.23.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 23:23:53 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 11:53:31 +0530
Subject: [PATCH PRELIMINARY 2/5] arm64: dts: qcom: shikra: add ethernet
 nodes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-shikra_ethernet_dts-v1-2-69c0c5c7c124@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788848616; l=7791;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=GQNafhw7SsElAAs1qp2DsVgJFQ9lddwuqnl7D1fxpKg=;
 b=FJXOmH0pEodwzK46zuEb/7HqJAfdh9ii3dvWxA0FdtWJO5Ep8m1K5lystd5NbYjnDtGx0huqb
 cfvJTtV4u+2AHto7GHxUPh+fVSjxkBoNPW/MOVEzx0vifSVQN5yH/9k
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Authority-Analysis: v=2.4 cv=Ga8nWwXL c=1 sm=1 tr=0 ts=6a9fa9fb cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=_T14SV3i9OLNUwAfLiQA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA2OCBTYWx0ZWRfXyuNABkTN65qQ
 6qi+hs/+eE0Vzz7da02BU4mg2QArOC8l1W4JE+HlLlf4Px8B/82iQE4bZgN0sy5FdmIUaNqEfPX
 GWwC2OBNloV9oMEaheWTOdcecjnDO+/RVjmJwGZn86isqX76CV2cMA0a59v9zTM7klesau36gJH
 L6SzxlfeZnage4hM8VLtTQP1BLv2OyI8J835m9BNbZrQECd8MmASbgc+W+1eslvnYLFq/wUSYav
 R0dqzwps64b6WT90TrTPmKvpSaiEIeb6XdI6K2plY2x9JDcjS111kk3xuh153dFHxmQkbtPRFBk
 tW65ErymMvkGNPRoMYFvPZ3VOh4TSZENtNOpa/wlsdX2VEpHP1a0LMWLGWKvq7ZIkh2Y9qWdKHX
 E1Gc1eOcxyRUS5UeBPTEHS+G9iadP9fDaCMZFiIinLnWzojgTRMv/0SgvT+mStuMF4g2WPusaoY
 22HpJiWhNM288lMET2Q==
X-Proofpoint-ORIG-GUID: 4Fo-ygft0sPAQrdMOGDbGNsxgQT9C_CG
X-Proofpoint-GUID: 4Fo-ygft0sPAQrdMOGDbGNsxgQT9C_CG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA2OCBTYWx0ZWRfXwHZonJRL2Wp1
 8xmk2epLurfmjcSk5PvvUnFmIXRG/2w30KTk7KRb97qHiOWC1z8hP8A2S5n1LYhtYDtOVxEvGlG
 HdXEhNpF+Lf1pelMvtLlVvCsX6I6Dng=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080068

Add the two Gigabit Ethernet controllers present on Shikra (ethernet0
at 0x5d00000, ethernet1 at 0x5d20000).  Both nodes are left disabled;
board files supply the PHY details.

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 266 +++++++++++++++++++++++++++++++++++
 1 file changed, 266 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index c1f06f692f66452c6ee1b10f3ef12c20e201b5ce..a55e20be83fe2d132eb91878e76b666b8694da55 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -631,6 +631,56 @@ tlmm: pinctrl@500000 {
 			gpio-ranges = <&tlmm 0 0 165>;
 			wakeup-parent = <&mpm>;
 
+			ethernet0_default: ethernet0-default-state {
+				rgmii-rx-pins {
+					pins = "gpio121", "gpio122", "gpio123",
+					       "gpio124", "gpio125", "gpio126";
+					function = "rgmii";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				rgmii-tx-pins {
+					pins = "gpio127", "gpio128", "gpio129",
+					       "gpio130", "gpio131", "gpio132";
+					function = "rgmii";
+					drive-strength = <16>;
+					bias-pull-up;
+				};
+
+				rgmii-mdio-pins {
+					pins = "gpio133", "gpio134";
+					function = "rgmii";
+					drive-strength = <16>;
+					bias-pull-up;
+				};
+			};
+
+			ethernet1_default: ethernet1-default-state {
+				rgmii-rx-pins {
+					pins = "gpio137", "gpio138", "gpio139",
+					       "gpio140", "gpio141", "gpio142";
+					function = "rgmii";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				rgmii-tx-pins {
+					pins = "gpio143", "gpio144", "gpio145",
+					       "gpio146", "gpio147", "gpio148";
+					function = "rgmii";
+					drive-strength = <16>;
+					bias-pull-up;
+				};
+
+				rgmii-mdio-pins {
+					pins = "gpio149", "gpio150";
+					function = "rgmii";
+					drive-strength = <16>;
+					bias-pull-up;
+				};
+			};
+
 			qup_i2c0_data_clk: qup-i2c0-data-clk-state {
 				/* SDA, SCL */
 				pins = "gpio2", "gpio3";
@@ -1977,6 +2027,222 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 			};
 		};
 
+		ethernet0: ethernet@5d00000 {
+			compatible = "qcom,shikra-ethqos";
+			reg = <0x0 0x05d00000 0x0 0x10000>,
+			      <0x0 0x05d16000 0x0 0x100>;
+			reg-names = "stmmaceth", "rgmii";
+
+			interrupts = <GIC_SPI 478 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "macirq";
+
+			clocks = <&gcc GCC_EMAC0_AXI_CLK>,
+				 <&gcc GCC_EMAC0_AHB_CLK>,
+				 <&gcc GCC_EMAC0_PTP_CLK>,
+				 <&gcc GCC_EMAC0_RGMII_CLK>,
+				 <&gcc GCC_EMAC0_AXI_SYS_NOC_CLK>,
+				 <&gcc GCC_PCIE_TILE_AXI_SYS_NOC_CLK>;
+			clock-names = "stmmaceth", "pclk", "ptp_ref", "rgmii",
+				      "axi-noc", "pcie-tile-axi-noc";
+
+			power-domains = <&gcc GCC_EMAC0_GDSC>;
+			resets = <&gcc GCC_EMAC0_BCR>;
+			iommus = <&apps_smmu 0x0380 0x0007>;
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ALWAYS
+					 &config_noc SLAVE_EMAC0_CFG QCOM_ICC_TAG_ALWAYS>,
+					<&system_noc MASTER_EMAC_0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "cpu-mac", "mac-mem";
+
+			operating-points-v2 = <&emac0_opp_table>;
+
+			snps,tso;
+			snps,pbl = <32>;
+			rx-fifo-depth = <16384>;
+			tx-fifo-depth = <16384>;
+
+			snps,mtl-rx-config = <&emac0_mtl_rx_setup>;
+			snps,mtl-tx-config = <&emac0_mtl_tx_setup>;
+
+			status = "disabled";
+
+			emac0_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-120000000 {
+					opp-hz = /bits/ 64 <120000000>;
+					required-opps = <&rpmpd_opp_svs>;
+				};
+			};
+
+			emac0_mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <4>;
+				snps,rx-sched-sp;
+
+				queue0 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+					snps,route-up;
+					snps,priority = <0x1>;
+				};
+
+				queue1 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x1>;
+					snps,route-ptp;
+				};
+
+				queue2 {
+					snps,avb-algorithm;
+					snps,map-to-dma-channel = <0x2>;
+					snps,route-avcp;
+				};
+
+				queue3 {
+					snps,avb-algorithm;
+					snps,map-to-dma-channel = <0x3>;
+					snps,priority = <0xc>;
+				};
+			};
+
+			emac0_mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <4>;
+
+				queue0 {
+					snps,dcb-algorithm;
+				};
+
+				queue1 {
+					snps,dcb-algorithm;
+				};
+
+				queue2 {
+					snps,avb-algorithm;
+					snps,send_slope = <0x1000>;
+					snps,idle_slope = <0x1000>;
+					snps,high_credit = <0x3e800>;
+					snps,low_credit = <0xffc18000>;
+				};
+
+				queue3 {
+					snps,avb-algorithm;
+					snps,send_slope = <0x1000>;
+					snps,idle_slope = <0x1000>;
+					snps,high_credit = <0x3e800>;
+					snps,low_credit = <0xffc18000>;
+				};
+			};
+		};
+
+		ethernet1: ethernet@5d20000 {
+			compatible = "qcom,shikra-ethqos";
+			reg = <0x0 0x05d20000 0x0 0x10000>,
+			      <0x0 0x05d36000 0x0 0x100>;
+			reg-names = "stmmaceth", "rgmii";
+
+			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "macirq";
+
+			clocks = <&gcc GCC_EMAC1_AXI_CLK>,
+				 <&gcc GCC_EMAC1_AHB_CLK>,
+				 <&gcc GCC_EMAC1_PTP_CLK>,
+				 <&gcc GCC_EMAC1_RGMII_CLK>,
+				 <&gcc GCC_EMAC1_AXI_SYS_NOC_CLK>,
+				 <&gcc GCC_PCIE_TILE_AXI_SYS_NOC_CLK>;
+			clock-names = "stmmaceth", "pclk", "ptp_ref", "rgmii",
+				      "axi-noc", "pcie-tile-axi-noc";
+
+			power-domains = <&gcc GCC_EMAC1_GDSC>;
+			resets = <&gcc GCC_EMAC1_BCR>;
+			iommus = <&apps_smmu 0x03a0 0x0007>;
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ALWAYS
+					 &config_noc SLAVE_EMAC1_CFG QCOM_ICC_TAG_ALWAYS>,
+					<&system_noc MASTER_EMAC_1 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "cpu-mac", "mac-mem";
+
+			operating-points-v2 = <&emac1_opp_table>;
+
+			snps,tso;
+			snps,pbl = <32>;
+			rx-fifo-depth = <16384>;
+			tx-fifo-depth = <16384>;
+
+			snps,mtl-rx-config = <&emac1_mtl_rx_setup>;
+			snps,mtl-tx-config = <&emac1_mtl_tx_setup>;
+
+			status = "disabled";
+
+			emac1_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-120000000 {
+					opp-hz = /bits/ 64 <120000000>;
+					required-opps = <&rpmpd_opp_svs>;
+				};
+			};
+
+			emac1_mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <4>;
+				snps,rx-sched-sp;
+
+				queue0 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+					snps,route-up;
+					snps,priority = <0x1>;
+				};
+
+				queue1 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x1>;
+					snps,route-ptp;
+				};
+
+				queue2 {
+					snps,avb-algorithm;
+					snps,map-to-dma-channel = <0x2>;
+					snps,route-avcp;
+				};
+
+				queue3 {
+					snps,avb-algorithm;
+					snps,map-to-dma-channel = <0x3>;
+					snps,priority = <0xc>;
+				};
+			};
+
+			emac1_mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <4>;
+
+				queue0 {
+					snps,dcb-algorithm;
+				};
+
+				queue1 {
+					snps,dcb-algorithm;
+				};
+
+				queue2 {
+					snps,avb-algorithm;
+					snps,send_slope = <0x1000>;
+					snps,idle_slope = <0x1000>;
+					snps,high_credit = <0x3e800>;
+					snps,low_credit = <0xffc18000>;
+				};
+
+				queue3 {
+					snps,avb-algorithm;
+					snps,send_slope = <0x1000>;
+					snps,idle_slope = <0x1000>;
+					snps,high_credit = <0x3e800>;
+					snps,low_credit = <0xffc18000>;
+				};
+			};
+		};
+
 		remoteproc_mpss: remoteproc@6080000 {
 			compatible = "qcom,shikra-mpss-pas";
 			reg = <0x0 0x06080000 0x0 0x100>;

-- 
2.34.1


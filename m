Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B025C40F758
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792230403; cv=none; b=HVOhM9FF8YpJ0XuEAgzzoh80UQn+PJVcL3wHCMWaqv4PZXmrbOyyklzA0YBG5YbI0jWTgod26P1PiFTG4Ie6/VGZ+SBwt+zbtrhKdDknZqHj7uiurIzqOvkbaHF+6MXxLXvG0/aUCQJZsQHX3jC9ZR4B0NXzemlVDP72ZlHIsp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792230403; c=relaxed/simple;
	bh=Ipht7m9Et6WvFOLhnDe2Rp01r1bPZoZU3GVWVCK2PoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B8MqXmmIuuxe2ztOqHdid5Cq1jwwkKvJyizOKKbJ8RgFFtmCWfTqP0unoef29kSy00nzLD0LHIgmQFpNrtr9Dll8BJUSofWs7QR8fr1Tnw5QXSIlgDF0WOk/3f13fTpwoppCYP3kYxVOnBWGAp36GFWvg8mZR/YNUNUlyUptCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eHo3FNIT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f6YkxYJz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eHo3FNIT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f6YkxYJz"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H6o3ed390197
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HwyNx8squDcGRhqcv88DwHvZJrpnm5bfNBtJw6lqDOI=; b=eHo3FNITcM89OI38
	nuR3/J5lz/UH6jTyBY1osa0kDOEiXFMvbnRtC68yNWLSZcmrlWKkj2tcJAEYeWpM
	aEcbL6vgK9Y/s+39XV9vwONp54XQncMMO4MO2Ck7GWUcknnwcq239oOu3rVuJd76
	EJcwasKdXULBJQA/QOB1z7pE+DphPMELqZ/6gbc4x0X2RCyq7Q3h7QOJfJKFjDsV
	VoZpCtlngRZ35rZBruYIGUs8GXwtr3ynXN0ZqbfDSsrg8D7nxHgOTkFJtrcaOJpN
	yHX/YLqovGji/9qP6ednoBen9w6YvDBer4xUHxZNQPcuORsIapxeR/GGABt7al/g
	glPKgA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc1838mnk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:46:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35fb6be0f9fso1829967eec.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 02:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792230400; x=1792835200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HwyNx8squDcGRhqcv88DwHvZJrpnm5bfNBtJw6lqDOI=;
        b=f6YkxYJzvMFABdV2Gn0nK1ygvbO5QmQ0CCmdwTvDOrOLPBRqQgPohp2S3UsPyBdein
         l2TmQuBRxIyR6YzXP47Vy7RNUM24Yml95doV8Oh59zZSgFzlsmi58rbpbVrkHbqqyJBY
         ArDsdwImrUnXOUcBqZF4ZA8CygPht5Sj4DfI614i9E5pPFekeWHHDthmLJUPWq4hVpu3
         ncYhLpy06v+Z5z/oMHphFh4DJVa0z71KvsEA9zpmgnYqCz5rDGLvumYpMzpl5bxoNFgT
         ZBqkAB0Lau3rkeQ9nwH91uCx4ZXxoI+CynzfUII/joM+ka1zBAYVxlBo9bd4OD2IYSwK
         c31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792230400; x=1792835200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HwyNx8squDcGRhqcv88DwHvZJrpnm5bfNBtJw6lqDOI=;
        b=cY2q19wZWbA5OEDV6iyK9DwqA/aLwmTZzI0hCGVZmnmsqxxd8U3EKcnyucz0QuJjUa
         DIt/KTiv7PzaHSao2Zbszkv/Hp7Yrd4V68xKIZC0xnKtNfUPrWdguI/JYZmKfd/IrLeP
         xlcltsjM0fimpi0y7BxvfYwrSEL2w2bR7o9RJaCz7ozfTaT8c/uqJRxr/TqVtFctOIr+
         xqq/eS+N/pwNukwccw154D0LHLtujXKau+pBBsbXJyOjasNkeuF+DD1tqJw5c2WCDDzv
         kezCd3V+US4UKke8AQl4+oBtwvcV0fQeto6zt9hDJ8bDxR5yQrRTWH/kIofhljGYWHJa
         DyfQ==
X-Gm-Message-State: AFq9FYIaIUdN8k8c4OVgrPcClMod1YJNsMlr1yFI21OC8ow5rRmqM+UR
	WLC0fS4fhGgT6D2EtKlQhwbe8D0U+exjOUBuRzJjBc6/jwdvrWyz7D4I6llhvJwjtNmFeFCV5V6
	S1Ckkrb+XLqQRYQbogvk+i+3+wZ4xhPZmm9k0OcKUh4nHl26NGCcXeln07Po=
X-Gm-Gg: AYBFou1vNgot0LWdyROIMLMgqhO+ED4c5G3u15WZOsqEI8BvK1FLhwfNJ1VksF9f9d/
	wC1MtcOzq63M/7o3NWvOE5PHtQB71Mwq3t5juB3cu1LADR8jK3PLA+3TmQ6Yy7JNTH8VRXOi7eR
	d6hlFHxZ2Q7ohgxKhDttMhkAg2A77D6RQgotbGs6g/eJEAaYBsGDpP7ItjxFaWaYzoxOhuhdSsF
	rtSQUyiqTIU5z09Gg2+260vMIZDi+26PxDv+E2x+LSR2OUFsE/Hmznq24vmJIUftjc/gdJPXV5q
	JBiliFX42WJVez5tzuFJ+kTMFbZIxIZX4EDtKLbNBmA4m5vbMIgT13NTuWXO2eJdTccUxkpvTpO
	Tgt9ohmE8aFlr9m3T+sf/NlFwE4CW5w==
X-Received: by 2002:a05:701b:2059:20b0:144:fa57:c617 with SMTP id a92af1059eb24-18513e7b77fmr3436992c88.34.1792230399719;
        Sat, 17 Oct 2026 02:46:39 -0700 (PDT)
X-Received: by 2002:a05:701b:2059:20b0:144:fa57:c617 with SMTP id a92af1059eb24-18513e7b77fmr3436956c88.34.1792230399102;
        Sat, 17 Oct 2026 02:46:39 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f58c2sm19450327c88.11.2026.10.17.02.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 02:46:38 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 15:15:18 +0530
Subject: [PATCH net-next v3 7/9] net: stmmac: qcom-ethqos: share common
 GMAC4 address table
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-shikra_ethernet-v3-7-26a8beb44b8f@oss.qualcomm.com>
References: <20261017-shikra_ethernet-v3-0-26a8beb44b8f@oss.qualcomm.com>
In-Reply-To: <20261017-shikra_ethernet-v3-0-26a8beb44b8f@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
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
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792230324; l=4125;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=Ipht7m9Et6WvFOLhnDe2Rp01r1bPZoZU3GVWVCK2PoM=;
 b=0buwP2KxV6FyhlLYOfmxajy/KEdIt1S8Rh/NuxnaHT76EhURWfHYmoQVQKm4g9as3SDyHp1ni
 wedUK5aj9tVCvXMzEfgegErU8ZNfPz1M6Sl6op8Yaep/85PSKFYUJ6I
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAzOCBTYWx0ZWRfX2gU+zeRR0A0U
 LPMuhFrdSz+o058bzSy8+3S3t22JBZgZDMAdcKimvvn4+xpW7wieE89a+dfIA+NGgvs8QbGrHqe
 IfiIM8tPuK0L80mt1VexUS4JmhQX+kk=
X-Proofpoint-GUID: OT3CnLE1-2TeDwPkNApo3ZwyrD3aItgX
X-Authority-Analysis: v=2.4 cv=Bu8IUoX5 c=1 sm=1 tr=0 ts=6ad34400 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=koHM5ydvv4bFC7S24qUA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAzOCBTYWx0ZWRfX8G00U9S6h+ut
 OzVTx7eMXd55A0qkwkM0DeEyiAYyy79QzMCHnDo6CuwVEIXxQotq0iAyiPDfyCdltJfU90hfmSB
 ltyTblX9bWtJXb+k+WwvLxAFemuOva69amKTQ6g+oe+jeXnTchJvmcMWngXJa5FwKw4DecVnHKL
 hM0cA/6hWSrDomYkM1O1CIFQ+GIU2SLLK+JP02APvKZd09wyyfqf9AvaSOW6eJyKGlMkzDJzgdW
 3ZkBYGDTHN9k0r9R8GvwVksuHypnS0szB9UiuTX4diIcZxPwvq+HLODZSmognMXT6yR+5y3yHo0
 8ES91HsiZZ3Je/76v5DhVk46ZSjaAoDrFxEtjui0vSOelFW6DbJVAJptw8cQBevD3XKb7QCAJD/
 kq61zQ/N5IzBn6Tuvqrt2SbypghwEj6al1cCgv3uo9paT7bbIbfWI6E/UYB0K1rOaPjfdHbtuw5
 8R4T1d3XLgsiJmwjzww==
X-Proofpoint-ORIG-GUID: OT3CnLE1-2TeDwPkNApo3ZwyrD3aItgX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170038

Several ETHQOS versions use identical GMAC4 DMA and MTL address offsets.
Store the descriptor once and let per-compatible data reference it.

Use its presence, rather than has_emac_ge_3, when passing it to stmmac
core. This keeps address-table ownership independent of the feature
flag.

No functional change intended.

Suggested-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 57 +++++++++-------------
 1 file changed, 22 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 2471871562ed9915398614d5c88d1c6673829db8..370eb05caabc00a20d887ac88c1ffa4473bc4021 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -96,7 +96,7 @@ struct ethqos_emac_driver_data {
 	bool has_emac_ge_3;
 	u8 dma_addr_width;
 	const char *link_clk_name;
-	struct dwmac4_addrs dwmac4_addrs;
+	const struct dwmac4_addrs *dwmac4_addrs;
 	bool needs_sgmii_loopback;
 };
 
@@ -247,6 +247,23 @@ static const struct ethqos_emac_driver_data emac_v2_1_0_data = {
 	.has_emac_ge_3 = false,
 };
 
+static const struct dwmac4_addrs ethqos_dwmac4_addrs = {
+	.dma_chan = 0x00008100,
+	.dma_chan_offset = 0x1000,
+	.mtl_chan = 0x00008000,
+	.mtl_chan_offset = 0x1000,
+	.mtl_ets_ctrl = 0x00008010,
+	.mtl_ets_ctrl_offset = 0x1000,
+	.mtl_txq_weight = 0x00008018,
+	.mtl_txq_weight_offset = 0x1000,
+	.mtl_send_slp_cred = 0x0000801c,
+	.mtl_send_slp_cred_offset = 0x1000,
+	.mtl_high_cred = 0x00008020,
+	.mtl_high_cred_offset = 0x1000,
+	.mtl_low_cred = 0x00008024,
+	.mtl_low_cred_offset = 0x1000,
+};
+
 static const struct ethqos_emac_por emac_v3_0_0_por[] = {
 	{ .offset = RGMII_IO_MACRO_CONFIG,	.value = 0x40c01343 },
 	{ .offset = SDCC_HC_REG_DLL_CONFIG,	.value = 0x2004642c },
@@ -261,22 +278,7 @@ static const struct ethqos_emac_driver_data emac_v3_0_0_data = {
 	.num_rgmii_por = ARRAY_SIZE(emac_v3_0_0_por),
 	.rgmii_config_loopback_en = false,
 	.has_emac_ge_3 = true,
-	.dwmac4_addrs = {
-		.dma_chan = 0x00008100,
-		.dma_chan_offset = 0x1000,
-		.mtl_chan = 0x00008000,
-		.mtl_chan_offset = 0x1000,
-		.mtl_ets_ctrl = 0x00008010,
-		.mtl_ets_ctrl_offset = 0x1000,
-		.mtl_txq_weight = 0x00008018,
-		.mtl_txq_weight_offset = 0x1000,
-		.mtl_send_slp_cred = 0x0000801c,
-		.mtl_send_slp_cred_offset = 0x1000,
-		.mtl_high_cred = 0x00008020,
-		.mtl_high_cred_offset = 0x1000,
-		.mtl_low_cred = 0x00008024,
-		.mtl_low_cred_offset = 0x1000,
-	},
+	.dwmac4_addrs = &ethqos_dwmac4_addrs,
 };
 
 static const struct ethqos_emac_por emac_v4_0_0_por[] = {
@@ -296,22 +298,7 @@ static const struct ethqos_emac_driver_data emac_v4_0_0_data = {
 	.link_clk_name = "phyaux",
 	.needs_sgmii_loopback = true,
 	.dma_addr_width = 36,
-	.dwmac4_addrs = {
-		.dma_chan = 0x00008100,
-		.dma_chan_offset = 0x1000,
-		.mtl_chan = 0x00008000,
-		.mtl_chan_offset = 0x1000,
-		.mtl_ets_ctrl = 0x00008010,
-		.mtl_ets_ctrl_offset = 0x1000,
-		.mtl_txq_weight = 0x00008018,
-		.mtl_txq_weight_offset = 0x1000,
-		.mtl_send_slp_cred = 0x0000801c,
-		.mtl_send_slp_cred_offset = 0x1000,
-		.mtl_high_cred = 0x00008020,
-		.mtl_high_cred_offset = 0x1000,
-		.mtl_low_cred = 0x00008024,
-		.mtl_low_cred_offset = 0x1000,
-	},
+	.dwmac4_addrs = &ethqos_dwmac4_addrs,
 };
 
 static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
@@ -830,8 +817,8 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	plat_dat->dump_debug_regs = rgmii_dump;
 	plat_dat->ptp_clk_freq_config = ethqos_ptp_clk_freq_config;
 	plat_dat->core_type = DWMAC_CORE_GMAC4;
-	if (ethqos->has_emac_ge_3)
-		plat_dat->dwmac4_addrs = &data->dwmac4_addrs;
+	if (data->dwmac4_addrs)
+		plat_dat->dwmac4_addrs = data->dwmac4_addrs;
 	plat_dat->pmt = true;
 	if (of_property_read_bool(np, "snps,tso"))
 		plat_dat->flags |= STMMAC_FLAG_TSO_EN;

-- 
2.34.1


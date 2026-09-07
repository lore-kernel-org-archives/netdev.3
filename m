Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8240E41835B
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812708; cv=none; b=h8OQj5GUIcaYTksNOyrWIdrmBqXGjlohcD1Hm2cbLe/FqhOrTYjYvAV87AmW3fGWztNVUdQQSgpE+LQ/SnSxb59T6P3FmuJbJZYNXDATaTUbTqglsy5Vqe9LsWUf3YSSUHKJ9FW+UaWcmF+Rehb81P+fzqG+nIx+Sx3l06MgMdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812708; c=relaxed/simple;
	bh=KsLk75r2w7Y7Td996D/f1RY9lIMY3ClaAGPh1T4xOuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=emXrKTwhncoDRqgZarU1xgODe8OTD0xayutm+XEAHrduQI6ldj/uPu0PdmRqHXoV7flWrefDK2ocFUUQMGZpKuqQfVEdTLuw3OG7JQj/nX2CyHU/P9yDgvYAxg4ZTY2P+spXrMTb6FhkS4YSgSZfvtO9iZBYpMTprDU/YkafZJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T4PlL33X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e//UOjji; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T4PlL33X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e//UOjji"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687H7mMd3484609
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 20:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hrvy+QoVG0RLYoH5IBz54YMeR8SjZQtO5lp7S4xTaVc=; b=T4PlL33Xk5zjDyxh
	BUlto0g8F5GJA1rMWVho56/UPhEgBpa/mWZ44L0nFhxxBesK6Q1CrjnoQPzPXzG4
	UN4i5ePBHUpBptW4fo6NEjAkgiSt4uVx/YIu2NvRuGbLfUkv2V0x/K/Sds2kOS7u
	XzgMUGLwY8gRY5IpTY0kI0T8F3bdc/b+zXXIA2p6sXl6alBn4YeRtHuMeUQnSCMW
	xpzRJeCeuZB8wvrroUJpamTu7CwvU10JlSQyvjTaEK5dqC0M4QZUt32wSAuBnX/6
	HyNGUiWay4EnOU5H4Roy50/BdILONCtYj5A30283rnN/EEO3mK0sNZqvI1xY+2ID
	rdPFCQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtty25a4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 20:25:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfca8558d2so48015465ad.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788812700; x=1789417500; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hrvy+QoVG0RLYoH5IBz54YMeR8SjZQtO5lp7S4xTaVc=;
        b=e//UOjjiKNLR3BDrZUIgM/ikxp43dQpVIyCGBSE+0GBuWpk44fbnn4s3tWCkpHgHqg
         ciCalBhc6ZoiBI5qPSAU6Mb6D+gSksqL+nkzlGCwdBLjDDBjS6lwLRoG9KQau2t77PKY
         H3v420/qWew1aVIsWYhrvm6IbQN+wqRMDbkeekeww+mTNBpa1o9FK6sPxX4N242iIv3m
         e00xNqZig7flrM7bVc1Et9D645GAmZV8BUneJZfBrN595OWjbz2FZCAs6/iZ+6GqukbO
         JSg2kJwvxNfv1h1wvQM1MrZJZUWyBGKYFmGzQZ2eiYvx/spBrQifGfQC/iHlgncYRx0L
         gm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788812700; x=1789417500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hrvy+QoVG0RLYoH5IBz54YMeR8SjZQtO5lp7S4xTaVc=;
        b=AKZz6/HgCOyfsbBw94vAI13ctZ8kas6yZjtFWxLuooEcmqGIW2O873WW150CkGULdA
         LFmyWAGqNhw0SLTklIptNaKUXcvpzyxPWZxhiYShMj06ygGVJunoY46OM503GrPhAbqk
         aYHr+zHT9zVV4SvrUhSTCh/RG897CzndoFTthYDIJRIgu/EC6vlIFpnQ0oZTS7drMVuk
         eKfGmGh1h1gIzFpWHp4o0psE6AH7g73eNygo/dMslhojbOzFBW4d+wUF2yjumpUlK50l
         qCcjZM2YrEIzWExl/JMV5UoBCsBkNtvXOU/Nkj+KXHvWO9pvlOzRGTXs+rP1oWCaptUW
         o03A==
X-Gm-Message-State: AFuF++mxzH4gxbcZPC5ugAjAbWhrdE89lD4hh24Hn1oe7tYrB9ULJ+VF
	EAODNSa3z6UAFMnDhApjhO22X8jOpYL0vzIz4moy1omigy9CyR6G4dlKjRUKdvoIdjWtn4bbb/Y
	PX0CdP6dF1og4vkVwgwlGCSA+A2osn8YVJ334lsE7kARdLRQGqjfWyZAEbU0=
X-Gm-Gg: AYBFou21Giqj4P/MkMzKOXFaZGj2SqsHPNO+HcOGeuO563Pi2iTZaWR5A9ZxCzWv1e4
	mnFRIO8IOykZjVjKDfC6JKZmHqFEXRNb75lvuA/pNONTcABfHnIzC3e9lLTEEd9b5s0mrDzXeJl
	TKtMRSo8zsn9tG/L9DUCMeZqGaaPsOSfCqIJRJrbLnKkntOy2v5hrGcOpOEmH7j2Ep7ABrAt3jP
	lMDe0TCEVQxJ7gFuW8K3jEubN3jEyGpgF+QtWY2zX102NdhBt8b0K6f1kTfhm/7rzveajyKgPuv
	SqShwWxUrXAwLaA9xDJsF0QUGE3oIFHR+HT5+L/v2QPBncwnE9ihTpfBUa9yUa33oltaFNvx8lF
	JRIwzNoiJawyZde82AAhZpNb19w0Y5w==
X-Received: by 2002:a17:903:4b04:b0:2d3:160b:c01f with SMTP id d9443c01a7336-2db124b1ae2mr337578465ad.6.1788812700529;
        Mon, 07 Sep 2026 13:25:00 -0700 (PDT)
X-Received: by 2002:a17:903:4b04:b0:2d3:160b:c01f with SMTP id d9443c01a7336-2db124b1ae2mr337577745ad.6.1788812700084;
        Mon, 07 Sep 2026 13:25:00 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm30482259eec.19.2026.09.07.13.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:24:59 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 01:53:21 +0530
Subject: [PATCH net-next v2 9/9] net: stmmac: qcom-ethqos: add Shikra EMAC
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-shikra_ethernet-v2-9-bbe3389d0652@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788812616; l=2805;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=KsLk75r2w7Y7Td996D/f1RY9lIMY3ClaAGPh1T4xOuA=;
 b=dBBGlbQ+PXRK8wV2RTj9A9/IfrTUGHY9GlnPObuNyviClmSFJez2HMSBuIgjBJYSaU6yfzIKP
 OhRIpYexXv8CIc9lrWT634bEjV/CIGTmd+QQsDzMWwxUsfQ4OwMfErw
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Authority-Analysis: v=2.4 cv=QNBYgALL c=1 sm=1 tr=0 ts=6a9f1d9d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=8IO8aBILldGQKMPJy6sA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: bPN33LrRQzYT-1MR82wtMJ86Et_fQL3Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDIyNCBTYWx0ZWRfX96fmtJoO5WcW
 ankEL3AGjCqpMJdSUGDmfw1LJb8eww2S4JfOOUu+J6Y3B0XYw7P9pHwbfnvlt84UiK1Hq3J/ydd
 iz5HnnxY6A7kY+aKl07RP1ULqGpg4is=
X-Proofpoint-GUID: bPN33LrRQzYT-1MR82wtMJ86Et_fQL3Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDIyNCBTYWx0ZWRfXwMLnpjLQmQpU
 tZ6w+LuQFC8DsmB7v3ar1hbhijsd8/S2ksrzDbZepxDjkHVWBAeXZ6MS+rhkM6kAUX3AjIyOzRC
 10wjpEXd4t0oqXkJBQN9u4exZsy1Yh8xuQej8JyQ8aXDxqxgXc6CDaEY2tq6HvimETPb+3dPYuV
 sa6uDBar4fu8FVvwdyXAHwEWTlv9CitljjtaqjzW1jYC+I9H95pTf3uYbLqrupXxvUvehpSW+w3
 fzdIX5U2GPSCl7LC2QT/TyYM1w0LhnttOPkOvbQDK9Ll11VewXkfYFwHmjrtZH8scS/fm2JTo7p
 nXE+hoNFddbADsQeOJsw1pHg7nN0IWm51rn3oaAhhMljUCqQgPU1MlN9hcRRr1n9Arb/zkfVBim
 hrxRouws/pmaqwGP2zk0iY6vkpJ+wn4U1Fmx4Xm52JmH4LCH++9zFRUQgUhOyjDwH/AUQtCsDP1
 hAEm0JJShQlXWyC5T/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_05,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070224

Shikra integrates two Qualcomm ETHQOS controllers based on the Synopsys
GMAC IP, similar to previous platforms.  Register qcom,shikra-ethqos
backed by a new shikra_data descriptor that enables the three NOC clocks
required for DMA memory access (axi-noc, pcie-tile-axi-noc, stmmaceth)
all at 120 MHz, and the 36-bit DMA address width.

As part of the NOC clock voting logic, the qcom-ethqos glue driver takes
a second enable reference on the "stmmaceth" clock, which is already
enabled by the stmmac core. All three clocks in shikra_noc_clks[] must
run at 120 MHz for NOC access, and managing "stmmaceth" through the same
clk_bulk path keeps the rate-setting and enable/disable together.

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 8871d285941162c72e2a8f79d2eef915d9283796..c474f1e5a043777a52bcbff8a488640f6dbdca30 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -328,6 +328,36 @@ static const struct ethqos_emac_driver_data emac_v4_0_0_data = {
 	},
 };
 
+static const struct ethqos_noc_clk_cfg shikra_noc_clks[] = {
+	{ "axi-noc", 120000000 },
+	{ "pcie-tile-axi-noc", 120000000 },
+	{ "stmmaceth", 120000000 },
+};
+
+static const struct ethqos_emac_driver_data shikra_data = {
+	.dma_addr_width = 36,
+	.has_emac_ge_3 = true,
+	.noc_clk_cfg = shikra_noc_clks,
+	.num_noc_clks = ARRAY_SIZE(shikra_noc_clks),
+	.rgmii_config_loopback_en = false,
+	.dwmac4_addrs = {
+		.dma_chan = 0x00008100,
+		.dma_chan_offset = 0x1000,
+		.mtl_chan = 0x00008000,
+		.mtl_chan_offset = 0x1000,
+		.mtl_ets_ctrl = 0x00008010,
+		.mtl_ets_ctrl_offset = 0x1000,
+		.mtl_txq_weight = 0x00008018,
+		.mtl_txq_weight_offset = 0x1000,
+		.mtl_send_slp_cred = 0x0000801c,
+		.mtl_send_slp_cred_offset = 0x1000,
+		.mtl_high_cred = 0x00008020,
+		.mtl_high_cred_offset = 0x1000,
+		.mtl_low_cred = 0x00008024,
+		.mtl_low_cred_offset = 0x1000,
+	},
+};
+
 static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
 {
 	struct device *dev = &ethqos->pdev->dev;
@@ -962,6 +992,7 @@ static const struct of_device_id qcom_ethqos_match[] = {
 	{ .compatible = "qcom,qcs404-ethqos", .data = &emac_v2_3_0_data},
 	{ .compatible = "qcom,sa8775p-ethqos", .data = &emac_v4_0_0_data},
 	{ .compatible = "qcom,sc8280xp-ethqos", .data = &emac_v3_0_0_data},
+	{ .compatible = "qcom,shikra-ethqos", .data = &shikra_data},
 	{ .compatible = "qcom,sm8150-ethqos", .data = &emac_v2_1_0_data},
 	{ }
 };

-- 
2.34.1


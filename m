Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B4141835B
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812697; cv=none; b=EfBhXNmHLAncJbdZ8eOEqwklvhOnuZWFZ0vyA8tERROX+b5MoJ1LLu/MjJr6QSJjd8braV2rspX/AUmq9vOllcgk6XgyP+LnAmYDRL0QXw0XCOGB6Xd5mQrj92QY9HwHpOM+0JrazU1c0JCtmToF+b0YoUhmp7TwPFxfrJVI/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812697; c=relaxed/simple;
	bh=lKQMPlISxVjQ0B3VRRfDDxS4lZ4Pq36AYneIrLWTVa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qVXutQX11zbE3aK9PEa6EkSLhMTftZqG8r838ZHD3GcxLhUP3YoBkdwYJQwuSihsEcMg8XNH7U7pjkfHqx3F8MULZrX/sm+CnmlYk4RWFaquwaf/GHhNzDh/Z98I6AzTRzwx5kqQZYQQMlbOWQHRYtljnHWraIXvdrDvnxklgIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fq8CTt0/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ib4O9iI3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fq8CTt0/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ib4O9iI3"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687H7n6F1314404
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 20:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t3omiMkZWtgzaHHRt1sFImgBtpza9a0r1HxxkeHWh5k=; b=fq8CTt0/rfiOYHVQ
	QSGtjR/Clx7j3W0tx/g11l7kYCgJu+Esjpy3lz21RxIdEgCslX/AGWbPMVwmwRlE
	Sdg7/TG9CFrU6qOvETH8qBdmrL33rlkDywZNvjTRBEXrfk0k28KR5x+cBAPXLzVm
	HNhVuA8kxQxJCcHLOKUFarXqESXMValUWhXq7q3P74WV2YUX0LUr/qH8lOy2NlBa
	cxKuWOQSMJbKJLlIrAOIwKkPwYMCE819yX2dy6cLAI1BzV+ME0XVPPDyCgd8qZR7
	IjQRAdrE9zyhJPMmi8LE8baHO+3LbDJ9KB7Mcbw9ho30Lggw1Wp7M+W/XwnMCp1k
	gdHufg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghuyk9uxa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 20:24:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398d292eac1so8104744a91.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788812692; x=1789417492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t3omiMkZWtgzaHHRt1sFImgBtpza9a0r1HxxkeHWh5k=;
        b=ib4O9iI3xuqzrMQe0QT/NF679RX4xsjE4l54QyDoBg4Nv5qG0xmBBEA4KO+uD3xAKR
         iWvh5Rk3chOqkqUSBjyhwGuCHGYf0sZRn2ZZbfYqkAiYTmVWxj6pebE7JB7sU1dUnEAl
         1EodyehxlgUwJiEl3kj1j6D/t9pSkdPSsOExcmQNPEsF6tZUbEfUsGaNaZCNpKrMB7vK
         SbMNMKlJy/MUyVysLdJl7iQ8o3PatnIFnW0WGd/kxIGtrCoX/MxHvCNSRmd2fMi5Zmn3
         Y1OFnLGcEW1VdnhWNEoaMduVXffMuf84mcnb6ClFWQfNka2c3aYRejmLkYcDPrIxvBcy
         733w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788812692; x=1789417492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t3omiMkZWtgzaHHRt1sFImgBtpza9a0r1HxxkeHWh5k=;
        b=Kj3EZcbZlrnYFL8/VzmXROCO+ZlNZE9pVUmGSG1nj3jXYaPm5BVywQZ08Upfmmlrw7
         2Twj2S5I/OBWk88khHK9y0vRGsh17nYfcKhZF/+ZgC82mke7gCYcxzFmkzlUxLOqZXpH
         vHCfi9Bsge42x4tJDiao/s5+bNFoC0RH4t0LqWijMValVJkVNji86c+PKYroAf+VSO3t
         e6AyDMcP5OI6KHp0XYs56tSAfixnC5mME+UEgtIRmywFKfeiOwg6M0l0YyJrHVOyfW8a
         SywvpMBGNtazJiQGA8Fro9Owd+GwJZpCT69QGsz6JXmeCepQxfEeoWkK6vt9sw1BlBF5
         mPHg==
X-Gm-Message-State: AFuF++mLnLqb9F9cWdJJAZEDb83V0XsQnYm7vKY0mUDsrHMo5/iX4iri
	KjvG92sZGRgGSXZVuYXk/CugT/G27gwXwhVGMldvERZZ/yskT64qEB17zRTG3SO8L9XDGXN4rTp
	UbkKyN0tQFw92cRRSDUANTkf3/V9k686X5g/PDxw9wsdVdvk3xaz4vhn6bTo=
X-Gm-Gg: AYBFou1wWoP3k1KtNzKnsA+7XNHxcI4jLk6OBMHljcU/71Frp6VJHbN9cXJ5keNCEK6
	1/PRmGhC1dDpFOqw0K8Vm3fzVb2N3iROXdJTlA/IslHNtdcuXLptjK6uTTzc4qvrGgvg0stjejj
	vj7amDMwRjU3BkFni7QmFsfZWxUtXIUs0eJS643CH76z+SV61hfqsG0zlwNkY1vGcR7phVU4oEA
	jFicK6DRVJ3jeHTsKsWf12SEuLdX6kaTo3Vq+GH5qw4TlrogXJ+0QjgVnDkrOC/fqxUYTBX963k
	qXEBKZ72pHOM3E4yApHT+uXRZAkU7Y/TCxdStaz6G9ek3mrQT0ljebbPLx+FvSlKjvul5nmi9iX
	tSbnfCpIEr1kN9pSHI0Nq2GrDn/VUkA==
X-Received: by 2002:a17:90b:390f:b0:398:de23:9af6 with SMTP id 98e67ed59e1d1-39b261b216dmr36938663a91.15.1788812692210;
        Mon, 07 Sep 2026 13:24:52 -0700 (PDT)
X-Received: by 2002:a17:90b:390f:b0:398:de23:9af6 with SMTP id 98e67ed59e1d1-39b261b216dmr36938594a91.15.1788812691719;
        Mon, 07 Sep 2026 13:24:51 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm30482259eec.19.2026.09.07.13.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:24:51 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 01:53:20 +0530
Subject: [PATCH net-next v2 8/9] net: stmmac: qcom-ethqos: add per-platform
 NOC clock voting
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-shikra_ethernet-v2-8-bbe3389d0652@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788812616; l=6498;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=lKQMPlISxVjQ0B3VRRfDDxS4lZ4Pq36AYneIrLWTVa0=;
 b=FD9Eh3b3BBC8+5eruwt91ntgGZGPwaLxcrjqWpb/c4z1D+jjsLiyHOSjy/TA7jPdlXslyKU+v
 PVh28r2jXSaDoUDm0Qrrpr/70G8RXVu4KBKDUnHKWbC/CpkZ0MDmHUw
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDIyNCBTYWx0ZWRfX99J+Vw6Wp9LO
 krkoC0bsoMLlnnD0DBJiShaxqedvDoI4pei5/y05Qw4WNINjLSubaIGE2Fp+peBRfqYojqwM/VM
 MdxNIMpw4UHShn74Pja1/GNSXXA+EMU=
X-Proofpoint-GUID: dfREVbM4Y3KoLRehEZjJjn4VEhLmD41g
X-Authority-Analysis: v=2.4 cv=ObSoyBTY c=1 sm=1 tr=0 ts=6a9f1d95 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=EpEVno_IuBtMqvs2hnIA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: dfREVbM4Y3KoLRehEZjJjn4VEhLmD41g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDIyNCBTYWx0ZWRfX1IaEFgroynxc
 lrNMN6qOjWaP5rJxWE4bBmg185wUAZATwTCkUU2gcKDfbgjWnQJAnkizVIVDDIEZZ8FwHw2tmSO
 nWjMCp58ifJaLa/Rg8YcntsyDSZDwigHgi5Mk0HMzogNBQpqGuU6jIMW8fwyhlDUw7jb4FeOe2V
 r1JW1PQ7WbDvF+cO38BKNUW1AECfAoijdIjhqf8LbxasQg1toTVU/FU+Q253cBBb+6UR9zpfXyd
 FleHvtXoz1srN5fpYlQEcB8MVi++pOC0bxdnA+zG0rZXzFQKV2Vs9DNZNlJf1XifkoHmtlpua3x
 8W1s968NWtk12ZtN2Z5/Di2m5a/jGD/mhrJd+layvJ7J0aqaz1jq00+lNn0yPjB/T7vJlHiIqoc
 pc3rxHkH9kDhIlTImYv6ahZwzc3Fe/8ItbYIJ4KV+DvKQtsMmeTV2exDMREYatzrZi0qS13ETw0
 D0z59Brl0IM1uIty30A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_05,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070224

Some SoCs gate the EMAC's path to the System NOC behind dedicated clocks
that must be enabled before the DMA can reach memory. Add
ethqos_noc_clk_cfg and the corresponding fields in the driver-data and
runtime structs so each compatible can declare its own set with per-clock
rates.  The clocks are acquired during probe and enabled/disabled
alongside the existing link clock in ethqos_clks_config().

No functional change for existing compatibles. This will help us when
we add support for Shikra.

Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 106 +++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 2471871562ed9915398614d5c88d1c6673829db8..8871d285941162c72e2a8f79d2eef915d9283796 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -7,6 +7,7 @@
 #include <linux/platform_device.h>
 #include <linux/phy.h>
 #include <linux/phy/phy.h>
+#include <linux/pm_opp.h>
 
 #include "stmmac.h"
 #include "stmmac_platform.h"
@@ -84,11 +85,18 @@
 
 #define SGMII_10M_RX_CLK_DVDR			0x31
 
+#define ETHQOS_MAX_NOC_CLKS			3
+
 struct ethqos_emac_por {
 	unsigned int offset;
 	unsigned int value;
 };
 
+struct ethqos_noc_clk_cfg {
+	const char *id;
+	unsigned long rate;
+};
+
 struct ethqos_emac_driver_data {
 	const struct ethqos_emac_por *rgmii_por;
 	unsigned int num_rgmii_por;
@@ -98,6 +106,8 @@ struct ethqos_emac_driver_data {
 	const char *link_clk_name;
 	struct dwmac4_addrs dwmac4_addrs;
 	bool needs_sgmii_loopback;
+	const struct ethqos_noc_clk_cfg *noc_clk_cfg;
+	unsigned int num_noc_clks;
 };
 
 struct qcom_ethqos {
@@ -112,6 +122,10 @@ struct qcom_ethqos {
 	bool rgmii_config_loopback_en;
 	bool has_emac_ge_3;
 	bool needs_sgmii_loopback;
+
+	struct clk_bulk_data noc_clks[ETHQOS_MAX_NOC_CLKS];
+	unsigned long noc_clk_rates[ETHQOS_MAX_NOC_CLKS];
+	int num_noc_clks;
 };
 
 static u32 rgmii_readl(struct qcom_ethqos *ethqos, unsigned int offset)
@@ -689,15 +703,51 @@ static int ethqos_mac_finish_serdes(struct net_device *ndev, void *priv,
 static int ethqos_clks_config(void *priv, bool enabled)
 {
 	struct qcom_ethqos *ethqos = priv;
+	unsigned int i;
 	int ret = 0;
 
 	if (enabled) {
+		if (ethqos->num_noc_clks) {
+			ret = dev_pm_opp_set_rate(&ethqos->pdev->dev,
+						  ethqos->noc_clk_rates[0]);
+			if (ret) {
+				dev_err(&ethqos->pdev->dev,
+					"NOC OPP rate set failed: %d\n", ret);
+				return ret;
+			}
+
+			for (i = 1; i < ethqos->num_noc_clks; i++) {
+				ret = clk_set_rate(ethqos->noc_clks[i].clk,
+						   ethqos->noc_clk_rates[i]);
+				if (ret) {
+					dev_err(&ethqos->pdev->dev,
+						"NOC clock rate set failed: %d\n", ret);
+					dev_pm_opp_set_rate(&ethqos->pdev->dev, 0);
+					return ret;
+				}
+			}
+		}
+
 		ret = clk_prepare_enable(ethqos->link_clk);
 		if (ret) {
 			dev_err(&ethqos->pdev->dev, "link_clk enable failed\n");
+			if (ethqos->num_noc_clks)
+				dev_pm_opp_set_rate(&ethqos->pdev->dev, 0);
 			return ret;
 		}
 
+		if (ethqos->num_noc_clks) {
+			ret = clk_bulk_prepare_enable(ethqos->num_noc_clks,
+						      ethqos->noc_clks);
+			if (ret) {
+				dev_err(&ethqos->pdev->dev,
+					"NOC clocks enable failed: %d\n", ret);
+				clk_disable_unprepare(ethqos->link_clk);
+				dev_pm_opp_set_rate(&ethqos->pdev->dev, 0);
+				return ret;
+			}
+		}
+
 		/* Enable functional clock to prevent DMA reset to timeout due
 		 * to lacking PHY clock after the hardware block has been power
 		 * cycled. The actual configuration will be adjusted once
@@ -706,7 +756,12 @@ static int ethqos_clks_config(void *priv, bool enabled)
 		qcom_ethqos_set_sgmii_loopback(ethqos, true);
 		ethqos_set_func_clk_en(ethqos);
 	} else {
+		if (ethqos->num_noc_clks)
+			clk_bulk_disable_unprepare(ethqos->num_noc_clks,
+						   ethqos->noc_clks);
 		clk_disable_unprepare(ethqos->link_clk);
+		if (ethqos->num_noc_clks)
+			dev_pm_opp_set_rate(&ethqos->pdev->dev, 0);
 	}
 
 	return ret;
@@ -734,6 +789,51 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
 	netdev_dbg(priv->dev, "PTP rate %lu\n", plat_dat->clk_ptp_rate);
 }
 
+static void qcom_ethqos_noc_opp_cleanup(void *dev)
+{
+	dev_pm_opp_set_rate(dev, 0);
+}
+
+/* Some SoCs gate NOC access behind dedicated clocks. Acquire them here
+ * so ethqos_clks_config() can enable/disable them at runtime. The OPP
+ * table is used to propagate the required VDD_CX performance state via
+ * dev_pm_opp_set_rate().
+ */
+static int qcom_ethqos_init_noc_clks(struct qcom_ethqos *ethqos,
+				     const struct ethqos_emac_driver_data *data)
+{
+	struct device *dev = &ethqos->pdev->dev;
+	unsigned int i;
+	int ret;
+
+	if (!data->num_noc_clks)
+		return 0;
+
+	for (i = 0; i < data->num_noc_clks; i++) {
+		ethqos->noc_clks[i].id = data->noc_clk_cfg[i].id;
+		ethqos->noc_clk_rates[i] = data->noc_clk_cfg[i].rate;
+	}
+	ethqos->num_noc_clks = data->num_noc_clks;
+
+	ret = devm_clk_bulk_get(dev, ethqos->num_noc_clks, ethqos->noc_clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get NOC clocks\n");
+
+	ret = devm_pm_opp_set_clkname(dev, data->noc_clk_cfg[0].id);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set OPP clock name\n");
+
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add OPP table\n");
+
+	ret = dev_pm_opp_set_rate(dev, data->noc_clk_cfg[0].rate);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set initial NOC OPP rate\n");
+
+	return devm_add_action_or_reset(dev, qcom_ethqos_noc_opp_cleanup, dev);
+}
+
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -795,6 +895,12 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	ethqos->has_emac_ge_3 = data->has_emac_ge_3;
 	ethqos->needs_sgmii_loopback = data->needs_sgmii_loopback;
 
+	if (data->num_noc_clks) {
+		ret = qcom_ethqos_init_noc_clks(ethqos, data);
+		if (ret)
+			return ret;
+	}
+
 	ethqos->link_clk = devm_clk_get(dev, data->link_clk_name ?: "rgmii");
 	if (IS_ERR(ethqos->link_clk))
 		return dev_err_probe(dev, PTR_ERR(ethqos->link_clk),

-- 
2.34.1


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F453C988D
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461707; cv=none; b=R2+iJXyVTWq+KNNBAefVu0VPJCX/61FcTTodLI+k+35hLMdqyls4YJVw1jVeCRVT87StLcueyLr6Kiz1+iFb+d3wKmKZCCZpGhZfAiQpb2KJCOBkufsy4944WO5BUrZBZnOVgK/WMDhrzNMCjM/rb0dNie34HVo+L8dBvhvGhak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461707; c=relaxed/simple;
	bh=3qNv1gt53nDwmaZH3husajnhbdisLPvYiqw3RUvnSA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZyOnWOd3kjSXFDl5fgQJXWANsA2kdk9Bb7yD6mAOAKwjYQh9A9qL0rH2yFsO/cpM2+cDqsUFjQffXcR+IjWqwic7zrj8MjkEyqAaoPa/omq3+M6HMb67uhdN87H50w8skAD/0XqmW1mo1fQA1xUhqvXAAN7m8s52Oz2jp/n4cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ahrb7FLx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OU8kW518; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ahrb7FLx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OU8kW518"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G36vS3958146
	for <netdev@vger.kernel.org>; Thu, 3 Sep 2026 18:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IRq6FO1Wgh0OU+E4Zz5vIqKFC7LhLdGz4RbBzOB8Y1s=; b=ahrb7FLxlCP9y0bt
	cAFx5oVRJmHjZABg1PjfYicyMyRlnzwjhT0sfbeXfAsw21iU5V4JsBUewn1K/31F
	3Miho5zFr3Gf/F0BBBjANjTFQi6cHSa4S6uCOKQc2DJ0hBYvCCXts0akge/QkKs9
	lLc0jaXuHweSaVnhUvF8zCOR64vAM4n6/07lYyiexdagP38bDnqXxjRe1zgE5GKN
	iChl/GFMoeAb2mG7cZB5PGJaHp9HnNlrqJbxiEBLBaSjXZ4lFPBtIlw08MHBlHz3
	c5kT8iS8oPrmHc5W4T0r25XHKSC4gZwLvgIKkZ1+2FGIvNfzICuKJaL9MvfNpA9a
	VDo/pQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5d12qr3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 18:54:59 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso383361a12.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788461699; x=1789066499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IRq6FO1Wgh0OU+E4Zz5vIqKFC7LhLdGz4RbBzOB8Y1s=;
        b=OU8kW518IPdc6OpupOdTbUC3zC9Sasj0jB7C7VQ5aQ70SP1aTD+S9H2y+RBKhWbu6Z
         G82jK0XWniznFggjdQYL+u8R7xDWNSu5D4chNVYBSPYGcop7O00Q0m/wTuiPTLquqYH3
         V9eOOxNMTEx1KbrtgPXj9W8N10dtRjmUYo+HiLfBnpidD27Kz8KEMkLcg7kboQ8V05Ft
         n9woi3TwsLeN3l3nGjs9cT9cvOcVQtm+1nrpa+8lOqnvxL8Y8/HJikBLyuUSwhiBS8pb
         V8DVFo4xUsUidw+6FkzNIVNj5Tx2Zvjf7sRuu54KpwrGY4iZM9d+J3I2V1ke2qXUCgCc
         E6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788461699; x=1789066499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRq6FO1Wgh0OU+E4Zz5vIqKFC7LhLdGz4RbBzOB8Y1s=;
        b=SFDL6QtsOv5V8Oo5FfEeHDnKQn6Qdkk3/1vHNPHxmzYiGGsEVLMh3ikDT/wS5CUDwh
         khU37+fz10RfCzLtzsl3BujCe3OaR1dXx8DwKowP+mWDlwUrXSaDm6bPUZ+oIc2hwBYw
         QRQ742Jfo6O+O5JXC6UzbnGK7i6++QKnFaALAs5NuNBcIPrTmLeffnK/jtTYsznGNGOX
         Brpxi0WC+cpizGMlhou2xGQgg+EkQ0cSDFT/JiNAYBj4u8548ZAQW1zgf70pi++G7LKG
         TDvLuXKnO7w+vduxgZtoDehzNTitdXjyUBc2TLxdsGl6Da0xeu+WPlQEoYcy6o2CfABJ
         nKzg==
X-Gm-Message-State: AFuF++mJEbpQCe3ISuJN6TwxxQbeHbVsc8VAuhhRTUyhIwS/HpNrgbxS
	LKc+cn66T+0T96fnOOPHqplqr1FiDF3S/ivU304vNBOnwUWW/xYEhhOrGavSMmzwClEoz6tHd4F
	FWVTALbmw9n2Pq5PPVFzlYpOi38TWARSwwE3PZ4t62fToy10c0nEMy+CoF8I=
X-Gm-Gg: AYBFou0gfEfwpFlGKPepLlMVsgI7bbQZEnqgM63M1A2Wg0f2KMZoC8WhEXwg5FZIfc1
	5vZi5uT0QKAGZqwSmkvAPENV/Nuq8JUNMGDXhtSnrK227+Blj5MiNX7Qxd0LbbN4TYBEQ8R+F0R
	KE7kZwuJ8sXUuv3TPhdW6pIk8pHlj5YrjWCcV2GPJEr603jLX14j8BSMulnDWGVAcCm5OYuDT9t
	mQ8wbDYBh5P1oLQG34rmf1Cadsy1oTA1tR7RqUkRMXjm+fo3pxtf3gvEx2BX5m5yTY/5LnwhbLQ
	BnBteovRhlPlf8Upi8FHG4LiOjQ6hqAddcfamLldvFW5f62STVpcRbKTu2eM6GXb1qgeGVFgftU
	nWp3NoCAcBMPp9PmNxHHs9+IIzFfS/g==
X-Received: by 2002:a05:6a21:6816:b0:3d3:afa7:8101 with SMTP id adf61e73a8af0-3da3a16d1cdmr786620637.28.1788461698781;
        Thu, 03 Sep 2026 11:54:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:6816:b0:3d3:afa7:8101 with SMTP id adf61e73a8af0-3da3a16d1cdmr786529637.28.1788461698279;
        Thu, 03 Sep 2026 11:54:58 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ce1csm778829eec.4.2026.09.03.11.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 11:54:57 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 00:13:50 +0530
Subject: [PATCH net-next 8/9] net: stmmac: qcom-ethqos: add per-platform
 NOC clock voting
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-shikra_ethernet-v1-8-a50765996035@oss.qualcomm.com>
References: <20260904-shikra_ethernet-v1-0-a50765996035@oss.qualcomm.com>
In-Reply-To: <20260904-shikra_ethernet-v1-0-a50765996035@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788461628; l=6340;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=3qNv1gt53nDwmaZH3husajnhbdisLPvYiqw3RUvnSA4=;
 b=tT0xjbelciTRGJKzrX4LgzDWW4xxzHa+Wp/2FPlqaG/hynm5ROaZNmS3jqmRfWpOIwkDXy2pv
 MG6s7z/MzO8B5WV/Lk3pM6k04iN/CQFs5mEAZIg7O5uTQqeVprKDkrJ
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX6ytjlYEefILs
 vvm9Fk/Ru/VnCslO7hWe/l5CuIDe+klfXCJIMzdt4OFO87HylUdppfx9OpHnDXNtu1ZX4Uyl55a
 ovIlRGz4cA2FY6VwdhRhnR4jcFasRq985D79yc0THtpMf4kh6e/5OwIZD2OwMx/ZRdrRCZwTYPz
 CMBPaq+VHb4c4km6HfzmSr+fGAlcleTMFGVwwwIZx+1CW5rY12seYQVHPab05wA0bm8L7ihoc4Z
 x7cKTGkbT1vXXvnzs+VUbP4Xo+k1DWwWO9hzepJ0UM0uPE76UD1rBUwm+Un34jYlbhKuEjpc1Zw
 3eNOpeLABH0khhsZt1u2t43RmJD8vHWlN00kTiqk6QqyZlt9wkH4sK1/ix3+aVzlytr8v2mV4nU
 4XBGyPZNQDqU0R0ye4xyuBLmRwaUoD4HQwckV6KTrbELc0knoc6VO9c+/Gjs8B0nYktVrfm3ekM
 U0/M3ah06Vllt9JH4iw==
X-Proofpoint-ORIG-GUID: HYlQeojZoN-rrRa-wyOjmo66GMTvlVn9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX1jYXnCr0+7fA
 DE5pbiThkmgFJPgd7415HSHdvs+2fU8ZPiUFlvqa0BB9IFqyxmcDV7fKpfT46cCRcvYcrIx5+xA
 zOl7MlcUPqjy4uxwm3sY42Ck+6L0PSs=
X-Proofpoint-GUID: HYlQeojZoN-rrRa-wyOjmo66GMTvlVn9
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=6a99c283 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=LOscwf8DjUB2Y-oEo0sA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030165

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
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 101 +++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 4f9bef662c5796ce3cca64b19a595bcdbebbf336..a31541506a4c930c76374d7d8b7eceb6f51f37a7 100644
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
@@ -691,15 +705,51 @@ static int ethqos_mac_finish_serdes(struct net_device *ndev, void *priv,
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
+				dev_pm_opp_set_rate(&ethqos->pdev->dev, 0);
+				clk_disable_unprepare(ethqos->link_clk);
+				return ret;
+			}
+		}
+
 		/* Enable functional clock to prevent DMA reset to timeout due
 		 * to lacking PHY clock after the hardware block has been power
 		 * cycled. The actual configuration will be adjusted once
@@ -708,7 +758,12 @@ static int ethqos_clks_config(void *priv, bool enabled)
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
@@ -736,6 +791,46 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
 	netdev_dbg(priv->dev, "PTP rate %lu\n", plat_dat->clk_ptp_rate);
 }
 
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
+	return 0;
+}
+
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -795,6 +890,12 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
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


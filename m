Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E1940A93E;
	Wed, 23 Sep 2026 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153392; cv=none; b=No6Vp2aeLmIkt+DkwmWZdNygp9bbyu9IMh+4/PHoTBPzFVQW5CpJ+/Mzfijl9NR8pQwN4VO4UsmnMe3CxyHF69ps0EBo6+t0ey0vedV794LHkltK/uZ2my3ELeTXRkNf1wwyHoidGoNNyKFkCect1tIuS11Xk/Y8zJTqL3L6XG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153392; c=relaxed/simple;
	bh=NWujPebOfm9VlDuYCV5jz6AGj70/+v/+iOal+oE87Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxvfv1ta61vOwL3LQcplmXQYfA2cJcYS2Jzp+794ZsGK1hjipbyYPE686AgHgGSqcDCo5xL72MRAEbQpaSlQBqki5DuwkO1y4QjXKFT99sgpqI0Pn0LBFWzA92Ymaq9dEW2f6W7XlTI6HuiP9MXpwtKEpXTjEex6AhAOVjABzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CQf366bi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CQf366bi"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8Jag11387435;
	Wed, 23 Sep 2026 08:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jD9mAlSr3VR
	LPuSsE82mFzwrZID/Qz8z5Rc5Jaz3hUE=; b=CQf366bilkqjNwhZxvAPH0ozalM
	1RuqGMZ5aq51+rxV+/37MTtZ8VZV/h1CQ6wl/FOjcLH70xV3KJB1abOqFHoMfifi
	c3D0CfF4tVAOEwYfn6x7mSYlmaeNx/zsRjussZEDhfPTC4E8zTrgag/RFn2sXrTI
	L8NweHRq6/2kwkIANq/Yuz3lBgaaBiHZzCahFsx+wBWmvt4PKqpX64Wk7DDDJcVf
	qR5Zt1DA0BqJnLbY+MOo+QBDs11Jh+DcRlUiDUWsanC/5sXdq68z/kx3jfm51RiZ
	tgigCbF0gfKgzcoyyci/62ftoZyC8bOodhhx5xuiejS7HkZKCqGISlBXBaQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guyma2y6j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 08:49:29 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8nRXx677494;
	Wed, 23 Sep 2026 08:49:27 GMT
Received: from ap-kernel-sh03-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 68N8nRvR677478
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 08:49:27 +0000 (GMT)
Received: from ap-kernel-sh03-lnx.qualcomm.com (localhost [127.0.0.1])
	by ap-kernel-sh03-lnx.qualcomm.com (Postfix) with ESMTP id 1C58B40C94;
	Wed, 23 Sep 2026 16:49:26 +0800 (CST)
From: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
To: shengchao.guo@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        mohd.anwar@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Subject: [PATCH 2/3] net: stmmac: qcom-ethqos: configure USXGMII rates
Date: Wed, 23 Sep 2026 16:49:20 +0800
Message-ID: <20260923084921.3942100-3-zhangfei.gao@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923084921.3942100-1-zhangfei.gao@oss.qualcomm.com>
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <20260923084921.3942100-1-zhangfei.gao@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: nDrjff_ieJq5-ZnhL9nlZNZrAaEBY2dL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX3tRQWAWh82DR
 1wbs7VvoxzROOFDkUfirmmjj8b8jBzzeL5vbFGJi1j2cHALF4pcwARnvoMTtt4XVkGoEJ+M6VXq
 +at+G/nhG9sDHZqDo4F+hphCCgefkXA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfXxKNbu0bhoPdy
 Azlk4RFO+TmAlykelu9cCz34c8uDZ4l1Dpv6xDa1QnF4NG0HtcFApBbNTw9ldvzjw1Iyw3tQJhs
 k2wnXeo+HZP6ppNRhB9xLsdOrA/6zUZHmNIJeB9FwPbVlL3lDEYWmDxEDHi0w6JECww/O8qD6yl
 D2TGbqr9mUK0u60aTR7fLfekv4qZAD4t1uTqndb0gL202B9kF2qqCTxuaZABiIlP4WI5CtRDauS
 GVUYVLpADDXsfVGMCBnkB8rX2cZVY/IX7fZhE6s8QOKmMGbQFjBeseUzGga3CwlKgzftV/zhiRl
 khn8bQ8+OXK6usYRBcEVC1sNmxsRzCBgEHAUdP7FWKBT9hHxm4BQsDbcLY2w2v3jHd80dAHkg4+
 5npYKrTYqm+KQldHXB+d3OrA5ooiMDOMn8cCFsazvB9fBl5VjXECGeXXa/bU/e9tspCqpXs5YCF
 +q27CQyKaKM5n0RdO7A==
X-Authority-Analysis: v=2.4 cv=N828hG9B c=1 sm=1 tr=0 ts=6ab39299 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=FE7BbxJiXtYwFh3iQH0A:9
X-Proofpoint-GUID: nDrjff_ieJq5-ZnhL9nlZNZrAaEBY2dL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230035

Program the Qualcomm EMAC wrapper for the negotiated USXGMII media
rate. The serial SerDes lane remains at the USXGMII rate, while the
wrapper clock and IO macro settings follow the
10/100/1000/2500/5000/10000M MAC rate.

Without the low-speed settings, a 100M link is reported by the PHY but
the wrapper rejects it as an unsupported USXGMII speed.

USXGMII also defaults to phylink in-band mode because the QCOM host
requires the PHY-generated in-band link status.

Signed-off-by: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 65 ++++++++++++++++++-
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 280f9289753da..54a6c98e42057 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -38,6 +38,7 @@
 #define RGMII_CONFIG_GPIO_CFG_TX_INT		GENMASK(19, 17)
 #define RGMII_CONFIG_MAX_SPD_PRG_9		GENMASK(16, 8)
 #define RGMII_CONFIG_MAX_SPD_PRG_2		GENMASK(7, 6)
+#define RGMII_CONFIG_MAX_SPD_PRG_2_V4		GENMASK(9, 6)
 #define RGMII_CONFIG_INTF_SEL			GENMASK(5, 4)
 #define RGMII_CONFIG_BYPASS_TX_ID_EN		BIT(3)
 #define RGMII_CONFIG_LOOPBACK_EN		BIT(2)
@@ -84,6 +85,12 @@
 #define RGMII_CONFIG2_DATA_DIVIDE_CLK_SEL	BIT(6)
 #define RGMII_CONFIG2_TX_CLK_PHASE_SHIFT_EN	BIT(5)
 #define RGMII_CONFIG2_MODE_EN_VIA_GMII		BIT(21)
+#define RGMII_CONFIG2_MAX_SPD_PRG_3		GENMASK(20, 17)
+
+/* RGMII_IO_MACRO_SCRATCH_2 fields */
+#define RGMII_SCRATCH2_MAX_SPD_PRG_4		GENMASK(5, 2)
+#define RGMII_SCRATCH2_MAX_SPD_PRG_5		GENMASK(9, 6)
+#define RGMII_SCRATCH2_MAX_SPD_PRG_6		GENMASK(13, 10)
 
 /* EMAC_WRAPPER_SGMII_PHY_CNTRL0 fields */
 #define SGMII_PHY_CNTRL0_2P5G_1G_CLK_SEL	GENMASK(6, 5)
@@ -135,6 +142,7 @@ struct qcom_ethqos {
 	struct clk *eee_clk;
 	struct phy *serdes_phy;
 	phy_interface_t phy_mode;
+	int speed;
 
 	const struct ethqos_emac_por *rgmii_por;
 	unsigned int num_rgmii_por;
@@ -557,9 +565,56 @@ static void ethqos_configure_usxgmii(struct qcom_ethqos *ethqos)
 	rgmii_updatel(ethqos, USXGMII_CLK_BLK_CLK_EN, 0,
 		      EMAC_WRAPPER_USXGMII_MUX_SEL);
 
-	rgmii_updatel(ethqos, USXGMII_CLK_BLK_GMII_CLK_BLK_SEL,
-		      USXGMII_CLK_BLK_GMII_CLK_BLK_SEL,
-		      EMAC_WRAPPER_USXGMII_MUX_SEL);
+	switch (ethqos->speed) {
+	case SPEED_10000:
+		rgmii_updatel(ethqos, USXGMII_CLK_BLK_GMII_CLK_BLK_SEL,
+			      USXGMII_CLK_BLK_GMII_CLK_BLK_SEL,
+			      EMAC_WRAPPER_USXGMII_MUX_SEL);
+		break;
+	case SPEED_5000:
+		rgmii_updatel(ethqos, SGMII_PHY_CNTRL0_2P5G_1G_CLK_SEL, 0,
+			      EMAC_WRAPPER_SGMII_PHY_CNTRL0);
+		rgmii_updatel(ethqos, RGMII_CONFIG_MAX_SPD_PRG_2_V4,
+			      BIT(6) | BIT(7), RGMII_IO_MACRO_CONFIG);
+		rgmii_updatel(ethqos, RGMII_CONFIG2_MAX_SPD_PRG_3,
+			      BIT(17) | BIT(18), RGMII_IO_MACRO_CONFIG2);
+		break;
+	case SPEED_2500:
+		rgmii_updatel(ethqos, SGMII_PHY_CNTRL0_2P5G_1G_CLK_SEL, 0,
+			      EMAC_WRAPPER_SGMII_PHY_CNTRL0);
+		rgmii_updatel(ethqos, RGMII_CONFIG_SGMII_CLK_DVDR,
+			      BIT(10) | BIT(11), RGMII_IO_MACRO_CONFIG);
+		rgmii_updatel(ethqos, RGMII_SCRATCH2_MAX_SPD_PRG_4,
+			      BIT(2) | BIT(3), RGMII_IO_MACRO_SCRATCH_2);
+		rgmii_updatel(ethqos, RGMII_SCRATCH2_MAX_SPD_PRG_5, 0,
+			      RGMII_IO_MACRO_SCRATCH_2);
+		break;
+	case SPEED_1000:
+	case SPEED_100:
+		rgmii_updatel(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
+			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
+			      RGMII_IO_MACRO_CONFIG2);
+		if (ethqos->speed == SPEED_100) {
+			rgmii_updatel(ethqos, RGMII_CONFIG_MAX_SPD_PRG_2_V4,
+				      BIT(9), RGMII_IO_MACRO_CONFIG);
+			rgmii_updatel(ethqos, RGMII_CONFIG2_MAX_SPD_PRG_3,
+				      BIT(20), RGMII_IO_MACRO_CONFIG2);
+			rgmii_updatel(ethqos, RGMII_SCRATCH2_MAX_SPD_PRG_6,
+				      BIT(10), RGMII_IO_MACRO_SCRATCH_2);
+		}
+		break;
+	case SPEED_10:
+		rgmii_updatel(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
+			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
+			      RGMII_IO_MACRO_CONFIG2);
+		break;
+	default:
+		dev_err(&ethqos->pdev->dev,
+			"unsupported USXGMII speed %d\n", ethqos->speed);
+		return;
+	}
+
+	return;
 }
 
 static void
@@ -568,6 +623,7 @@ ethqos_fix_mac_speed_usxgmii(void *bsp_priv, phy_interface_t interface,
 {
 	struct qcom_ethqos *ethqos = bsp_priv;
 
+	ethqos->speed = speed;
 	ethqos_configure_usxgmii(ethqos);
 }
 
@@ -836,6 +892,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		plat_dat->mac_finish = ethqos_mac_finish_serdes;
 		break;
 	case PHY_INTERFACE_MODE_USXGMII:
+		plat_dat->default_an_inband = true;
+		fallthrough;
+	case PHY_INTERFACE_MODE_10GBASER:
 		plat_dat->fix_mac_speed = ethqos_fix_mac_speed_usxgmii;
 		plat_dat->mac_finish = ethqos_mac_finish_serdes;
 		break;
-- 
2.43.0


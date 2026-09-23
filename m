Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263EE3DDB1C;
	Wed, 23 Sep 2026 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153393; cv=none; b=sIXE+hDF21MMa+dILx2cIa2gA1O9W4Tap/sB430PJUwrNZ/XuhhWNiBZLvXN/fk/DN5v+CIgbd6dfgFtCzqUcGykO/gem4t60k+Fm1NYz/xwLc6RJen+EimZKd5Il4nDxphhKga8pmjGIxt+VxZTPvU4LtLhEMoZNn5cwg5nX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153393; c=relaxed/simple;
	bh=NtNxLmA6K4ifpOdVd29KbZr+0WIEXnqCTEZoUKcKGs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmnpTy2eKaqRlLpos/u0Q7CilVszi7vU/1zvl892QQqwoq3Es93yLj2Ny7GHo5P+A5ga2MYcQqRZ2NOP7TGFJtXdvxRu20V0FxJgzN+BZltep1tWJl/KlX65G3QOUym5Kx5+SCPB/bo2+qhqhgBotXeYp+8tubZUjTn1n9s0NkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n5Sg8y4c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n5Sg8y4c"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8JxQk3178826;
	Wed, 23 Sep 2026 08:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Y3PPdjveOB8
	sMUd/KileNd2kAhFBCiW/gKjzWwwsET0=; b=n5Sg8y4cuXZLDAVEVryCzZccbMN
	16bVJnE85v/chWZ+/GwIqwzYbm7VsfXjUKumvhqcxDrnk5QK1Ga5GAZrGS3l8626
	irVUIGrFLtYQmhLIZqMpIEp4ZQhsIr3Gmi4WBDON2SXdZO3zmFpI9cW2lKNXDih6
	OV4ReAETjp4d6ErsY9xTxiikiR6UrT38LlrO4iLGecLLSXqNFYsQDt2Y91PoRdAH
	pysjbTytU4b0PWkKJfwMUjBNvIcV2nROxgBqrjSHfqPGK0uBJglKUukYkNf1y2tP
	oN6E94kuyRoVG8chlEZve7dOqW9Z2nt/VLHnLYbM+Y+lGRE8VzC7Xwgj8Ww==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux863f8h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 08:49:29 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8nRTX687571;
	Wed, 23 Sep 2026 08:49:27 GMT
Received: from ap-kernel-sh03-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 68N8nRYM687556
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 08:49:27 +0000 (GMT)
Received: from ap-kernel-sh03-lnx.qualcomm.com (localhost [127.0.0.1])
	by ap-kernel-sh03-lnx.qualcomm.com (Postfix) with ESMTP id 108DF40C15;
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
Subject: [PATCH 1/3] net: stmmac: support low-speed USXGMII validation
Date: Wed, 23 Sep 2026 16:49:19 +0800
Message-ID: <20260923084921.3942100-2-zhangfei.gao@oss.qualcomm.com>
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
X-Proofpoint-GUID: G_eKTwn7ZLLxVxz27SSyVeVvwobJQ4zB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfXzwIzRbm68iyu
 Q7EvoC47hLgFrxgNteVXq0MM8gbz/zoyRtdrn5CUlxWssFYHvX+bAnyHSeOw9zAV+dS+MX3ZeuR
 cDwvBw3UWazLdECJY904vFFp+1kI598=
X-Proofpoint-ORIG-GUID: G_eKTwn7ZLLxVxz27SSyVeVvwobJQ4zB
X-Authority-Analysis: v=2.4 cv=eIOGH3p1 c=1 sm=1 tr=0 ts=6ab39299 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=qk3Z9dr5LKe28F2BLMUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX7Ras9iBMjxkT
 /G1rJPXbECp6PDjErbbBG2/sK7JVZrLxVr2KI+IbBL6ZUwr81cnN/bxjKTp88s7zsbAmK/ojOMO
 0sBB9G8gF+DCInty/uL2xrL1mhdQFT98SxWVFdVyVetyhnoN8jLCX5+d+mUjLBiYrQ9uiaj3gg3
 0ntxPCGNdNAFsERvUhBjdrcXey6iFqpeTVsXCStiO7cSW63o5Ui5X/D+0WYWmRlLmYBxlNArGOm
 +1IpAs7DTwitWnFkEprKVHE+ShU+LUbdCkxZSOiGmSU55MwFgjCJdy7SqWblEwCzdhJleo17Ibw
 c4WrRd/QIZanSzmyTtraCKgf/JtqEkHKFoyJuk5mjhe2zhOyKovlAnzHSmKqpcVKvl8nkGJvxMI
 V7Oa6oMb6loUDo9eEksl0sxHCQko/I3KOTLqU757PpcihVFrpMFVnQXb3mfY9G8nLUjhzpaS5En
 rfAiqKpn5SuxaoMRx6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230035

USXGMII transports the negotiated copper media rate over a fixed-rate
serial link. The PCS and MAC must retain the corresponding
10/100/1000/2500/5000/10000M full-duplex capabilities.

Advertise the media-rate link modes from the XPCS and allow the stmmac
MAC to validate 10M and 100M USXGMII links. This keeps phylink from
rejecting an AQR113C PHY whose advertisement contains base-T modes.

The XPCS also consumes the PHY-generated Clause 37 in-band link and
speed status, so USXGMII must use in-band signalling.

Signed-off-by: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 drivers/net/pcs/pcs-xpcs.c                        | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2dc0cb2916daf..5954048a9f7fc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1045,6 +1045,8 @@ static unsigned long stmmac_mac_get_caps(struct phylink_config *config,
 		priv->hw->link.caps &= ~(MAC_1000HD | MAC_100HD | MAC_10HD);
 
 	config->mac_capabilities = priv->hw->link.caps;
+	if (interface == PHY_INTERFACE_MODE_USXGMII)
+		config->mac_capabilities |= MAC_10FD | MAC_100FD;
 
 	if (priv->plat->max_speed)
 		phylink_limit_mac_speed(config, priv->plat->max_speed);
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 091c9b57388fa..58ca296fc4420 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -23,6 +23,12 @@ static const int xpcs_usxgmii_features[] = {
 	ETHTOOL_LINK_MODE_Pause_BIT,
 	ETHTOOL_LINK_MODE_Asym_Pause_BIT,
 	ETHTOOL_LINK_MODE_Autoneg_BIT,
+	ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
 	ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
 	ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
 	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
@@ -737,7 +743,8 @@ static unsigned int xpcs_inband_caps(struct phylink_pcs *pcs,
 	case DW_10GBASER:
 	case DW_2500BASEX:
 	case DW_AN_C37_USXGMII:
-		return LINK_INBAND_DISABLE;
+		/* The PCS consumes the PHY's CL37 in-band link and speed status. */
+		return LINK_INBAND_ENABLE;
 
 	default:
 		return 0;
-- 
2.43.0


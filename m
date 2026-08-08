Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC12382F01
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786212043; cv=none; b=rfFjGcuqLb55eU9BrGpwB1aQvHdxlZErhgaAMDTaf4no7E/asL37zpSw7Q3EFdYAz7MMmrqmn+VGKmzag4WlIpQMFfHFfbk+ntAyjBwdZ/utPp4kT0a7eZJqQwIK6wWg9pFLVHW3xsBVK1UlHAoaeqLaghlBTxm8AQw/UchynsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786212043; c=relaxed/simple;
	bh=YJAjSKLv9W9Jb5w4ieif+6gn/uRjxtvwUlHbZe+U9zI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BkE8L/QfRHI6Wt+2E6it/yA6/+zj2OcBKUa/9oSzkN51xoZZ4oR4NMAOEhdsYRjf3oxJNpPYUlzogg+iJyci+pQw2YFuO6Wlhs171lOCt2+g4KIsADNDR76KjoiZFnWecDuC41KKECSBjID+RYkmvCEuxiPcCt0I1olWGhNxrM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XzNmG57S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VJT5O8os; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XzNmG57S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VJT5O8os"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678GlTBH294933
	for <netdev@vger.kernel.org>; Sat, 8 Aug 2026 18:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IVuWzrtf/RLqHaO1jhaG0E
	05SMtt0qVsGUroudHlfw0=; b=XzNmG57S8qVu5/ei/MH9cPykLIB8uXlwVXyejm
	WlG51iKnsWDui5Z7Y1to4w5+hwxy4KVLzghEAOoAC047H2LwQeEE/LmSJ4KXpgYG
	nV3g+e6SidsV9WcunRCftwJ93K4SE5OqbUor6tkVEoCrTC9uUFpc3pK75Jec/0NK
	pYzG0PcSpVcomEHp0FRtK7HrP7qo8kXdAeqMZnslWXm56fgrJO4S2bn0lG/uXdLq
	YW//70gNUabo5uKUZ4hsjtrt50SOp3SUFVHjWgQbdpGhSewLTd93nzwjyuQEWGR/
	LgNgh1gcut1LCCV0VLVs6ctJkrpSfI9BmHRbntXIJAmkOIQw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwush1gjg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 18:00:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0408254aso33369221cf.0
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 11:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786212036; x=1786816836; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IVuWzrtf/RLqHaO1jhaG0E05SMtt0qVsGUroudHlfw0=;
        b=VJT5O8osLi/W0RkiPjDrQ5SRLzSd5TXI/r2nGZeyrBzJjfxuAHTRKAK1aNhL8qRwi+
         weihxxcXAY41yfHZgG0QZvhbIJxCVf5HtJCCCsHcs+d8ygfb8FgcOvrUkVz844u0YOQZ
         u5/GohH1R8XikTEcGDzydVjWwNuhTEt0jfVC0nWUXZwTWiSKvmXrZzt6aEQt2FmV3NYI
         MKTwRyIukOQ0h8ZVfSMhDdG/9A1D8yiZrJsyYf1zh2uk/ZnQTBLCMbZ4PbjjbPVANdlN
         2z4nwAnfEqIwMHavgjbqh+yIXV9cQHqKYU04iZ6Kne3WrcCYG9Z8B1uaceSJQlC1aOg/
         v7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786212036; x=1786816836;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IVuWzrtf/RLqHaO1jhaG0E05SMtt0qVsGUroudHlfw0=;
        b=rbefgY3g5VcTRVPP5Lq6ukLYSwLyIt2yGJto8EIIqUBEgBPpUdVMUrb/HvRY079wx6
         UfkyUoUUOVJh7lzUEYdhgKF1l50JOZVL6W/n6fVUcCZC6XbcDH+V0d3vg5eIUW7OUxna
         YEKng3B6XCzLLHC1N/YZSyDQQmRI2pxN6QC/tWnuh1OFFnBNeuH03DFAyXgVheAbe+rS
         MmhollWPPydwFn+1mVPkQG/7EzxYOm1YKwImehbw/Fcgek+BNYgh1pRpSJgyWBN3V481
         c0XEq5k9LsiMXdElLYHZ8JJPLl/pj+3eIDeBGm+7x0fkxSDem4dCJlBnIjkzj+BvMkW8
         bo+g==
X-Gm-Message-State: AOJu0YwAOH6ay/B1Mqf6zbSCkqk/e/Y5mrOzs+QZL1u4KAhRsL+YMqbY
	p/hnvdTw76hCh2jRuptUeodMMo5fFG1fyovT7qPZNwPKRYrt6f0rltTv4BszNKypBhvcHaPyTjB
	Obz+lmexz50N2y/ozQMHqBLlAHD+zz62aGKZ4bRx6pg0OCROgkEHid2IsmX0=
X-Gm-Gg: AR+sD13NEJ+YOhtzBWf7H3YcPiAvW1LvKAR4J6yfxy0WtH0W6pK2JDdzLBkwD4YFLCa
	16nMcAcqh2Oc6w2aQPD4xETDw4qCZeR4rMOOo3Na6ISVbCjw3msOVFeAeAUOz16QAaF8au7AxNQ
	4+nQhFQfl56VNDa1/bVnrOFMY5bs19QvOQg1YDCfTG0WaAcRnUu9bqcplZg1HELIPSYBERYl6b7
	M3X5T4+sdCzRjkDjLUcabnUPUxi7DANGslogPq5m2bz81gLwCQL+FPKEaQq3eYEoClvTMLrWBcA
	GEo90XvS81gvRMx86aPjkU0RwmkHgv0RNEtzJGKDs8xX1StNIo91BgWvu5HsM1QoBzFNgwGcM8w
	Vq+hbNV2r5DTA14I=
X-Received: by 2002:a05:622a:53c6:b0:517:c65c:4987 with SMTP id d75a77b69052e-52d23856240mr87301521cf.22.1786212035870;
        Sat, 08 Aug 2026 11:00:35 -0700 (PDT)
X-Received: by 2002:a05:622a:53c6:b0:517:c65c:4987 with SMTP id d75a77b69052e-52d23856240mr87300571cf.22.1786212035383;
        Sat, 08 Aug 2026 11:00:35 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9ea92csm137632185e9.4.2026.08.08.11.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 11:00:34 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sat, 08 Aug 2026 20:00:13 +0200
Subject: [PATCH net] net: stmmac: keep gso_enabled_types in sync with
 netdev features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-stmmac-fix-tso6-features-v1-1-f82b17595052@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MwQqDMBAFf0X27EIa1Kb+ivQQ4ovdg1GyaSmI/
 27wODAzBymyQGlsDsr4icqWKjzahsLHpwUsc2Wyxg7GGcda1tUHjvLnotvAEb58M5SfcQ49Xl3
 nYKnme0aV7vVECYXe53kBS/HbH28AAAA=
X-Change-ID: 20260808-stmmac-fix-tso6-features-7fdc5e9448e2
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: EyIQ8h9D-sKIw6bcBrGAk9r7n_vx7S0M
X-Authority-Analysis: v=2.4 cv=GvpyPE1C c=1 sm=1 tr=0 ts=6a776ec4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=3uZi2X7aTxeIN_KhKxEA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: EyIQ8h9D-sKIw6bcBrGAk9r7n_vx7S0M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDE1NCBTYWx0ZWRfX1qZ/5yPvJMSf
 nDPqSQ+TMgI3vmEFeYcsQXyQGIf1pgggPxzYGhvIFVeovpq66WsO2jM51LdQqzK+7NcXTcpo7Dh
 /c9kf3oyXQaE4UgwxuCEWPDAS7PCxYs8yc+zzDHTjcknhT66MgazNnpDWG7n540MmNjR6X5hZIi
 a5VEPDMVkcnSs1g8Llft0bquUsR/wPbre3Xt28v/ywQDaNi5dWd8AUENy//NtyESqjeWTk99mlc
 V5XpeLxaLe58jzrHS3aOrgepFFvdJMqyT+qzWhkp5R6R3j8bdIjdy0sGUaWCID+A/uVScode8tG
 tEYjwtSWvt09QB+ub70/Z3+8rLMZgsOAw3/fkniT6t7Me12JwMF5I3Yik+6H+S90kYtUrffBWuj
 cy1hXt5kJsfKljYYS4rK8LtfERZURVqypRm58ephOJ3+g/6PlozmcBCGcoyw6wLeBqPqCIGNHjq
 jWZSTfz3X9zmzoz238Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDE1NCBTYWx0ZWRfX7nCbURKfkZ3O
 bztWjKDXUxqzBat/AOJgZ4y88MsojxkBGMPX2FRAT61kwfB1YwYMJX2SXrX/dRGDYVygCFcJL9H
 vGwU1/0WpOccGJ4IcXPGDviC962FdEE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080154

stmmac_set_gso_types() derives priv->gso_enabled_types all-or-nothing
from NETIF_F_TSO, but stmmac_set_gso_features() advertises NETIF_F_TSO,
NETIF_F_TSO6 and (on GMAC4) NETIF_F_GSO_UDP_L4 as independently
toggleable features. Since netdev_fix_features() only ties TSO6 to the
checksum features, disabling TSO (ethtool -K ethX tx-tcp-segmentation
off) leaves TSO6 enabled in dev->features while gso_enabled_types
becomes 0.

For a TCPv6 GSO skb the stack then keeps the frame unsegmented
(NETIF_F_TSO6 is still set), stmmac_features_check() does not clear the
GSO mask, and the stmmac_xmit() gate (gso_type & gso_enabled_types) is
false, so the multi-MSS skb is transmitted through the ordinary
descriptor path as a single oversized frame.

Derive each GSO type from its own feature bit instead, so the mask stays
in sync with dev->features and TCPv6 (or UDP L4 on GMAC4) segmentation
keeps working when only TSO is disabled.

Fixes: 2e4082e4b739 ("net: stmmac: simplify GSO/TSO test in stmmac_xmit()")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 24 ++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a71f0df26378..3d3042afcdf4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4371,16 +4371,18 @@ static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue)
 	stmmac_set_queue_tx_tail_ptr(priv, tx_q, queue, tx_q->cur_tx);
 }
 
-static void stmmac_set_gso_types(struct stmmac_priv *priv, bool tso)
+static void stmmac_set_gso_types(struct stmmac_priv *priv,
+				 netdev_features_t features)
 {
-	if (!tso) {
-		priv->gso_enabled_types = 0;
-	} else {
-		/* Manage oversized TCP frames for GMAC4 device */
-		priv->gso_enabled_types = SKB_GSO_TCPV4 | SKB_GSO_TCPV6;
-		if (priv->plat->core_type == DWMAC_CORE_GMAC4)
-			priv->gso_enabled_types |= SKB_GSO_UDP_L4;
-	}
+	priv->gso_enabled_types = 0;
+
+	if (features & NETIF_F_TSO)
+		priv->gso_enabled_types |= SKB_GSO_TCPV4;
+	if (features & NETIF_F_TSO6)
+		priv->gso_enabled_types |= SKB_GSO_TCPV6;
+	/* Manage oversized UDP frames for GMAC4 devices */
+	if (features & NETIF_F_GSO_UDP_L4)
+		priv->gso_enabled_types |= SKB_GSO_UDP_L4;
 }
 
 static void stmmac_set_gso_features(struct net_device *ndev)
@@ -4416,7 +4418,7 @@ static void stmmac_set_gso_features(struct net_device *ndev)
 	if (priv->plat->core_type == DWMAC_CORE_GMAC4)
 		ndev->hw_features |= NETIF_F_GSO_UDP_L4;
 
-	stmmac_set_gso_types(priv, true);
+	stmmac_set_gso_types(priv, ndev->hw_features);
 
 	dev_info(priv->device, "TSO feature enabled\n");
 }
@@ -6198,7 +6200,7 @@ static int stmmac_set_features(struct net_device *netdev,
 			stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
 	}
 
-	stmmac_set_gso_types(priv, features & NETIF_F_TSO);
+	stmmac_set_gso_types(priv, features);
 
 	if (features & NETIF_F_HW_VLAN_CTAG_RX)
 		priv->hw->hw_vlan_en = true;

---
base-commit: dd057113ac7ba5bdd2aed3d9405305911152f911
change-id: 20260808-stmmac-fix-tso6-features-7fdc5e9448e2

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8F437C916
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862654; cv=none; b=DQ5YL2OHsN2JL0b8j+tjOsGFtIKwq6ikTcdAq1tgq5NXaqGvG78izmzm0FtxFEqY2Jy1/yYlSC18H0EwvQHpa+1TyzFNbDvR93QoBIB+mEjLN2jMwnAPXHvUUfcW68S435b0/U9CVt4C0kiNa3cnZBnpGCzI4DaCzihN9gU4o5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862654; c=relaxed/simple;
	bh=MOnA5KYPh5s4Odm0/wjkwLN1gc9MGhMYi2jHCuFW8UQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n6tx9B9Eu8U9KOVJilqewBGxNZpr2ugV4JRGyZ7pJ3T4QQsS+uiIcNfkpul+MFTBorj07+4Aplr1mK+mKMxudPtvMQDflpzMJwyZWsIwz2LpSt70Mr6O60kBYy6HUaTbMONODu/L4DqOdoxYfbbpzjxd4s04vgkmBTQg9b/+/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UK5Y3x5E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UGiYvl+a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UK5Y3x5E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UGiYvl+a"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691Djjgr1303940
	for <netdev@vger.kernel.org>; Thu, 1 Oct 2026 13:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xdl62n1wiBc9Gn4/M7T/49FaHFU4dsJOFf9sXgcFNlQ=; b=UK5Y3x5EKAULBZnR
	Is5cPX2YohIAPUFKMMxXm44D54vpKJMdaW6B11I/PJIISv0/rK43uE6pOkcmFVkB
	LebSOeFxWjBVG38PdM4A2b+Tt/m9VZhpLbH1qu2JZOxEW0DxE99YOoR3IWDjztnQ
	yleSt5L35x7u2e3B8umxqoFMgxeUj6EX/IU/zV651QZRNhp9Dp6I/P6s/SZnJ+p3
	/nYeUdzp3x/MZU4svGrxdIPBkX8kA1laulj1gv8PFQiuE6BYWQA7bB2qo6pu1t3R
	iL2NSXI3d+krF5b5LvejG0oiBGL3SAxEIWpu8WSJTaJRuBjnkUuEBOGC7r6dazhh
	NvjxIw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1bh5bgs8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:50:52 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9106fce784dso133322786d6.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 06:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790862651; x=1791467451; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xdl62n1wiBc9Gn4/M7T/49FaHFU4dsJOFf9sXgcFNlQ=;
        b=UGiYvl+a09s0UVNoHm1MpYGiohD0Bj9rBz2bKiWqv/7nQuL6caNh8MfJMl9do3nHd3
         whzlE8D5ryATys8KC6yNiFer0SO0V2lRzHt+XcwRtqLhmw4LszVleLPjZWtiuqmZalKZ
         w8KTR1yMp+KDe6AC/R7AhxJg3cdSYzlSV0h3wGGeYUHYkFEx8/VnPOc8TLaSgbQowO+M
         jbWoTzVEpCXsQPfINS64hXYwIbPHg08TaRDwP20FL1kY/pSvltlZDOM6t+NPfgDGTcRS
         ssTa45G8ncMQBCTV6RYeSdjNXGWlJJMJETZIyK/IWrNoKDlL586/e80hjigEpltTyEJn
         mrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790862651; x=1791467451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xdl62n1wiBc9Gn4/M7T/49FaHFU4dsJOFf9sXgcFNlQ=;
        b=JeIatzLwBZ31l/ZwrgG5d+mqVlTaC15l5hlflk5qI2FdcoYmCcet5b+9myGd+xjcGi
         wiaYtllOXFQJrvKlCDZsRxHo9WuxwOJmpD+RjMtZ6A7iVXWwQrQgvPVs/cPv7XqlrMpY
         /xcGSP7lucG1+Cu0UGRKqFwQ/tfH9QT8wycHLeKh/+8HLtmH5aqYpodRcLGyF2yo6b+l
         rQ1hFzBGO15TQ/o6Rcvgg0OUe37wNUGtL8T+iFb8/NwnNi1pL/KuCaj52cNvp7kWOUW6
         9HUVH/4PQyb9BEAaLe9IBd642Zib4JPZy9Vsto/6nDDZVysj4K/djDu288GMS/pl6xE4
         OXBA==
X-Forwarded-Encrypted: i=1; AKwUvBxVMxCSgoWpR9qUtsjeYG9iirL9BrFb19kw7bsFe7lPEIrDEVkFzIf+eK6TbR/b1qMT61FnOao=@vger.kernel.org
X-Gm-Message-State: AFuF++mAMn3MPc/8elcNFu/BAUP1XKV24bs/yb3qEnGV6yNTRBeZa1YY
	7vfvBesanjl9HKPB12301yZ4RVNr3FAL6W8C1a+Dlqm7njX5x4Be3aqoRASrNCrN3d1/Hkcjetp
	o+KPAlhaABzuuI5KTaInE0BHgFLdSn/7mi9aRmJejGMQHaHab9vm/4lQg0DU=
X-Gm-Gg: AYBFou0L7PhwLm59U+619B4+v3pW+lsTsv1ZkA2BjT15DNUFA+hDdMk7eyVtRKKB8iC
	8Z7ZMw6cggnP0inQonwuzeVMDQ2cGV/sJGLaYG/lr6VKNAQPJOS1hjfUyAWKAXp/27CLS9OowYB
	UqKATe31yzq90rEpYz2ONJWC+8Mj0aNncQxlMeugJUP+fHLEZsgaU3TCWK9Cer4HnmsMbtTQV/i
	eQ9ypf4AKprTd0cU+u3NoKMUvEVnkZEN9o8l02hAUb59h0wIfjrAwyvkvKLD2ZpmmrgIH2CwO39
	ylC1XUQmVWddI89yzYAsdb2X1D0Fm1TEdOsh5/BTj3EeAtJDCmpyxUo4mzyxkOLkckCRFrhQSbU
	WHFfLNXhL7ipHsw==
X-Received: by 2002:a05:620a:6cc5:b0:92e:bc28:5479 with SMTP id af79cd13be357-93ca9503ee0mr922657385a.2.1790862650897;
        Thu, 01 Oct 2026 06:50:50 -0700 (PDT)
X-Received: by 2002:a05:620a:6cc5:b0:92e:bc28:5479 with SMTP id af79cd13be357-93ca9503ee0mr922650785a.2.1790862650268;
        Thu, 01 Oct 2026 06:50:50 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31d427besm165627466b.48.2026.10.01.06.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:50:49 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 01 Oct 2026 15:50:19 +0200
Subject: [PATCH net-next v4 2/3] net: stmmac: align real_num_tx_queues to
 mqprio configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-stmmac-mqprio-prio-offload-v4-2-a74610d7f1e5@oss.qualcomm.com>
References: <20261001-stmmac-mqprio-prio-offload-v4-0-a74610d7f1e5@oss.qualcomm.com>
In-Reply-To: <20261001-stmmac-mqprio-prio-offload-v4-0-a74610d7f1e5@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>
Cc: Daniel Thompson <daniel@riscstar.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1NSBTYWx0ZWRfX5GofhTxraoLt
 XkexqN6U+IPtTRJx67dAy4WZmQhAgqZd+K6L3xg5dIPTb3TMKFZf3eb2awTrWgLBRTrnW7FDed5
 XV0OrsZmtUTzqIeALgNT6mPZ+Ay5doSp50O/Z1aiYdkRTw5geNIWKWb74WrzaoBhQICVCvnt+ca
 A92HvZkBV+IlhuSMUeOvnP4YmDKbmAfntZGsmUbPenCwlf81qCvzKic2bN5Ag/3HOo0UMmZq9BT
 euC76QcziePHWPE8nPtTtEKAE812gbUks2R2dsZSs71SLICcsuPSzpTmR6IJpP2dQoWgXce055I
 M9Z0q6xGrhkCDxYa2lHtRraO+rb6Q3t/QxTHbFo/TCoAHAo71sSXLJDJKpDswln9yTJg69RLsOC
 IyzzaQCRhBSX20G1X5pEkttGNf0bohc+1CEukmG+ZpbInmoCrvSf3O4Ac98gwyd/vx7Z1zxZT4S
 QdjPYD9MnwzX/h98OHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1NSBTYWx0ZWRfX1H5ztj5eRdua
 916QQ6hjUM8kjJeQlUBuz+bq64ALXdteYuDk9s0I3otMzf7LFHog0ljYkeAixLqv2PkAntHPG42
 C7eyBEZ7wEfxvE6dW7LkBKuXCkpy1HU=
X-Proofpoint-ORIG-GUID: T-9E5R0nCd8Ls00auO8Ixwy0R3XkNU7s
X-Proofpoint-GUID: T-9E5R0nCd8Ls00auO8Ixwy0R3XkNU7s
X-Authority-Analysis: v=2.4 cv=NrJE4MdJ c=1 sm=1 tr=0 ts=6abe653c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=dbvV_YUU-CEaD36rsUoA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010055

stmmac_hw_setup() unconditionally sets the number of real TX queues to
plat->tx_queues_to_use on every device open. When a tc-mqprio qdisc is
offloaded the driver reduces netif_set_real_num_tx_queues() to the number
of queues enabled by the offload, but the next device open reverts it to
plat->tx_queues_to_use while the netdev TC map is still the one programmed
by the qdisc, leaving the two inconsistent.

Track the number of TX queues enabled by the current qdisc configuration
in the per-qdisc state (priv->xmit_qdisc.num_tx_queues) and use it in
stmmac_hw_setup(). The field defaults to plat->tx_queues_to_use at probe
time and when the mqprio qdisc is destroyed, meaning no offload is active
and the number of real TX queues must match the number of queues the
driver allocated, and it is updated to the offloaded queue count on a
successful mqprio setup.

Refuse to lower the number of TX queues below the count required by the
active mqprio offload in stmmac_reinit_queues(), otherwise
netif_set_real_num_tx_queues() would leave real_num_tx_queues
inconsistent with the netdev TC map.

The issue has been reported by sashiko and the patch has been tested on
a Qualcomm RB3-Gen2 board.

Fixes: 195e4f409a40 ("net: stmmac: support fp parameter of tc-mqprio")
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  6 ++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 +++++++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   |  6 ++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 4fc96b317d79..0052f2129297 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -299,6 +299,12 @@ struct stmmac_priv {
 	/* Protect est parameters */
 	struct mutex est_lock;
 	struct stmmac_est *est;
+
+	struct {
+		bool enabled;
+		u32 num_tx_queues;
+	} xmit_qdisc;
+
 	struct dma_features dma_cap;
 	struct stmmac_counters mmc;
 	int hw_cap_support;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d95482b7f6e5..1dc9218bd4e9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3778,7 +3778,7 @@ static int stmmac_hw_setup(struct net_device *dev)
 
 	/* Configure real RX and TX queues */
 	netif_set_real_num_rx_queues(dev, priv->plat->rx_queues_to_use);
-	netif_set_real_num_tx_queues(dev, priv->plat->tx_queues_to_use);
+	netif_set_real_num_tx_queues(dev, priv->xmit_qdisc.num_tx_queues);
 
 	/* Start the ball rolling... */
 	stmmac_start_all_dma(priv);
@@ -7692,6 +7692,10 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
 	struct stmmac_priv *priv = netdev_priv(dev);
 	int ret = 0, i;
 
+	if (priv->xmit_qdisc.enabled &&
+	    tx_cnt < priv->xmit_qdisc.num_tx_queues)
+		return -EINVAL;
+
 	if (netif_running(dev))
 		stmmac_release(dev);
 
@@ -7699,6 +7703,9 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
 
 	priv->plat->rx_queues_to_use = rx_cnt;
 	priv->plat->tx_queues_to_use = tx_cnt;
+	if (!priv->xmit_qdisc.enabled)
+		priv->xmit_qdisc.num_tx_queues = tx_cnt;
+
 	if (!netif_is_rxfh_configured(dev))
 		for (i = 0; i < ARRAY_SIZE(priv->rss.table); i++)
 			priv->rss.table[i] = ethtool_rxfh_indir_default(i,
@@ -8010,6 +8017,9 @@ static int __stmmac_dvr_probe(struct device *device,
 	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			     NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
+	/* Default qdisc num_tx_queues */
+	priv->xmit_qdisc.num_tx_queues = priv->plat->tx_queues_to_use;
+
 	ret = stmmac_tc_init(priv, priv);
 	if (!ret) {
 		ndev->hw_features |= NETIF_F_HW_TC;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 1aa80d51ab33..d0c3feb45789 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1266,6 +1266,9 @@ static int stmmac_reset_tc_mqprio(struct net_device *ndev,
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
 
+	priv->xmit_qdisc.num_tx_queues = priv->plat->tx_queues_to_use;
+	priv->xmit_qdisc.enabled = false;
+
 	netdev_reset_tc(ndev);
 	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
 
@@ -1321,6 +1324,9 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 	if (err)
 		goto error_reset_num_tx_queues;
 
+	priv->xmit_qdisc.num_tx_queues = num_tx_queues;
+	priv->xmit_qdisc.enabled = true;
+
 	return 0;
 
 error_reset_num_tx_queues:

-- 
2.55.0


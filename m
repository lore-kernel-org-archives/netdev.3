Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5933DAACF
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092138; cv=none; b=McX1CUumFGhJE4ikL+9QOmPipTXIIKKc7/4ceL8AoiUoQlC5qHQ+5JW2mg2DOKHWnrZJKVruwZRrXfmkQJvc7TdnC1tIHsJZRAIrIBU3ja/a12k8PquIsVhrhzm2QL4ez7EvHpTwjEbb2Aqw1fXi/7HMCjFA2EpeWkl7ydvme4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092138; c=relaxed/simple;
	bh=s2Xz8Tanm8yoKbev0rXLvBHTXWc3fg2dIVnKRlFBTQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Novc4QgIZj+D6xe1WqqI6XjLxlz9LhjvlKn8I8+eAS0+rOze0LwEixvmEhUOpUCkNvE8tmRiUGxglgmqcgFwlCdcwvvatCB72S8UlJU1bjJxlb3/ZpbP1NGV6MQqQZKyLFCnJh4d5eiBsIbDWbl6YTrVorNKYYSrN+MREdKRQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UR6bVsCL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DJGihPSn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UR6bVsCL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DJGihPSn"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777iebj493924
	for <netdev@vger.kernel.org>; Fri, 7 Aug 2026 08:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZygfEXp+XuyY5bPWF5ht419bC1Ri82wC3UKzpd1m4is=; b=UR6bVsCL627Xw7R9
	/5KbCRhbM665eGxF+yrmI/BmwyDiUmR5PO9FoHiTTkQ9nMq9lLi5Vue4RTNoW+FH
	723vM8U5z7jnBwSiaq7i0VnQ1fZKGKzNHJo7NWQyr6qQbVUEKsW33F/d1pfjSNXF
	VYOxQ3h+twoOjk8JOR/eselrHo7J3jMUdUJasKJh9LKkCXlA2yi3H02xwUfwnl0X
	43FOb2lXBQW5pj+DDRVb3W4cYnaRI+bAG0K3oEaKAWUZSsiRJiwyACXd51/ttcuB
	IuNOqRWhJpM2Rg8zFqKCZhj8ppLOj045mlbGxZJoL9xrA+ZoiV3LKCTKoG/L7gYd
	aia1Aw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6rb0p8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 08:42:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1eb52e1fso52055221cf.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 01:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786092133; x=1786696933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZygfEXp+XuyY5bPWF5ht419bC1Ri82wC3UKzpd1m4is=;
        b=DJGihPSn64imFrDsCoQjNRCV40/xVnEgSQbQg+Zc3S/j8GJjwNRTl/NfB02RNr7lGU
         x083KRnA/xdpPiE5/x2fHDuaCzIBFG59SH2gQVHmfTcKeSF6EYkYyEF9aO8Nxx0CDXK/
         JBjtPLJOAcM1o0mm7tvW5NnSLh68JYQ/sfYBY9ufwRxHEwLosApeLgMpTMG92P5pSNMD
         iytjr1ikYAJFqnWsH995Klb5Jn3WtV6aC92/iu7E1XokB97cSnQvmtADc4B+q7NUlirZ
         CLFeyBMUDGBjio8WC7kXKt/OC0ITxARJEiZu8szNbqpUrya8rMVk2uUKYriiL5EqqYqZ
         /BxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786092133; x=1786696933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZygfEXp+XuyY5bPWF5ht419bC1Ri82wC3UKzpd1m4is=;
        b=ZKjw6t2cdD6Lsmt+0HekzS1e7gDk5GKfj2K52INNjagwy7c/ZCf1Paj7s314/xLEJo
         KUgG3V+BLvlrtkAxNd7BDH6L5SlCsbGI38lKJDdfuvkyZAgSw3FyQChZUSSSxbH6uSb+
         qmeWZ26zUDWY0ZZf1crOrJi9LmuAkwXuGE+K3u/OOngE9SS9HaNl7i5Mfo9ehCTnGKAl
         bj+nAJetJ6rCkz8/vRPgqa27le+5TPur9SGRkCkeS1P+CTIbG/prP1j0dWTdL/WV8nCz
         eOTeK9AgDo1x6EY5eyxQJVkHHcvKgFJTpXRiY0EMN9fQTEqav5CSaTuYvlQPMsMj1IJP
         yr8A==
X-Forwarded-Encrypted: i=1; AHgh+RpE/S7iwtBh9DVYC/RPLfLRH53NBkqQs1P5XT5Iue6iBx2b7qMj9Tl3kBAJpkRaXswUUFtbtLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi24BwX2hCAFpvQUQ5PcPzPOB6xfL8T+y+IhZAIYewGQ5H1ZRH
	kf5h4n8SiWJjCPsPCdz3h6EppVeeedxvubsToDtkjTNYr77iMj8mAmn+T+dC9Y+jfgFmwNT4Fvt
	52EmuKOvXWDwzcxWSsPOQuwgl4upwatIPOcy7mWf3C4Ohv8B9lf2rh2TRztw=
X-Gm-Gg: AR+sD11nrEkIULwG2TI9M4Xd1rJWI+iR4HHCtn1qBFYBQffrARpWas2L+OO01Mqsj3+
	G+PSsrkM7KARLpRijJxLaeKHpC4lXIptZCPEpQdLliDgZT3gyaUOSWmFZImhdAVYtXZBMmGnYy4
	IOe1g2ZYcHm7iixxJDQ544PKA9zUZykpv88DudLVJpmzNn+8OARwnz7VvHfqeYuyfqMZQYg1SYK
	iZe/L796set6rOvznMcafn3hKZFuJ1IryrpD25F1g1Q4rwzBSd+uG9woahuCxQ3Ak13yiznrToj
	QlkQdJ6E1YuJDh4mxhI5swpDE+T9irgAlkHMLpVJU5RfUBtHDV9fspWkWlRkgCAiH8fU3dYjNv2
	xKiH1/iyT1XoZccM=
X-Received: by 2002:a05:622a:141:b0:51a:8dc5:bf89 with SMTP id d75a77b69052e-52ce5f7e59fmr224098681cf.5.1786092132650;
        Fri, 07 Aug 2026 01:42:12 -0700 (PDT)
X-Received: by 2002:a05:622a:141:b0:51a:8dc5:bf89 with SMTP id d75a77b69052e-52ce5f7e59fmr224098371cf.5.1786092132261;
        Fri, 07 Aug 2026 01:42:12 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995421fee8sm117205575e9.7.2026.08.07.01.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:42:11 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 10:41:40 +0200
Subject: [PATCH net-next v2 2/2] net: stmmac: add tc-mqprio qdisc offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-stmmac-ets-offload-v2-2-9ac67af92cb8@oss.qualcomm.com>
References: <20260807-stmmac-ets-offload-v2-0-9ac67af92cb8@oss.qualcomm.com>
In-Reply-To: <20260807-stmmac-ets-offload-v2-0-9ac67af92cb8@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Daniel Thompson <daniel@riscstar.com>, Alex Elder <elder@riscstar.com>,
        Davide Caratti <dcaratti@redhat.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2NCBTYWx0ZWRfXyjpAyC9nKqWw
 +sQAW/EiEuGTWPOffAXsL+ZXrnktgFI0/YH5P7H0dTxZY0w/hpS6rglQ+kWJ0va49gdpigJN4wy
 +E/tG42W9Dz+f8MZpgzcuuvp0WAqsfpi7xbR6OuT10g6y98s9ZBzdW0Vrf40EPxFpnJiOAswXGL
 I4RkYKJGEGhK/BhkdC4eD3af/RLksb7BYejtG2fc23OIB6RPOM/OFnrvVPPE3Rxxi5jum1XxQT5
 Wgk4oxCzfbUt+eDwfGMDG/XLLkBfRZ7yL683eEeLBsoTLkfKv4mjINzu2OKjX9BycnrPbRCG0QH
 SMDKQ1LrbUt9j1OJFUSFlODzkJJnWEiQBBnKujQwkDgcXr4kCr/RQC2v7ZvLka91c3PvNHjtG/a
 c9j3J95LrvoJ16HroqDgqCkUvm/MK1qJvsU3VmSnsPPfy9yvA52yJPbO7ugDIa0plUNTLPMTmxV
 VeX0ickGmpsqgntx2+Q==
X-Authority-Analysis: v=2.4 cv=HPXz0Itv c=1 sm=1 tr=0 ts=6a759a65 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=yHRVR-la3UPYDukQr9sA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: bTXB4SPT66ajFwTBHqbvi1hTpvflrAtN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2NCBTYWx0ZWRfX741XL60h5wT9
 CJb7+W0GwnSt3rk/bxC3gxujujUI8OgRUiSZkJlltrFq3L6+Jat+OgaXqtBTpwMTFbBYxiLvXIn
 lWjI3xtRP0Vz3pnnOCG6LTT+hRxWcws=
X-Proofpoint-GUID: bTXB4SPT66ajFwTBHqbvi1hTpvflrAtN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070064

Implement offload of the tc-mqprio qdisc in the stmmac driver. The MTL
TX scheduler is switched to strict priority, and the priority (PSTQX)
of each TX queue is programmed according to the requested traffic class
mapping: queues assigned to a higher tc are given a higher priority and
are served first, while queues not mapped to any tc keep the lowest
priority.

The per-queue priorities are stored in the unified qdisc state
(priv->qdisc.prio) so they can be reprogrammed on device reopen, and
are applied through the MTL TX queue priority map registers. Export
stmmac_mac_config_tx_queues_prio() so the mqprio path can reprogram the
queue priorities. Destroying the mqprio qdisc, or failing its setup,
restores the devicetree configured scheduling algorithm, TX queue
priorities and TX queue weights.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 ++++++++-----
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 22 +++++++++++++++++++++-
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 823b40212233..1bb261fdcb0e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -305,6 +305,7 @@ struct stmmac_priv {
 		bool enable;
 		u8 algo;
 		u32 quanta[MTL_MAX_TX_QUEUES];
+		u32 prio[MTL_MAX_TX_QUEUES];
 	} qdisc;
 	struct dma_features dma_cap;
 	struct stmmac_counters mmc;
@@ -400,6 +401,7 @@ enum stmmac_state {
 extern const struct dev_pm_ops stmmac_simple_pm_ops;
 
 void stmmac_set_tx_queue_weight(struct stmmac_priv *priv);
+void stmmac_mac_config_tx_queues_prio(struct stmmac_priv *priv);
 int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7d1473fbde54..c2786ecca530 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3503,17 +3503,20 @@ static void stmmac_mac_config_rx_queues_prio(struct stmmac_priv *priv)
  *  @priv: driver private structure
  *  Description: It is used for configuring the TX Queue Priority
  */
-static void stmmac_mac_config_tx_queues_prio(struct stmmac_priv *priv)
+void stmmac_mac_config_tx_queues_prio(struct stmmac_priv *priv)
 {
 	u8 tx_queues_count = priv->plat->tx_queues_to_use;
 	u8 queue;
-	u32 prio;
 
 	for (queue = 0; queue < tx_queues_count; queue++) {
-		if (!priv->plat->tx_queues_cfg[queue].use_prio)
-			continue;
+		u32 prio = 0;
+
+		if (priv->qdisc.enable &&
+		    priv->qdisc.algo == MTL_TX_ALGORITHM_SP)
+			prio = priv->qdisc.prio[queue];
+		else if (priv->plat->tx_queues_cfg[queue].use_prio)
+			prio = priv->plat->tx_queues_cfg[queue].prio;
 
-		prio = priv->plat->tx_queues_cfg[queue].prio;
 		stmmac_tx_queue_prio(priv, priv->hw, prio, queue);
 	}
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 5dcd18b5808e..3ba71be24c64 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1218,6 +1218,7 @@ static void stmmac_qdisc_restore_dt_config(struct stmmac_priv *priv)
 	/* reset to the dt configured algorithm. */
 	priv->qdisc.enable = false;
 	stmmac_set_tx_queue_weight(priv);
+	stmmac_mac_config_tx_queues_prio(priv);
 	stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
 				      priv->plat->tx_sched_algorithm);
 }
@@ -1321,17 +1322,19 @@ static void stmmac_reset_tc_mqprio(struct net_device *ndev,
 	netdev_reset_tc(ndev);
 	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
 	stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
+	stmmac_qdisc_restore_dt_config(priv);
 }
 
 static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 				    struct tc_mqprio_qopt_offload *mqprio)
 {
 	struct netlink_ext_ack *extack = mqprio->extack;
+	struct plat_stmmacenet_data *pdata = priv->plat;
 	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
 	u32 offset, count, num_stack_tx_queues = 0;
 	struct net_device *ndev = priv->dev;
 	u32 num_tc = qopt->num_tc;
-	int err;
+	int i, tc, err;
 
 	if (!num_tc) {
 		stmmac_reset_tc_mqprio(ndev, extack);
@@ -1361,6 +1364,23 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 	if (err)
 		goto err_reset_tc;
 
+	/* Queues not mapped to any TC default to the lowest priority */
+	for (i = 0; i < pdata->tx_queues_to_use; i++) {
+		priv->qdisc.prio[i] = 0;
+		stmmac_tx_queue_prio(priv, priv->hw, 0, i);
+	}
+
+	for (tc = 0; tc < num_tc; tc++) {
+		for (i = qopt->offset[tc];
+		     i < qopt->offset[tc] + qopt->count[tc]; i++) {
+			priv->qdisc.prio[i] = tc;
+			stmmac_tx_queue_prio(priv, priv->hw, tc, i);
+		}
+	}
+	stmmac_prog_mtl_tx_algorithms(priv, priv->hw, MTL_TX_ALGORITHM_SP);
+	priv->qdisc.algo = MTL_TX_ALGORITHM_SP;
+	priv->qdisc.enable = true;
+
 	return 0;
 
 err_reset_tc:

-- 
2.55.0


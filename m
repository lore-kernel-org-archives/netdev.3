Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922EA205E02
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786200623; cv=none; b=BhZZ6MjDpju/m0DnmQ7I1QaLAD+T8yao3HKFmgSRN0CaH3HDAXOUbbgrKsdodPSujc4gawPRrmebbLcy7zTcCc19MrjYJtSGcvC2njghvZgXV1JcYy93Ab/zWXpBqG/kQkchTda+c9SsxvbU66bydJlng6iYM5Kpe9qb5YfJayo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786200623; c=relaxed/simple;
	bh=klbu8ybNnfLxC59iJSEM4Q2yQCei92BuVzUl8zwexQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WTlfcCKIUlWez7o+noXdxPMIxIWl6Uhg68ugnczJEnlFFbXPxHq+uGUCG9Sg8ZC5bf+CpipHBGuXHoSTBUes1ndGjZyeTbhAOpEco61LfDclOlMPDEbZLPV6HQ1oM1xlPaRe+mUyAQN+B5ab5opQ+rgsyPzvuMopiySEPo+kqLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KYf6PhJE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=agGFC4Gp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KYf6PhJE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="agGFC4Gp"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678DbYlC3806698
	for <netdev@vger.kernel.org>; Sat, 8 Aug 2026 14:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nETtsjmxrugp4tV//lzw0MHQFdBsUIyGf8iKZqQcwDc=; b=KYf6PhJEFvz4/nhh
	Ytew27sbTF3K+wSnqftdAkWQ1DoOiTYvM7hsc1oTTDA2Mr7BVYMH3zzE+U9PT0Oz
	MxkAIaosBoWBLYDI+qhMfST2Agiee58Wx8W6mPBbENmY+/K/05YKgTENnBvjbjJo
	Z38mUUv5273FXnAS6p4Ajza9+Ff8O4oiDSlJnD8il3MXPyIcPAf/XM9o0TVyb8RY
	GPe0bdc/Vf27Ye7jKYG64fIQA6gPYZpGgk8VvMrFCBbJMUfWsiov7pIE3fj0SnTO
	c5sWSEnk+clEF1pBkJuXPZHAw0xNGiFYQW3k/uGkhNMOOAL4cMQTBOtTNG4Ux4L1
	MPLU9A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwwr9gwy9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 14:50:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51a8b0a08d2so3463451cf.0
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 07:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786200620; x=1786805420; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nETtsjmxrugp4tV//lzw0MHQFdBsUIyGf8iKZqQcwDc=;
        b=agGFC4Gp93y8mmDHAhRbJq7UJafaBjG7uwb1QCHiihiPyCBuANl/iMfxD9X/CxjCAy
         IX+Vg6ZiaIe+MguqNVXtJeAMKJCEm0i/fF5+8A3fxSd4ItkdPDde6b74m0oakqpI7Lj5
         BM3rojotxkIwAfJKVDX+zDCt1X1D3EAxX+c+M9Ml1T6HUTumwVqLCnPSZ01Clv4DlUcU
         KX+72rtc+C+5UWLwwEsMKfwKHBKpZHxwJBaHUoCjEZ4riKJMjogJEsacCrw7DxiRn27s
         jfXkRIf6sVPU6XuSXdcVjQDvmvJ87GG1rn1MybO5w7j5CGfgNiBzeyUBEW90O23N6bN+
         DXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786200620; x=1786805420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nETtsjmxrugp4tV//lzw0MHQFdBsUIyGf8iKZqQcwDc=;
        b=kjuTQD4j7q60cJuo4vEiByxvXlYr3p1+ZLCFwNHZWfMzdSC5Wb6YbWLB6DEA5ZIH1c
         C28yhIekeASEhs9v6s8EqmSjMFWhZoUd6ip4RgZXpzbLru9LMHHE5PeWuGQxdajHlgHH
         YM3CTLRcvKArT1ZQ+jHqSvB43EoYSveumSCOrDdVUfffJ9JEpJKertiatZcZ8OaySRb0
         PRx95oqqkyD7GJrdQX/57l6DA/M4Envouz60RP9CtmOeHhZE8cGWllRcHCb8e4LDac9U
         55Sc8iK06zjDxEvBOTzzsuCYytZqju7m4s+LpS+f196aNAVtMSVJ9iTyrudIaVX8Oxdc
         j6jw==
X-Forwarded-Encrypted: i=1; AHgh+RofP+q9u8A3Og0wE3xT+IQc0FY4FqxS1LgrOudQb5lqko9JEJeYR3z71PuqwsnHRPfWj5HSEno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK5yzAiNBghzcflLvzFhugr5eJDmHNZLMRKLSwXo6pO5IMJL+E
	OtjYGIuvMNI2yHRkCXZG/2ncWjLJYjxcbuQuymDOUj5y8wev/uFaALcaVbf95bPYG0L96dRVLeI
	g4JaHTWNmw+h1Lefh4eLrk+NigXHa634P61TzEtfxLkJChfl7y1pWmOSzp8ZmUcTabcU=
X-Gm-Gg: AR+sD10XNpdfn7FW9qUyalBo5ONxyHehiXZwWqtAVgnIm7TiAMA+BBZbVvpJ+DwKtn+
	6fqPEGi/byBOMyTOkloBUPzZc1rewXGLoK2SzWjx2QnQ4Sfh6qAKJKnGgmL1MKTn6haIhCWtT9m
	YuORwfn4lXoAN7amAdgCZ3PXe+ivnppbvkucZtrl1Sf5PavhvPewxS7joBdTq3TFryZ1iO8bIKu
	gjN3QYLgtboISUGBllJK6Vr4zEBUr+EY6FSqWP4oFBpS9HrZksisyrje2T2bTXEOrvC733qza9T
	d26StTkZF6ndQI51sEYTBURZ57WA5sQL0xNo/0ebNh+A7DGqMZzjIbncr29hpi1nolzV+WzMYpP
	KTarBEkTZnMrwtkI=
X-Received: by 2002:ac8:5ad3:0:b0:527:9603:8123 with SMTP id d75a77b69052e-52ce5f611e3mr314352871cf.2.1786200619807;
        Sat, 08 Aug 2026 07:50:19 -0700 (PDT)
X-Received: by 2002:ac8:5ad3:0:b0:527:9603:8123 with SMTP id d75a77b69052e-52ce5f611e3mr314352281cf.2.1786200619322;
        Sat, 08 Aug 2026 07:50:19 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506c0sm14670677f8f.11.2026.08.08.07.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 07:50:18 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sat, 08 Aug 2026 16:49:58 +0200
Subject: [PATCH net-next v3 2/3] net: stmmac: add tc-mqprio qdisc offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-stmmac-ets-offload-v3-2-b714466142b9@oss.qualcomm.com>
References: <20260808-stmmac-ets-offload-v3-0-b714466142b9@oss.qualcomm.com>
In-Reply-To: <20260808-stmmac-ets-offload-v3-0-b714466142b9@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=d73FDxjE c=1 sm=1 tr=0 ts=6a77422c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1M5hV_b7PZp0XbSsqqoA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: w3VmsEJMzWbAN4SexW-6oKN_4UQmJWyk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDEyNyBTYWx0ZWRfX8A2XWw5zjB09
 PmAZmlEOgmcaPd7/OF2npkwm9oTrMCQoAxXeJOKuyljVRY/+2zw3BbRWKj45wGNbCA2guiiPbWz
 /8iBDEE5XwSvaNJk+QK9Y8PgVJuNQnDQsS1Tv9kLxS4mZw03QxH5rpBonUAMUrjbByxsWVDtdMI
 kv/jsdJKppF6Y+6oAcMjNPjvPIdV63ZCpPYcwvdo9E9VHIyxZ6gt8Hqh3MXxfyjuc1xYz2i3v7w
 jbfEeLixjgt8FMRmPVmmn1XVn4FLsh4OcPodAA1axtaOqg7947GM/Befkd1gj+7ppJW7HrasB9Q
 HTJsdO0Y3Z6J9QoSL4LuYDvd9wTbM5rXUmVzgX4yJPqC+p3VN68tzuXb3WS3wF6k+bWuWm323c9
 b+w1wZm0YE3Mv43jLsAsG+JCms+cKMq8UjcU1ugTW/TUCDxc+jSuLezP7xYYqrMtgYOaJtk2UJ5
 brtZ+Xy9DTWkupcNY7w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDEyNyBTYWx0ZWRfX44m7OqUIomub
 460X87gmKl7sXyCxGhQAMGIZr51kfWNlvBT+oesdHwFX/jsKmKoeB6CpaF8lLTWJJdhgS7/aGST
 xzUHnO6a6P4jZzdEimDM9qkAJYb4voI=
X-Proofpoint-GUID: w3VmsEJMzWbAN4SexW-6oKN_4UQmJWyk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080127

Implement offload of the tc-mqprio qdisc in the stmmac driver. The MTL TX
scheduler is switched to strict priority, and the PSTQX/PSTC priority
bitmask of each TX queue is programmed from the set of frame priorities
mapped to the owning traffic class (qopt->prio_tc_map).

The offload requires the DCB feature and a 1:1 TC to TX queue mapping,
with the queue ranges bounded by the number of queues the MAC implements.
Configurations with AVB queues are rejected, since forcing strict
priority conflicts with the CBS algorithm.

The per-queue priority bitmasks are stored in the unified qdisc state
(priv->qdisc.prio) so they can be reprogrammed on device reopen, and are
applied through the MTL TX queue priority map registers. Export
stmmac_mac_config_tx_queues_prio() so the mqprio path can reprogram the
queue priorities, leaving queues without snps,priority untouched.
Destroying the mqprio qdisc, or failing its setup, restores the
devicetree configured scheduling algorithm, TX queue priorities and TX
queue weights, unless a different offload is active.

Reviewed-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 15 ++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 55 ++++++++++++++++++++++-
 3 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 33c37f843336..1967279a4ccc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -307,6 +307,7 @@ struct stmmac_priv {
 		u8 bands;
 		u32 handle;
 		u32 quanta[MTL_MAX_TX_QUEUES];
+		u32 prio[MTL_MAX_TX_QUEUES];
 	} qdisc;
 	struct dma_features dma_cap;
 	struct stmmac_counters mmc;
@@ -402,6 +403,7 @@ enum stmmac_state {
 extern const struct dev_pm_ops stmmac_simple_pm_ops;
 
 void stmmac_set_tx_queue_weight(struct stmmac_priv *priv);
+void stmmac_mac_config_tx_queues_prio(struct stmmac_priv *priv);
 int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5acddc9cbd3f..e19f75d8c393 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3507,18 +3507,23 @@ static void stmmac_mac_config_rx_queues_prio(struct stmmac_priv *priv)
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
+		if (priv->qdisc.enable &&
+		    priv->qdisc.algo == MTL_TX_ALGORITHM_SP) {
+			stmmac_tx_queue_prio(priv, priv->hw,
+					     priv->qdisc.prio[queue], queue);
 			continue;
+		}
 
-		prio = priv->plat->tx_queues_cfg[queue].prio;
-		stmmac_tx_queue_prio(priv, priv->hw, prio, queue);
+		if (priv->plat->tx_queues_cfg[queue].use_prio)
+			stmmac_tx_queue_prio(priv, priv->hw,
+					     priv->plat->tx_queues_cfg[queue].prio,
+					     queue);
 	}
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 15949b5d9f32..336350d6786b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1219,6 +1219,7 @@ static void stmmac_qdisc_restore_dt_config(struct stmmac_priv *priv)
 	priv->qdisc.enable = false;
 	netif_set_real_num_tx_queues(priv->dev, priv->plat->tx_queues_to_use);
 	stmmac_set_tx_queue_weight(priv);
+	stmmac_mac_config_tx_queues_prio(priv);
 	stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
 				      priv->plat->tx_sched_algorithm);
 }
@@ -1345,8 +1346,16 @@ static void stmmac_reset_tc_mqprio(struct net_device *ndev,
 	struct stmmac_priv *priv = netdev_priv(ndev);
 
 	netdev_reset_tc(ndev);
-	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
 	stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
+
+	if (priv->qdisc.enable && priv->qdisc.algo == MTL_TX_ALGORITHM_SP) {
+		stmmac_qdisc_restore_dt_config(priv);
+	} else {
+		u8 bands = priv->qdisc.enable ? priv->qdisc.bands
+					      : priv->plat->tx_queues_to_use;
+
+		netif_set_real_num_tx_queues(ndev, bands);
+	}
 }
 
 static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
@@ -1357,13 +1366,24 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 	u32 offset, count, num_stack_tx_queues = 0;
 	struct net_device *ndev = priv->dev;
 	u32 num_tc = qopt->num_tc;
-	int err;
+	int i, tc, err;
 
 	if (!num_tc) {
 		stmmac_reset_tc_mqprio(ndev, extack);
 		return 0;
 	}
 
+	if (!priv->dma_cap.dcben)
+		return -EOPNOTSUPP;
+
+	/* Forcing strict priority conflicts with the CBS algorithm of AVB
+	 * queues, so reject the offload when any queue is configured as AVB.
+	 */
+	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
+		if (priv->plat->tx_queues_cfg[i].mode_to_use == MTL_QUEUE_AVB)
+			return -EOPNOTSUPP;
+	}
+
 	err = netdev_set_num_tc(ndev, num_tc);
 	if (err)
 		return err;
@@ -1373,6 +1393,15 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 		count = qopt->count[tc];
 		num_stack_tx_queues += count;
 
+		if (offset + count > priv->plat->tx_queues_to_use)
+			goto err_reset_tc;
+
+		/* The offload switches the MTL scheduler to strict priority,
+		 * which only supports a 1:1 TC to TX queue mapping.
+		 */
+		if (count > 1)
+			goto err_reset_tc;
+
 		err = netdev_set_tc_queue(ndev, tc, count, offset);
 		if (err)
 			goto err_reset_tc;
@@ -1387,6 +1416,28 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 	if (err)
 		goto err_reset_tc;
 
+	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
+		u32 prio = 0;
+
+		for (tc = 0; tc < num_tc; tc++) {
+			int p;
+
+			if (qopt->offset[tc] != i)
+				continue;
+
+			for (p = 0; p < ARRAY_SIZE(qopt->prio_tc_map); p++)
+				if (qopt->prio_tc_map[p] == tc)
+					prio |= BIT(p);
+			break;
+		}
+
+		priv->qdisc.prio[i] = prio;
+		stmmac_tx_queue_prio(priv, priv->hw, prio, i);
+	}
+	stmmac_prog_mtl_tx_algorithms(priv, priv->hw, MTL_TX_ALGORITHM_SP);
+	priv->qdisc.algo = MTL_TX_ALGORITHM_SP;
+	priv->qdisc.enable = true;
+
 	return 0;
 
 err_reset_tc:

-- 
2.55.0


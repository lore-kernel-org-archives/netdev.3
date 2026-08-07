Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429A3D5C26
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092137; cv=none; b=RQHwtOZS5jN8juDcyAcJ953RrUg4OR40DlbnnYEpvw6e9EfzQTmXomTs8ZjD2TM0hqHo1n9+k9wF3pxtfpJaQvwCu1SxWcXv6Fl9znouJ0zASVWbqNP1brKsfv8clowSkgVDQmkyayy92q3s+vMAE3bSNhAAPk/cka7JYcrkm70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092137; c=relaxed/simple;
	bh=GwhG+ZwYY3Te0RTHm5mZ112jKHvK6OJ/d+cdQoHAPRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sE3tCMjvi5C/vURcC2ZcGZV3INCXN0RuzluCJkP+q3k4QMhoVzdH/nY14uL9dSrmvjw9DVxrzEXnUEe+bA9D5Sg/oWleUZs5j37KPXD/jHZuTP4X7tuC7gYj7mf9rMQ9MQs0aUxNtAkahSeh+bqzNBFvkDi0yIGfjCkFP3Uhvgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HwuIsKaD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ga3NMVHf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HwuIsKaD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ga3NMVHf"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67780xqE3219574
	for <netdev@vger.kernel.org>; Fri, 7 Aug 2026 08:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zX2RD23vRIQz/ABHyG7ytkQUqMnN8cwrWXqqSeRQ5do=; b=HwuIsKaDj/jFg5SX
	k4Kno9mUe8Wkt7cg46CjAP4BsjvqRff2FBYlrAV+5dUdgwwUCiDBfa4oQD8QOnLs
	l3DFyu6IciUuq289EqkLafZzHJ+5nuUYDay+MZYlkJyFIZUHENKg+7HD0dvds4I4
	/OZ3Ve+ig9kzf89xBoox7meaIS/0Mhd4WzZxfzOMB6JIInMD7OJkCjX+xsLBaDuz
	sHoth5mWI2jzGVEPhN9QNgXeW3cK5UbjAHOoZZuhtkY788wpry9GEN6tT0aTa3+r
	NP/tJesTne/ZyuXByoNn+rKENKsbIofW/QPg7oe7ZF2vOwZEY1d4Sy33Jh30Kbwo
	njmGJg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hu18k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 08:42:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51a8db414c7so38947801cf.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 01:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786092131; x=1786696931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zX2RD23vRIQz/ABHyG7ytkQUqMnN8cwrWXqqSeRQ5do=;
        b=Ga3NMVHf042NMu014mwdfopJvhD4TpKO0X6u4/kLakedb7vaToHxAKrGHAps8EnKsR
         BI4LmEEiSj2R2Xt7uHjiXZSgHCrhOaEabgyu2GH63A2Ev21TyZ8cWcYdPzmeAb5DbaK9
         c8ZD2DXDVlhB870ofpPa4Jd2lQNK31FC8BV0A+yvgIffcJU1voP3Un2NRzzNkYqtvjf8
         QoBX1XI+3MprC3d8DeS7Nfeh1qfscSpPrYAkZiaIiT801tskTXNy8UE1NNmJzxNpVYHb
         32+4p+/95BJhUEngHzmgjKaWnH2Fv9pFspKfaaVpde4/GXQf4W+AX/irQyWunDFvg9nJ
         5ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786092131; x=1786696931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zX2RD23vRIQz/ABHyG7ytkQUqMnN8cwrWXqqSeRQ5do=;
        b=Sd3hVwQSZv1ejGMP9Yncoe+WM+LhjJa6u+ZYcv5KfG29NwEf7KFb3Gc8WZaFEU1heq
         4OL1PXSndGKafBSMXJb6oT5i0GJGtkwfvrYF3QQvoX4eDAqnKZEsLcvvBs7vlkSm98Iz
         Fh6Gf2yaEncBtzNqa2vjbNRXC7zUnjX6wu518uE+iPJxx0f8a0P4vqqxy89TINMrNPWR
         VgN34xQ60WCoqsSvp2HRg9z0Qysb0hks3RLA3AGyVCNmsArRTDCwC53K/KvyKnzQIFes
         cPkDMJYbqVM/YrJGBUgEKPhJK84SIVZqdvbxFJjkCb/VyDVxe66ognMxqIxDEqp8bCbw
         JXGg==
X-Forwarded-Encrypted: i=1; AHgh+RreUPDgeae4jYf53mFoaWigIfGxOlde90P6N5FsZRm7Ik0Z0Wy2nwtzjSTFPaiD/MzEjrljVW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwY0CydUEsj7Ny+R0UkA8ij6iLVlAs6FEBtaDAIAi1q4vT5Ohm
	8Gq7tuSsq2U3EnP9OCxacDFd2FfzZJ8L/jmGadWTvpgbKmNiNEbV7A7GSNQo9iXEQwt0eIC2cIi
	Mu5TxrDvJWIkbk+bH7Z6VHU6WKWdG34R8hUQ5NWHV18YtRYFQ8NKMzgDXg+E=
X-Gm-Gg: AR+sD13XvWTlbduQyJz4/Xybp2gwmvJ+HlsiHHanX1LM5phwrPshfSgytVHYn9tr7As
	N9AmxL4s3dJyz6Evit0aGVkREAfskXlGA3FJB1WW0rOhAC44bvBP2kzVHpT/lqp+Gxh1FNvhnLR
	ea1MWnAYU1lrTLkXckveDykbOq9K/KroOe4Om93OUyawsSd6YNNYsP/DWQbkM1UCwA/ehdjjIwd
	ImOPtbEBTvPAsOidnmaYaGHtvoohKNfbKE78AMnCTnkXwygcqtwZ4WqXyutqJ9Q9dCAqWjodi1e
	DHadlKJU8BryrreSR+2jFOGwoPwKlefdNICb1t/ZcAOoEUNSMmkuIPag4sfiZRSX3OTjBYh/Y+u
	vPxzIh1Jqsf6sc98=
X-Received: by 2002:a05:622a:a588:b0:51e:aa39:4fca with SMTP id d75a77b69052e-52ce61b3533mr233391431cf.34.1786092131222;
        Fri, 07 Aug 2026 01:42:11 -0700 (PDT)
X-Received: by 2002:a05:622a:a588:b0:51e:aa39:4fca with SMTP id d75a77b69052e-52ce61b3533mr233391001cf.34.1786092130775;
        Fri, 07 Aug 2026 01:42:10 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a404sm133680465e9.9.2026.08.07.01.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:42:09 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 10:41:39 +0200
Subject: [PATCH net-next v2 1/2] net: stmmac: add tc-ets qdisc offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-stmmac-ets-offload-v2-1-9ac67af92cb8@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2NCBTYWx0ZWRfX11jsB9ccXe6T
 3am67MHUGF5op1lJ9LimupuZC3axKT8CXfQILx9SY9zTxcSSDlzzA6lGVMHo0ut+2aQ6SuA4i0U
 rJbXt0YBYdTc5VSkmE29Dcy4dHS29Dw=
X-Authority-Analysis: v=2.4 cv=PK0/P/qC c=1 sm=1 tr=0 ts=6a759a64 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=D5QsTFb32KIK1CFUdN4A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2NCBTYWx0ZWRfX3nvQ9GxM7Q17
 UB6Py/l45bwXcNtN87XELsSSmpKdAte24HkzSjE7sjj3Ud9nSgglzEhSPqHGoXtJfdBVL73avkm
 NMm4Al8brP9LdQw27hdVi2LjgVrA+J7y2VXUA2zxq35eIPRrIM0itcXN8w4keSjvbUZZ4W/jdI4
 /Bn+cSrZeZd+Ls4EfgsmoAUZeWa6LgaF5QygV9R+/LIEhl3RV/T2HoNh9HnZ7cM0SaLyaq2mBcT
 y8nBn7p2FHey4BgvuJT5EQaSdQLZGh/x9H1qA3y+Kgz+ckF44MgyUU77ybhZ01+wgnoM5ZuOxOu
 tYuU6t2XV24tZv4oE0tY71TBvKLC1SEJkH46WXLLk8VCdEF49i/AI6qRSeWU33GiH6BpiVp2ozL
 zmxAvkXOQSErdydqsiki3SECyszpYYRgKBiF6FbSjkbXv7YIQwEs61GWt0tlTrC6IG7Ak8jtu56
 TQBHzF1PIkAK6CS8T9A==
X-Proofpoint-GUID: XWIls_GdsKm1CvvrivngnPcbIl8TeqfZ
X-Proofpoint-ORIG-GUID: XWIls_GdsKm1CvvrivngnPcbIl8TeqfZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070064

Implement offload of the tc-ets qdisc in the stmmac driver. The number
of ETS bands cannot exceed the number of TX queues, and strict priority
bands (zero quanta) are rejected, since sched prio is not implemented in
the ETS offload but will be implemented in the mqprio qdisc offload.
Weighted bands whose weight is zero are rejected as well, since MTL DWRR
would never schedule traffic on them.

The requested weights are applied to the TX queues and the MTL scheduler
is switched to DWRR. The TC_ETS_GRAFT command is not offloaded and falls
back to the software implementation, and TC_ETS_STATS is accepted while
the ETS qdisc is offloaded but no hardware statistics are provided.

Export stmmac_set_tx_queue_weight() so the ETS path can reprogram queue
weights, and wire TC_SETUP_QDISC_ETS into stmmac_setup_tc(). Destroying
the ETS qdisc restores the devicetree configured scheduling algorithm
and TX queue weights.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h        |  4 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  6 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 22 +++++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 78 +++++++++++++++++++++++
 4 files changed, 105 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 04dafec021b4..b70883a53b09 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -580,6 +580,8 @@ struct stmmac_tc_ops {
 			    struct tc_taprio_qopt_offload *qopt);
 	int (*setup_etf)(struct stmmac_priv *priv,
 			 struct tc_etf_qopt_offload *qopt);
+	int (*setup_ets)(struct stmmac_priv *priv,
+			 struct tc_ets_qopt_offload *qopt);
 	int (*query_caps)(struct stmmac_priv *priv,
 			  struct tc_query_caps_base *base);
 	int (*setup_mqprio)(struct stmmac_priv *priv,
@@ -598,6 +600,8 @@ struct stmmac_tc_ops {
 	stmmac_do_callback(__priv, tc, setup_taprio, __args)
 #define stmmac_tc_setup_etf(__priv, __args...) \
 	stmmac_do_callback(__priv, tc, setup_etf, __args)
+#define stmmac_tc_setup_ets(__priv, __args...) \
+	stmmac_do_callback(__priv, tc, setup_ets, __args)
 #define stmmac_tc_query_caps(__priv, __args...) \
 	stmmac_do_callback(__priv, tc, query_caps, __args)
 #define stmmac_tc_setup_mqprio(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 8ba8f03e1ce0..823b40212233 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -301,6 +301,11 @@ struct stmmac_priv {
 	/* Protect est parameters */
 	struct mutex est_lock;
 	struct stmmac_est *est;
+	struct {
+		bool enable;
+		u8 algo;
+		u32 quanta[MTL_MAX_TX_QUEUES];
+	} qdisc;
 	struct dma_features dma_cap;
 	struct stmmac_counters mmc;
 	int hw_cap_support;
@@ -394,6 +399,7 @@ enum stmmac_state {
 
 extern const struct dev_pm_ops stmmac_simple_pm_ops;
 
+void stmmac_set_tx_queue_weight(struct stmmac_priv *priv);
 int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c729ab127afd..7d1473fbde54 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3419,14 +3419,18 @@ static void stmmac_set_rings_length(struct stmmac_priv *priv)
  *  @priv: driver private structure
  *  Description: It is used for setting TX queues weight
  */
-static void stmmac_set_tx_queue_weight(struct stmmac_priv *priv)
+void stmmac_set_tx_queue_weight(struct stmmac_priv *priv)
 {
 	u8 tx_queues_count = priv->plat->tx_queues_to_use;
 	u32 weight;
 	u8 queue;
 
 	for (queue = 0; queue < tx_queues_count; queue++) {
-		weight = priv->plat->tx_queues_cfg[queue].weight;
+		if (priv->qdisc.enable &&
+		    priv->qdisc.algo == MTL_TX_ALGORITHM_DWRR)
+			weight = priv->qdisc.quanta[queue];
+		else
+			weight = priv->plat->tx_queues_cfg[queue].weight;
 		stmmac_set_mtl_tx_queue_weight(priv, priv->hw, weight, queue);
 	}
 }
@@ -3570,9 +3574,15 @@ static void stmmac_mtl_configuration(struct stmmac_priv *priv)
 				priv->plat->rx_sched_algorithm);
 
 	/* Configure MTL TX algorithms */
-	if (tx_queues_count > 1)
-		stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
-				priv->plat->tx_sched_algorithm);
+	if (tx_queues_count > 1) {
+		u8 tx_sched_algo;
+
+		if (priv->qdisc.enable)
+			tx_sched_algo = priv->qdisc.algo;
+		else
+			tx_sched_algo = priv->plat->tx_sched_algorithm;
+		stmmac_prog_mtl_tx_algorithms(priv, priv->hw, tx_sched_algo);
+	}
 
 	/* Configure CBS in AVB TX queues */
 	if (tx_queues_count > 1)
@@ -6428,6 +6438,8 @@ static int stmmac_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 		return stmmac_tc_setup_taprio(priv, priv, type_data);
 	case TC_SETUP_QDISC_ETF:
 		return stmmac_tc_setup_etf(priv, priv, type_data);
+	case TC_SETUP_QDISC_ETS:
+		return stmmac_tc_setup_ets(priv, priv, type_data);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 14cabe76e53e..5dcd18b5808e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1210,6 +1210,82 @@ static int tc_setup_etf(struct stmmac_priv *priv,
 	return 0;
 }
 
+/* Max quantum value supported by the MTL DWRR scheduler */
+#define MTL_TXQ_WEIGHT_QUANTUM_MAX	0x1312d0
+
+static void stmmac_qdisc_restore_dt_config(struct stmmac_priv *priv)
+{
+	/* reset to the dt configured algorithm. */
+	priv->qdisc.enable = false;
+	stmmac_set_tx_queue_weight(priv);
+	stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
+				      priv->plat->tx_sched_algorithm);
+}
+
+static int tc_setup_ets_sched(struct stmmac_priv *priv,
+			      struct tc_ets_qopt_offload *qopt)
+{
+	struct tc_ets_qopt_offload_replace_params *p = &qopt->replace_params;
+	struct plat_stmmacenet_data *pdata = priv->plat;
+	int i;
+
+	if (qopt->parent != TC_H_ROOT)
+		goto error;
+
+	if (p->bands > pdata->tx_queues_to_use)
+		goto error;
+
+	for (i = 0; i < pdata->tx_queues_to_use; i++) {
+		u32 quantum = 0;
+
+		if (pdata->tx_queues_cfg[i].mode_to_use == MTL_QUEUE_AVB)
+			goto error;
+
+		if (i < p->bands) {
+			if (!p->quanta[i])
+				goto error;
+
+			if (p->quanta[i] > MTL_TXQ_WEIGHT_QUANTUM_MAX)
+				goto error;
+
+			quantum = p->quanta[i];
+		}
+
+		priv->qdisc.quanta[i] = quantum;
+		stmmac_set_mtl_tx_queue_weight(priv, priv->hw, quantum, i);
+	}
+
+	stmmac_prog_mtl_tx_algorithms(priv, priv->hw, MTL_TX_ALGORITHM_DWRR);
+	priv->qdisc.algo = MTL_TX_ALGORITHM_DWRR;
+	priv->qdisc.enable = true;
+
+	return 0;
+error:
+	stmmac_qdisc_restore_dt_config(priv);
+	return -EOPNOTSUPP;
+}
+
+static int tc_setup_ets(struct stmmac_priv *priv,
+			struct tc_ets_qopt_offload *qopt)
+{
+	switch (qopt->command) {
+	case TC_ETS_REPLACE:
+		return tc_setup_ets_sched(priv, qopt);
+	case TC_ETS_DESTROY:
+		stmmac_qdisc_restore_dt_config(priv);
+		break;
+	case TC_ETS_STATS:
+		if (priv->qdisc.enable &&
+		    priv->qdisc.algo == MTL_TX_ALGORITHM_DWRR)
+			break;
+		fallthrough;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int tc_query_caps(struct stmmac_priv *priv,
 			 struct tc_query_caps_base *base)
 {
@@ -1308,6 +1384,7 @@ const struct stmmac_tc_ops dwmac4_tc_ops = {
 	.setup_cls = tc_setup_cls,
 	.setup_taprio = tc_setup_taprio_without_fpe,
 	.setup_etf = tc_setup_etf,
+	.setup_ets = tc_setup_ets,
 	.query_caps = tc_query_caps,
 	.setup_mqprio = tc_setup_mqprio_unimplemented,
 };
@@ -1319,6 +1396,7 @@ const struct stmmac_tc_ops dwmac510_tc_ops = {
 	.setup_cls = tc_setup_cls,
 	.setup_taprio = tc_setup_taprio,
 	.setup_etf = tc_setup_etf,
+	.setup_ets = tc_setup_ets,
 	.query_caps = tc_query_caps,
 	.setup_mqprio = tc_setup_dwmac510_mqprio,
 };

-- 
2.55.0


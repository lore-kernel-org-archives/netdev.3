Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2234E4324
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614141; cv=none; b=e4Ka3F98h6ojSESOqTKMEHtTonFDjy6SVEtNtYdiI8EEWIMqQdZjHr2okdOrpHqPl/jQWppyEYI9ilh7IKWu9wVEX7XHL6dQb5ieAWOBDzFLsdBpKm8ejp9c6/ooGoaoSY1oL4KyZbnzvkdMtnSi2LXX4gg/HoLpawBkzVvL50M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614141; c=relaxed/simple;
	bh=UGKT7D9owGAv5SXKipS0p8016+SnodYWZCdw8zYyw8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dWX1ozCh6gAnFdofqglKJZcqbirWCRKOUN3kV4+F3347geP/gJOjB8cfkBChC5u9EKbVG3UFpwP2a7l4Vg7AmUaZ1PavO8dk6nsxjeRilFum2VTG9zHsjH/UgxSHbNBUQwc50rmgUUAGLWjRZbMXf0wlk3H+OVnPJaJo0O4tXJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oP/YsMdH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DgG8zAqF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oP/YsMdH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DgG8zAqF"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEe2mu2756038
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bzYghY6HWYhZ8GOsdQtxcMIBkmho2rmuPEtIPMf1Kg4=; b=oP/YsMdHoorYP+5t
	GCVGTUUL8KucpLH/NVWusJQA3+Ekd+N8UuFHXYNUgW0qWjVUcDXeGiun+tZNF2qV
	L/OERorCUYWHbw1unasgEYtM9KhBCOx2tw6jMKbb4xnp12TK/phFvchWWRhQygym
	WpGVWpnz7i3pUlCu4lwek9ububqXhepuQH2qj8QT8LoG59flUK9z/fd9JiuEaAU1
	I2ceohsJhli4PAjKUFvMVGhBhmOqWH7bmwoi7x+z0ZF5sGmaubDA/Op1R3qM9f1A
	17gCGgFrpS+YGecrDhfo0ONYDYG4LgqEO0CLhJ717jTySF94AwduAzJaMFi8julk
	e658RQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubjkva-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:48:58 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-98527cdac1eso330331241.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790614138; x=1791218938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bzYghY6HWYhZ8GOsdQtxcMIBkmho2rmuPEtIPMf1Kg4=;
        b=DgG8zAqFCQP3W9/z6wSnXVUNnB941CrI+cW9lsvDzawPQnU+CGcJebBtNfemLaDjAx
         VXLNzVOcgfzjoJEHvuR8xr56Z7czSooLIDTs91usC0cTTMtbt87PB4os/AhIF5gboDcx
         QO3yh8MvLlh+ZiI7cML5YNKUHTBAXUiO2sunzBI7qdiIW5OJDQG+x/3CYkng+p3tOKb/
         oOI2t/2TQ0mDtJ/+jFhtcYu2saPQodZA7QtYLMt5stNIGRE2wvVh4SxjMFQXAD57Gxk5
         M5yiRp2rDtnVrkt6bkqINHYdMgIr8szpvTiPUOQD7RgKzODjxA7PpMQWH8X6pvJ0IQAo
         X39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790614138; x=1791218938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bzYghY6HWYhZ8GOsdQtxcMIBkmho2rmuPEtIPMf1Kg4=;
        b=No+472aYGWcoHtTBNm7RDvXyi7DHxSNmton4D8YK65yZPJn5fv6vB8YcXUuq2U0b8B
         ow3MUTP3zRn7ZACG/MAQe3Sgsj0VKiECKWTTw2ALwTZ8jjHphqQE+cyNcKLQRDGHtteM
         EstuNl0wmkGRWK8sAfz1CIAdb/PGKOz6sYec5zRmhXeyV5NIa/pX9iVxFmUiPTYrrwvw
         zpEBVbf/u1wVleBh8tSgIXaiqLMZG6hmuqFRA3kelje6aPLkJBHP66lT1nh6s8dVbcRT
         PhMoItoiLrezyw34TovRjI0o0iCeqHP/Su9ebZnN6vRMoGjOe1HxObZsl/TS9BuMtyTh
         jT9A==
X-Forwarded-Encrypted: i=1; AKwUvBzWF1jTfXJhxLXuDPExiK8XLL5/IUIvVipKH8Blxt2AGlewLjV0ejwvfVgckttgwhfUn9sIVYI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuxyCEoh9sbQiRwRU0tg7cUPtzBY+R4CIFNEOtkOw6PTRWuD3C
	z8rrWQJ/gwpn4WpY2IwsHyr+yVmm+vYEhxl0QFnvTSvshcBV8JdVHtV/m/ZSxOhMvxwQ9Sxh7k2
	LS26s6beiMLoOt2uQIg3IVGOhzUjmkHtGXPhmLJKMw8o+ZAUGieZC1ydMi/g=
X-Gm-Gg: AYBFou3830CzjAtny+c439XeBrfT4GB6vRp1GUF3R0JmDXAUQ+5KkkF72otMLSYxUOj
	mYw0Kn9dTFCC2pegmbLITDJn9Rm1lKu9MAfe9Svx2HqHG+a7ZDh6slfKsFS37MRUose5JWk7zhC
	bw0f7PnkuGMb+TrO5p2MexE/6DSv+dbiN0o+s5AixkgjQOk4CUGLv7/S26drd54piVMIDG8bSOw
	c70k7yaymr/kRVI6BwVnUjowA9XLBr6exEZ8TXGNP1lQKr1h+qSUkr0GPOgReMeegYJRBioMRa2
	qIr9w5BSGHfAW0iJdeY4p8EW0OjCPJnKUR9Cebv618brtDkB0adyRvPdWcOipS2JOJmzGwZgp9r
	/csDxqYDHeTcSRg==
X-Received: by 2002:a05:6102:848b:10b0:7b2:f790:c028 with SMTP id ada2fe7eead31-7b2f790cdd3mr1412457137.25.1790614137261;
        Mon, 28 Sep 2026 09:48:57 -0700 (PDT)
X-Received: by 2002:a05:6102:848b:10b0:7b2:f790:c028 with SMTP id ada2fe7eead31-7b2f790cdd3mr1412242137.25.1790614120700;
        Mon, 28 Sep 2026 09:48:40 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a648895sm28784444f8f.28.2026.09.28.09.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:48:39 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:48:13 +0200
Subject: [PATCH net-next v3 1/2] net: stmmac: add tc mqprio hw queue
 priority offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-stmmac-mqprio-prio-offload-v3-1-abbe181f5024@oss.qualcomm.com>
References: <20260928-stmmac-mqprio-prio-offload-v3-0-abbe181f5024@oss.qualcomm.com>
In-Reply-To: <20260928-stmmac-mqprio-prio-offload-v3-0-abbe181f5024@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>
Cc: Daniel Thompson <daniel@riscstar.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Davide Caratti <dcaratti@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: LBIc-Kl8UKINYneqakdL80oI78TIvhAD
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba9a7a cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=d0kHe6nCisoU4kiX0eUA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: LBIc-Kl8UKINYneqakdL80oI78TIvhAD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NiBTYWx0ZWRfX9/H5rhYjPQ5z
 qYDD9ScXQLMlSNrUGCCEQ6HS4MbAsf4TV0+sRlrcan++Gbt9w+75Hry6eeZXmaNaq3mB6YDv5g4
 N9oEGpDCS6VD96SKkO9jEBQ3Ww+ugw3so70GABE5KezNdcex7g15EdOfRDDolXbEIJUeSzYplya
 eRSheA8ETXOjsaf026MGzX9abXCI76dl2M67tEz1qRUY/xbbqRfJNwkyC3ZlnNcEivVn4yAP27s
 52/ktmNNjAyf7zmk8bAj+mksXI2IJxI+FLrIk/2iOj5bkm5MuyoViV6KL3hOrpF+bpzNXgfBI0A
 Z3XzOaOxFoSpWBgwTJJZ/OkVCG5ezJIpFNL0tpyXMriRPGuRysccNqkjWX6zKjoSO21e2r59VNp
 C4kWFlTw61lfD0lwD7BVT5jHQ2aAOYONs4d72uolRquPar2K4rfGs7EGH8GogoTD19lpUuyXJrE
 scy9jaixAHAt0U9/0UQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NiBTYWx0ZWRfXyXnX1c8E4DzD
 JLXNi0TGQjcVOi3PeHH7kBlTyZaZroMj1w/jxh880gmAudqWvSSlN8HZCc4gjWwmnkXlPNl/lSs
 eFC6YUrosHb5AeyJ8BBxPEm0bq3v5oQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280066

Implement the offload of the tc mqprio hw queue priority in the stmmac
driver. When the mqprio qdisc is configured in channel mode, the MTL TX
scheduler is switched to strict priority, and the PSTQX/PSTC priority
bitmask of each TX queue is programmed from the set of frame priorities
mapped to the owning traffic class (qopt->prio_tc_map).

The channel mode offload requires the DCB hw feature and a 1:1 TC to TX
queue mapping, with a single queue per TC. Configurations with AVB queues
are rejected, since forcing strict priority conflicts with the CBS
algorithm.

In the default DCB mode, only the netdev TC map and the FPE preemption
class mapping are offloaded, leaving the MTL scheduler and the per-queue
priorities to the device-tree configuration.

Reviewed-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   7 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  25 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 138 ++++++++++++++++++++--
 4 files changed, 150 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 4fc96b317d79..f1bdb65d0fe6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -299,6 +299,13 @@ struct stmmac_priv {
 	/* Protect est parameters */
 	struct mutex est_lock;
 	struct stmmac_est *est;
+
+	struct {
+		u32 prio[MTL_MAX_TX_QUEUES];
+		bool prio_offload;
+		u8 algo;
+	} xmit_qdisc;
+
 	struct dma_features dma_cap;
 	struct stmmac_counters mmc;
 	int hw_cap_support;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index c889204a7aa5..b6b5ef7c8fc4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -230,7 +230,7 @@ int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
 		if (count == 1)
 			continue;
 
-		if (priv->plat->tx_sched_algorithm == MTL_TX_ALGORITHM_SP) {
+		if (priv->xmit_qdisc.algo == MTL_TX_ALGORITHM_SP) {
 			NL_SET_ERR_MSG_MOD(extack, ALG_ERR_MSG);
 			return -EINVAL;
 		}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3ad9252bf6ae..27e4e86e3c8b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3533,17 +3533,11 @@ static void stmmac_mac_config_rx_queues_prio(struct stmmac_priv *priv)
  */
 static void stmmac_mac_config_tx_queues_prio(struct stmmac_priv *priv)
 {
-	u8 tx_queues_count = priv->plat->tx_queues_to_use;
-	u8 queue;
-	u32 prio;
-
-	for (queue = 0; queue < tx_queues_count; queue++) {
-		if (!priv->plat->tx_queues_cfg[queue].use_prio)
-			continue;
+	int i;
 
-		prio = priv->plat->tx_queues_cfg[queue].prio;
-		stmmac_tx_queue_prio(priv, priv->hw, prio, queue);
-	}
+	for (i = 0; i < priv->plat->tx_queues_to_use; i++)
+		stmmac_tx_queue_prio(priv, priv->hw,
+				     priv->xmit_qdisc.prio[i], i);
 }
 
 /**
@@ -3604,7 +3598,7 @@ static void stmmac_mtl_configuration(struct stmmac_priv *priv)
 	/* Configure MTL TX algorithms */
 	if (tx_queues_count > 1)
 		stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
-				priv->plat->tx_sched_algorithm);
+					      priv->xmit_qdisc.algo);
 
 	/* Configure CBS in AVB TX queues */
 	if (tx_queues_count > 1)
@@ -7924,6 +7918,15 @@ static int __stmmac_dvr_probe(struct device *device,
 	priv->wol_irq = res->wol_irq;
 	priv->sfty_irq = res->sfty_irq;
 
+	/* Default xmit qdisc configuration */
+	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
+		if (!priv->plat->tx_queues_cfg[i].use_prio)
+			continue;
+
+		priv->xmit_qdisc.prio[i] = priv->plat->tx_queues_cfg[i].prio;
+	}
+	priv->xmit_qdisc.algo = priv->plat->tx_sched_algorithm;
+
 	if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN) {
 		ret = stmmac_msi_init(priv, res);
 		if (ret)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 42a00446e9b4..07cf4582ed76 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -346,6 +346,9 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	if (!priv->dma_cap.av)
 		return -EOPNOTSUPP;
 
+	if (qopt->enable && priv->xmit_qdisc.prio_offload)
+		return -EOPNOTSUPP;
+
 	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
 
 	if (qopt->enable) {
@@ -1266,12 +1269,109 @@ static int stmmac_reset_tc_mqprio(struct net_device *ndev,
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
 
+	if (priv->xmit_qdisc.prio_offload) {
+		int i;
+
+		for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
+			u32 prio;
+
+			if (priv->plat->tx_queues_cfg[i].use_prio)
+				prio = priv->plat->tx_queues_cfg[i].prio;
+			else
+				prio = 0;
+
+			stmmac_tx_queue_prio(priv, priv->hw, prio, i);
+			priv->xmit_qdisc.prio[i] = prio;
+		}
+
+		stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
+					      priv->plat->tx_sched_algorithm);
+		priv->xmit_qdisc.algo = priv->plat->tx_sched_algorithm;
+		priv->xmit_qdisc.prio_offload = false;
+	}
+
 	netdev_reset_tc(ndev);
 	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
 
 	return stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
 }
 
+static void tc_mqprio_config_queue_prio(struct stmmac_priv *priv,
+					struct tc_mqprio_qopt *qopt)
+{
+	int i;
+
+	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
+		u32 prio = 0;
+		int j;
+
+		for (j = 0; j < qopt->num_tc; j++) {
+			int p;
+
+			if (qopt->offset[j] != i)
+				continue;
+
+			/* The PSTQX/PSTC priority map is 8 bits wide, so only
+			 * priorities 0-7 can be represented in hardware.
+			 * Priorities 8-15 are handled in software by the
+			 * kernel through the netdev prio_tc_map.
+			 */
+			for (p = 0; p < 8; p++) {
+				if (qopt->prio_tc_map[p] == j)
+					prio |= BIT(p);
+			}
+			break;
+		}
+
+		stmmac_tx_queue_prio(priv, priv->hw, prio, i);
+		priv->xmit_qdisc.prio[i] = prio;
+	}
+
+	stmmac_prog_mtl_tx_algorithms(priv, priv->hw, MTL_TX_ALGORITHM_SP);
+	priv->xmit_qdisc.algo = MTL_TX_ALGORITHM_SP;
+	priv->xmit_qdisc.prio_offload = true;
+}
+
+static int tc_mqprio_validate_chan_mode(struct stmmac_priv *priv,
+					struct tc_mqprio_qopt_offload *mqprio)
+{
+	struct plat_stmmacenet_data *pdata = priv->plat;
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	int i;
+
+	if (!priv->dma_cap.dcben) {
+		NL_SET_ERR_MSG_MOD(mqprio->extack,
+				   "hw DCB is required to offload mqprio");
+		return -EOPNOTSUPP;
+	}
+
+	/* Forcing strict priority conflicts with the CBS algorithm
+	 * of AVB queues, so reject the offload when any queue is
+	 * configured as AVB.
+	 */
+	for (i = 0; i < pdata->tx_queues_to_use; i++) {
+		if (pdata->tx_queues_cfg[i].mode_to_use == MTL_QUEUE_AVB) {
+			NL_SET_ERR_MSG_MOD(mqprio->extack,
+					   "SP conflicts with AVB queues");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	for (i = 0; i < qopt->num_tc; i++) {
+		/* The offload switches the MTL scheduler to strict
+		 * priority, which only supports a 1:1 TC to TX queue
+		 * mapping.
+		 */
+		if (qopt->count[i] > 1 || qopt->offset[i] != i) {
+			NL_SET_ERR_MSG_MOD(mqprio->extack,
+					   "SP requires 1:1 TXQ map");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
 static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 				    struct tc_mqprio_qopt_offload *mqprio)
 {
@@ -1282,23 +1382,22 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
 	struct net_device *ndev = priv->dev;
 	u8 ndev_prio_tc_map[TC_BITMASK + 1];
-	int i, err, ndev_ntc;
+	int i, err, ndev_ntc, mode;
 
 	if (!qopt->num_tc)
 		return stmmac_reset_tc_mqprio(ndev, extack);
 
-	if (qopt->num_tc > ARRAY_SIZE(tc_to_txq))
+	if (qopt->num_tc > priv->plat->tx_queues_to_use)
 		return -EINVAL;
 
-	/* save current tc values for reset */
-	ndev_ntc = netdev_get_num_tc(ndev);
-	for (i = 0; i < ARRAY_SIZE(ndev->tc_to_txq); i++)
-		ndev_tc_to_txq[i].combined =
-			READ_ONCE(ndev->tc_to_txq[i].combined);
-	for (i = 0; i < ARRAY_SIZE(ndev_prio_tc_map); i++)
-		ndev_prio_tc_map[i] = READ_ONCE(ndev->prio_tc_map[i]);
-
 	for (i = 0; i < qopt->num_tc; i++) {
+		if (qopt->offset[i] + qopt->count[i] >
+		    priv->plat->tx_queues_to_use) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Queues exceed hw TX queues");
+			return -EINVAL;
+		}
+
 		tc_to_txq[i] = (struct netdev_tc_txq) {
 			.count = qopt->count[i],
 			.offset = qopt->offset[i],
@@ -1306,6 +1405,22 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 		num_tx_queues += qopt->count[i];
 	}
 
+	mode = mqprio->flags & TC_MQPRIO_F_MODE ? mqprio->mode
+						: TC_MQPRIO_MODE_DCB;
+	if (mode == TC_MQPRIO_MODE_CHANNEL) {
+		err = tc_mqprio_validate_chan_mode(priv, mqprio);
+		if (err)
+			return err;
+	}
+
+	/* save current tc values for reset */
+	ndev_ntc = netdev_get_num_tc(ndev);
+	for (i = 0; i < ARRAY_SIZE(ndev->tc_to_txq); i++)
+		ndev_tc_to_txq[i].combined =
+			READ_ONCE(ndev->tc_to_txq[i].combined);
+	for (i = 0; i < ARRAY_SIZE(ndev_prio_tc_map); i++)
+		ndev_prio_tc_map[i] = READ_ONCE(ndev->prio_tc_map[i]);
+
 	err = stmmac_set_ndev_tcs(ndev, qopt->num_tc, tc_to_txq);
 	if (err)
 		goto error_reset_tc;
@@ -1320,6 +1435,9 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 	if (err)
 		goto error_reset_num_tx_queues;
 
+	if (mode == TC_MQPRIO_MODE_CHANNEL)
+		tc_mqprio_config_queue_prio(priv, qopt);
+
 	return 0;
 
 error_reset_num_tx_queues:

-- 
2.55.0


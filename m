Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448903E44E4
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283607; cv=none; b=UUKkUaF5wZykm/YsgKiGyrdoH/6NNi9Z0h8mbUikSs20Bf/1wjM37D8JtS6dm33BUW/q0ShzBgtZc1VKzCijJneJ7kl46br361WZZh7vNieeR+P5zsyzZxjpUkXTz5znLi9iAlXG1GeYU6nyWvRDMfeOWA+cPtqN/015mPwshSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283607; c=relaxed/simple;
	bh=682hrABsCm4WfQ79RTwQLFWN9IxsPioidJAPf96TWZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W3+D3mMRxCjjtTQFhI8zZMmHQ1/KfPlBMg3mA5tgAVBdBo3Ss4cJlGnfvEjo15rpzzXaR/Hm7mCD+oK/LFxnapWEtLv2kYrkQJjHLd3Vfee8ABf5iUJVzuHxXNv3IZ9XogKfQLhfX++CiuaQZSiydPymR2rEUab7wM0QV7kpFAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JZ8Xm0VW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YKrhVsX1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JZ8Xm0VW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YKrhVsX1"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696ARGAH1543908
	for <netdev@vger.kernel.org>; Tue, 6 Oct 2026 10:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dx9m3KoyXG+64l0VuwtMujcGUymxe716+I4+2iOeJj0=; b=JZ8Xm0VWnv/GA+bl
	LyMi+DDxKUXV3Uvxturok4+sagXN+jyJr8J0BrBcKhnySfqEhj511gsyJwW4VFR4
	P/gTEZF1rL3aR8uyGr7ArWMc0XLFG1JrJPmLKb6IXpzRuyGyrYOqV/fvzhH9rxEN
	HwEW4KSOMsyjBxu4XRMmFZMXdKlkLOuhN7Dd0naNMaxYyLY+xyPYIHmCSmwgRIV6
	y9uIhi6/bpllvpK1pDVUrF2v981efQaUr2m0UySfBPSz4OyLr/lZ3zdH0cE44Fzy
	Q8hpoH8nzwBBNg/hG+8KqT8qBvdVhfzDbNQKCZ0MnehkGfPsw3F2Z9glZNM6r8RJ
	Vvzk1Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4uy4gu03-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:46:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cc7a6e4e1so718630285a.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 03:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791283604; x=1791888404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dx9m3KoyXG+64l0VuwtMujcGUymxe716+I4+2iOeJj0=;
        b=YKrhVsX1EXdiIDLa5iv6xjM+mR81yWxyhzkZfqZ7x5mu6vztDEeuHSNJH45SH0hRa/
         CdAj1Q9VmGZ6pTD59p8v753fHbyTnHa2DKywEF5QN3APPJBrgEzF8atjzVs8PLhtVfop
         952Om1d/8SCWmtWTOu3ODuBvJv4vKR/qcRi2n3dWtOSeUaslrPMEH6E7uatd8XuldkAv
         zPHnqLGpX2YPYthujIlP6XAf0MnGHXXwfFCBMCDG3IUyHtExbAZy3XYz0f1tyH6HlRUq
         Lm9GPijmu1EYAjfRlrsQ7kQYaxDhBimC9YwcJFD2JP/DGisZrLOKYgt5L7gD6cgEljsz
         LzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791283604; x=1791888404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dx9m3KoyXG+64l0VuwtMujcGUymxe716+I4+2iOeJj0=;
        b=DOhYnGaGx5cxEQI492iAJ1s8r+tgDHQZvinUWUFvl6CMQL7xli2V8vtVaXzO2hNbec
         8UHp3PBR4o1LnLQnpSSufn4XfBiYTLKJu+aFiN47xYCfTtQ8I+xtfvac3NOFExi3t/QL
         isK7tlS6ESskuubh4iV4Fs8GWV1a6W2IjmRdGoPbV4dx3HAdiuaaCkA3zPELWozJ0jtw
         +W63cSaKu2lv40avgV0JPP7iqCw8oOmzLCOTTpAl5/B6PW0SW8imA4ooLDEI7erq6hoH
         9+Q0nJwqUKcH1BMrSfoBvU21lWRumqGWoPaunBlSBybKoDmKaVKFhCARVQGZbxfgiocZ
         VphA==
X-Forwarded-Encrypted: i=1; AKwUvBxQ2E+JCdldnE8MLWIQX7Gnkv8N97vqeF3QN2hA/dwOU9X3BeVbuiUvqoz6P+9ifPbZ6n4k5Nw=@vger.kernel.org
X-Gm-Message-State: AFuF++ki/8rxWaBv4HqHbO1AQA2rx3Go2TYg85ROuEVRM4/vaWerXyO+
	g41s9A8hti4ojtM31K8de5SdIhZBHA1NrDKVfIeCUhFhqRBHfL7/TIM6YhHFEGkf7J+C4tIWbbz
	QjrH7/dU1Q3/OuBC3V6aiXR+yHII3srtrBwL/03OF3P43AgWfPbGmGjD595Q=
X-Gm-Gg: AYBFou1mrIPMxQlhMVS25lwdq45k795zFfWqaZ7B/1Lub/Gp/d0UP1ZxcyIr4e33330
	KFq1CIegPRQWrvdn7RfHyqx3oDV7bunCCCU5xojQdbXztynXUBc5ci1tu5RD7zqn+eoHyDmmgNE
	vAnoQ3E00iELrCXGBpt0nIHQ6v0QtfNRbtJzZhAhk6A52NCT4mXQ5lwt5UMgveSiJjZh59u/DUO
	+r5HMHrhmJPblknEbxT+d2ievC3sov4csgoEcjL6N85dH1eOPY3S+1lo2J0NYwb2PWto4y1fNE7
	0gu87dGq1IHj5ecr02mb0VPgXiPpGI3UL/+EqoWza9AMnG4AvpxRhMrPNl9N3WnyT+4UqSBMkgD
	9pJLJJLWRvyr06A==
X-Received: by 2002:a05:620a:3908:b0:93c:88ab:3482 with SMTP id af79cd13be357-93e8f35e81emr163643185a.29.1791283603988;
        Tue, 06 Oct 2026 03:46:43 -0700 (PDT)
X-Received: by 2002:a05:620a:3908:b0:93c:88ab:3482 with SMTP id af79cd13be357-93e8f35e81emr163639385a.29.1791283603429;
        Tue, 06 Oct 2026 03:46:43 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c62289e77sm9986132f8f.21.2026.10.06.03.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:46:42 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 06 Oct 2026 12:46:27 +0200
Subject: [PATCH net-next v5 3/3] net: stmmac: add tc mqprio hw queue
 priority offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-stmmac-mqprio-prio-offload-v5-3-d7da93419784@oss.qualcomm.com>
References: <20261006-stmmac-mqprio-prio-offload-v5-0-d7da93419784@oss.qualcomm.com>
In-Reply-To: <20261006-stmmac-mqprio-prio-offload-v5-0-d7da93419784@oss.qualcomm.com>
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
        Davide Caratti <dcaratti@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfX5TwrmuiJ7DS1
 kVgAAYQDkWO3zwmQUFReYyz7ToGgacrzyWtLYd4ZHuD/pqIuwBgVSPeSzMctC4PmWzeThTjoY1f
 G/0kVBxqMvq2ZCNe15J7rIPBQhMS+EdLt29TLbwjKql8wgkDYI7ZQDNV7QOMhTkxCic0GjorxLc
 BEgkWYX0NySESLl7LphBjCp5Zjpi3I2htHG2XA0aI4Tf9IKzHa/D4yEPxMRq8YIoxwXb/Cf4gRE
 jxyj5WQuJNgRraCJmG+8AMD4wfg4Fo5QfdkQZGE+0CB+CWCW8P1COAyXJto6ZFRhokCuX0Ug9qA
 hwIrMgsHRZ2w0P1CmPX1z4sCYYECEM0eP7XLL3oLK+fqt2p2s7E1OcukLn3IjufydPbwmBbNMUj
 UT1MSARgFkSeBKpcmnNj2moy0ffXqiBZpqflxIdFsWdP4+DDPSQ+Xu3TG6CXRtGMeTbq4VNFP1K
 pF5AAWp3xJGbleGrf9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfX7wOs9likKPms
 wKZjpD9QPGg4QObB8EO5mKRZPd0O1/+CM2TVgHoDcUXIzU7z31ZgB5cDE5savEBjmoMIZXI/AWQ
 441QwzcK96fT77VzjgEPPRZiqmEy838=
X-Authority-Analysis: v=2.4 cv=F97C5ahN c=1 sm=1 tr=0 ts=6ac4d195 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=dYERuBvVx-ELa3hM7TQA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: Qg6_zMlPWS8uYmHKICsuAf8Xmlg1figh
X-Proofpoint-GUID: Qg6_zMlPWS8uYmHKICsuAf8Xmlg1figh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060042

Implement the offload of the tc mqprio hw queue priority in the stmmac
driver. When the mqprio qdisc is configured in channel mode, the MTL TX
scheduler is switched to strict priority, and the PSTQX/PSTC priority
bitmask of each TX queue is programmed from the set of frame priorities
mapped to the owning traffic class (qopt->prio_tc_map).

The channel mode offload requires the DCB hw feature and a 1:1 TC to TX
queue mapping, with a single queue per TC. Configurations with AVB queues
are rejected, since forcing strict priority conflicts with the CBS
algorithm. The CBS offload is refused while the strict-priority scheduler
is active, and so is a channel count change that would enable an AVB
queue.

In the default DCB mode, only the netdev TC map and the FPE preemption
class mapping are offloaded, leaving the MTL scheduler and the per-queue
priorities to the device-tree configuration.

The num_tc bound against ARRAY_SIZE(tc_to_txq) is no longer needed: the
check that each TC's offset + count stays within plat->tx_queues_to_use
already bounds num_tc, because the TC ranges do not overlap and each one
spans at least one queue.

Reviewed-by: Davide Caratti <dcaratti@redhat.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  33 ++++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 134 ++++++++++++++++++++--
 4 files changed, 148 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 0052f2129297..40eab899027b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -302,7 +302,10 @@ struct stmmac_priv {
 
 	struct {
 		bool enabled;
+		u32 prio[MTL_MAX_TX_QUEUES];
+		bool prio_offload;
 		u32 num_tx_queues;
+		u8 algo;
 	} xmit_qdisc;
 
 	struct dma_features dma_cap;
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
index 9c03d21ebfcc..762ac86a9abb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3535,17 +3535,11 @@ static void stmmac_mac_config_rx_queues_prio(struct stmmac_priv *priv)
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
@@ -3606,7 +3600,7 @@ static void stmmac_mtl_configuration(struct stmmac_priv *priv)
 	/* Configure MTL TX algorithms */
 	if (tx_queues_count > 1)
 		stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
-				priv->plat->tx_sched_algorithm);
+					      priv->xmit_qdisc.algo);
 
 	/* Configure CBS in AVB TX queues */
 	if (tx_queues_count > 1)
@@ -7711,6 +7705,14 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
 	    tx_cnt < priv->xmit_qdisc.num_tx_queues)
 		return -EINVAL;
 
+	if (priv->xmit_qdisc.prio_offload) {
+		for (i = priv->plat->tx_queues_to_use; i < tx_cnt; i++) {
+			if (priv->plat->tx_queues_cfg[i].mode_to_use ==
+			    MTL_QUEUE_AVB)
+				return -EINVAL;
+		}
+	}
+
 	if (netif_running(dev))
 		stmmac_release(dev);
 
@@ -7956,6 +7958,15 @@ static int __stmmac_dvr_probe(struct device *device,
 	priv->wol_irq = res->wol_irq;
 	priv->sfty_irq = res->sfty_irq;
 
+	/* Default xmit qdisc configuration */
+	for (i = 0; i < ARRAY_SIZE(priv->plat->tx_queues_cfg); i++) {
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
index a7721b2eee96..ea1f97d6f0bd 100644
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
@@ -1266,6 +1269,28 @@ static int stmmac_reset_tc_mqprio(struct net_device *ndev,
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
 
+	if (priv->xmit_qdisc.prio_offload) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(priv->plat->tx_queues_cfg); i++) {
+			u32 prio;
+
+			if (priv->plat->tx_queues_cfg[i].use_prio)
+				prio = priv->plat->tx_queues_cfg[i].prio;
+			else
+				prio = 0;
+
+			priv->xmit_qdisc.prio[i] = prio;
+			if (i < priv->plat->tx_queues_to_use)
+				stmmac_tx_queue_prio(priv, priv->hw, prio, i);
+		}
+
+		stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
+					      priv->plat->tx_sched_algorithm);
+		priv->xmit_qdisc.algo = priv->plat->tx_sched_algorithm;
+		priv->xmit_qdisc.prio_offload = false;
+	}
+
 	priv->xmit_qdisc.num_tx_queues = priv->plat->tx_queues_to_use;
 	priv->xmit_qdisc.enabled = false;
 
@@ -1275,6 +1300,83 @@ static int stmmac_reset_tc_mqprio(struct net_device *ndev,
 	return stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
 }
 
+static void tc_mqprio_config_queue_prio(struct stmmac_priv *priv,
+					struct tc_mqprio_qopt *qopt)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(priv->plat->tx_queues_cfg); i++) {
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
+		priv->xmit_qdisc.prio[i] = prio;
+		if (i < priv->plat->tx_queues_to_use)
+			stmmac_tx_queue_prio(priv, priv->hw, prio, i);
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
@@ -1285,22 +1387,11 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
 	struct net_device *ndev = priv->dev;
 	u8 ndev_prio_tc_map[TC_BITMASK + 1];
-	int i, err, ndev_ntc;
+	int i, err, ndev_ntc, mode;
 
 	if (!qopt->num_tc)
 		return stmmac_reset_tc_mqprio(ndev, extack);
 
-	if (qopt->num_tc > ARRAY_SIZE(tc_to_txq))
-		return -EINVAL;
-
-	/* save current tc values for reset */
-	ndev_ntc = netdev_get_num_tc(ndev);
-	for (i = 0; i < ARRAY_SIZE(ndev->tc_to_txq); i++)
-		ndev_tc_to_txq[i].combined =
-			READ_ONCE(ndev->tc_to_txq[i].combined);
-	for (i = 0; i < ARRAY_SIZE(ndev_prio_tc_map); i++)
-		ndev_prio_tc_map[i] = READ_ONCE(ndev->prio_tc_map[i]);
-
 	for (i = 0; i < qopt->num_tc; i++) {
 		if (qopt->offset[i] + qopt->count[i] >
 		    priv->plat->tx_queues_to_use) {
@@ -1317,6 +1408,22 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 				    qopt->offset[i] + qopt->count[i]);
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
@@ -1331,6 +1438,9 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 	if (err)
 		goto error_reset_num_tx_queues;
 
+	if (mode == TC_MQPRIO_MODE_CHANNEL)
+		tc_mqprio_config_queue_prio(priv, qopt);
+
 	priv->xmit_qdisc.num_tx_queues = num_tx_queues;
 	priv->xmit_qdisc.enabled = true;
 

-- 
2.55.0


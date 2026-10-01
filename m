Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0283250AC15
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862656; cv=none; b=lCnPf1q1vcGbul0Y1NOY9v5FFl7M9jUXkkkcdUP5HdbOKGhiveUwXQk6no5CV9HU/GP99Rx6Y6W92JetV0bSKut5s3Y0qJd74c6Cc3Ul9s2ooWw+yvkFfTZjteSKj8yj0TIG5Y0XWoirykIeHCnloP9I7yj5pFYvXVMK4tOOKF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862656; c=relaxed/simple;
	bh=2IAfrAcoCAD8LYlzOkpezzm2UcPdRJKtc5wWwy9PQOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XNchB7EetI06u5UG1YN0YcWzQwd3UwPlUFFjA/sMEfi/LQlK6N+q7c1P9hQoYEscfJShkkmoju2RyDF6uUSW0QDo5bq/w6mzFlywJGGs44vYQLktypeLOAj6k/05zs7LrQ3lcFskIavgacIha1W5WFPBSemhWIu1gSHArYq/668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k9FCl05R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EnXktmfJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k9FCl05R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EnXktmfJ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DjbXG2570637
	for <netdev@vger.kernel.org>; Thu, 1 Oct 2026 13:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7oDFYsh9mnWtMPcaBpFSVg79NtIgY46+tkUCTRyhxGc=; b=k9FCl05ReU943MH9
	OT91GQ6Ht2jIYQrVhIGbKhUhBB4JQETwGL1qkhcRLIfYvObhIgTnidJqosss7QRM
	bkwA1IT/4PwJxyvgVUPVlAOZsfMXrfjjK3iazILMDen+aHV0KTnT+mSuSsZNsMtT
	LH7zY7BlfPC4qYDtsDEKtO+gVNwLgMu8/u4maup8UZW9f6kbb2nlcDF9pfww82DS
	6RqsKY4EgpavSGIE7oKVX2nh9sFVggDjJwF6G8GjmOcVb1jjo0ueb0X/bZLeE6pJ
	viJXFghyVIwH+uiKogZxwrAkX2X5guznIG9tfWTbQNdjDXOB05oMwaI6Z56nkYag
	PoolNg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h167pn2p5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:50:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a082c014aso227916485a.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 06:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790862653; x=1791467453; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7oDFYsh9mnWtMPcaBpFSVg79NtIgY46+tkUCTRyhxGc=;
        b=EnXktmfJYTNSyB4BDFuHei1iMB/Jw9k55hP9iuhq9ksZqxJPASQUcdkInCtjY46j6P
         qchSV1M+J4b64WhZr8OvQMSg4etwkbMG8Nuj1zd9Zyu38dz9A4PfAmWBcI8bKyAIkhDh
         XS41sOfMdNTpKCJ49t4G7dVcqncniCKHdhn5eMfoB9YroP2hqrPYce6Z/pvZmKM32g8K
         pdfdauXCtBI19+WCreZ2GrV+lSYTagi0i0d9aoSGu/QMwFo8Dmr5a5p1sCchgX8KUu5D
         LHiQ1ZUSVGkpI6cY0o+CBe7r2P1Pk/P2ifvuMlaFDOxOQyXl9pCKR+k9ewX7xrej2mUz
         35EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790862653; x=1791467453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7oDFYsh9mnWtMPcaBpFSVg79NtIgY46+tkUCTRyhxGc=;
        b=vpUbUGL3UvOpkGnyi7rwYGNew8S93cx7Yr68Cc4rMxoWGj5O5FvF9oTAUcTZmEvA5D
         cI/wbRnOJ9IP2Q67OS30BtAbgW4NbEbDu3oCZ86yWDaSpbpWLCdl35XidLMbgJuH+8bx
         FBeEjEW/Lo24qwIPY/rTaKTHPT+tdwfgkUu0Axm0WDk68SZOtTrDRtEHEwjN9MuEWkvx
         jPL21Tfu9TXr+YL6prSxe/CPXJAAt9F78xfybfKqycOni6dD0zSlCDDr8BxZNenvWP4u
         hg3eHFmGWdDrrVvyupvn7IjqbNdlDhFduvc91N4woq4dQ4lniMLA4EhWkrfPVzQKLc3e
         DoZw==
X-Forwarded-Encrypted: i=1; AKwUvByHVX+I2Isl+AnApg5YfwEAgRivbzfLpLMy//y2WlWmsTG9uwnfAjgjnpqgbVU/KSiWvprrx0U=@vger.kernel.org
X-Gm-Message-State: AFuF++m7U44vem+3OesDv9mjzYc/F7YW8LBrWMMUI1yWeWy2YYpCnyaV
	focB1Vp7SSS1OzkWmrv7QWOwbzyWOema/gZrTgwdQB53+4lPFSo0qJO1SU0CirZZgl/GoJk1+DL
	Fhr+Hk2ENwUcUJVfNsrPU/LP/bwgJk+PFeuKhTvAFQjgCOnQlLlPjXxMjbw0=
X-Gm-Gg: AYBFou17A2EUnVrK6KfPVjkRnOB47R7xp+Rd6VxDG+ypA2/iyBXqvjL8IK7/+A3fWQE
	2K7IiWfTd5kIZB1KBGVtv+SEeSQbgYCDGgPEYN4Q+FES4dSQeso7pOzrtmzuaw8CPrLgvLWY9vq
	Wgeqrd53W1+zMjQGREtxRe4VLozGbBPfsHuc9/BmLIuViMgpG42oa/xJ7Nd2KRwVtLRKaYcAsqS
	VsBaPwlEXFpJ8O2UPoQPNANplnOc3UIXE+MOe1MUoM1KCJlZrn+YYlHhL2PPhXyr1X9cskxTzuv
	EoW62Xis6ik5lLKNiisE3xX9rY410gWIrECBnGVbZnVlyv2TLON7Qbetm274piAxZxYlwmOZ9qo
	Obz7FJgpfBRM+0g==
X-Received: by 2002:a05:620a:4482:b0:93c:9e87:de76 with SMTP id af79cd13be357-93cb59f3445mr540085685a.10.1790862652520;
        Thu, 01 Oct 2026 06:50:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4482:b0:93c:9e87:de76 with SMTP id af79cd13be357-93cb59f3445mr540078185a.10.1790862651829;
        Thu, 01 Oct 2026 06:50:51 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f922ac4sm68023315e9.6.2026.10.01.06.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:50:50 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 01 Oct 2026 15:50:20 +0200
Subject: [PATCH net-next v4 3/3] net: stmmac: add tc mqprio hw queue
 priority offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-stmmac-mqprio-prio-offload-v4-3-a74610d7f1e5@oss.qualcomm.com>
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
        Davide Caratti <dcaratti@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: zHDgraGE7Kj3cNJiUQ4akoZx3Ex5Wod7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1NSBTYWx0ZWRfX1/nYILlL2FKG
 xLpj/1ORk5jx9upOHzUAxQg8K+5cD8IG+WLIAuqJa9W/FA1VQY1eIAAF4xnuquUI49IjhhSzRj0
 o1hlHVxvREGHXqgdIP9xgGJoKhjLxoE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1NSBTYWx0ZWRfX8v6c08Uc3OuG
 lSIlYxowYdbfJ4r1LRW+iDTkYRyIhmlEa5sAmrhIdb3m44N8gC5Z0ytkP7YirmUFWvBbCFHZ24i
 aF3lOUtwZhm7dbspUnp/2nzwSyALJ3D/NKOzfXLCSoNUQoMMV9njQ37ugbZOAs+eZ+kuFI/gGdu
 n519DHToritOUH2e+3p2sbTPiOMlW6NPRIjnsU0b7azxTtlI8ax16E5AXtYsJHoQykk9LiUBC1n
 d3rQNRBfDmSFMtCDUDbpgTPwh2BmK7EyN/7xLhHj2Vt76tLgl5qyo/5Ra+M1l/bTeJweut9YhJK
 /6bW45hBT4b+bJLREbx55jP0HZOAEDgUWv7mRZP5AyA3CY6V8qgV9stz8qBUg2OW8Izo30ZoZLV
 ELa4SpxZsALpa4vf3YsQLBiDxpOjBKHB+4PZJfhaX6sHQ53fLn4gVpm9tk+BLB/v8JUIHnaunPZ
 IZLHQxVyOqDrZew/uvQ==
X-Proofpoint-GUID: zHDgraGE7Kj3cNJiUQ4akoZx3Ex5Wod7
X-Authority-Analysis: v=2.4 cv=WpC+otfv c=1 sm=1 tr=0 ts=6abe653d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=A-CAKDZ11f75D_VAelEA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010055

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
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  25 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 140 ++++++++++++++++++++--
 4 files changed, 148 insertions(+), 22 deletions(-)

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
index 1dc9218bd4e9..faf7e82d5cde 100644
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
@@ -7941,6 +7935,15 @@ static int __stmmac_dvr_probe(struct device *device,
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
index d0c3feb45789..e697e1c5bd6e 100644
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
@@ -1285,23 +1387,22 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
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
@@ -1310,6 +1411,22 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
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
@@ -1324,6 +1441,9 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 	if (err)
 		goto error_reset_num_tx_queues;
 
+	if (mode == TC_MQPRIO_MODE_CHANNEL)
+		tc_mqprio_config_queue_prio(priv, qopt);
+
 	priv->xmit_qdisc.num_tx_queues = num_tx_queues;
 	priv->xmit_qdisc.enabled = true;
 

-- 
2.55.0


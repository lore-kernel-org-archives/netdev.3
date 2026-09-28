Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0901D5146
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614180; cv=none; b=o5i13M/+Rw77efhBvr7RXLHNg3nCWQ5PFtpaC/BFJhJBQyhUm4XeJq8YRdcWSACsArgOADRWp24wK2G1jgaMRr6ZUjp0xMgXhnMXL9rfszT+DC1ssj1qovqf1KLnRh4PQb/FqW5THmTNYdDmjTy67sjCVpoVxt5UQoVS7aCSepM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614180; c=relaxed/simple;
	bh=lp3z1UbM4VpuAYmYlCTidcei3JQZmGnzyaM/bFu0JW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cBrLiy0101EFZtEQoMZTBoQiqTy+JjT/hj9qruUwrtrB87temwhe7M9760Yg8++JAy+g+Fc5xVPdss0XhV5MmCvg5QmXQqnhYQzkPURMbV58CNV8fOSV3TZI9wA/cT5UmiF2EVVnkuiXMI+kxqsH4DtkS3Rpwal6P6prsckcjkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kCOYE/Kz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kj/aA0DL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kCOYE/Kz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kj/aA0DL"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEdvlZ1895320
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oHKcEqme2xcoknVD7+KnaF778ZgT1c2/tD4kiWYN7M4=; b=kCOYE/KzLgDosKCO
	klrO/pqum7JBvK7opr4I/Ssw1J8XFJWZUtqcLxSauLRKUigXIpzPxepCZz2U7jYf
	VVoST/WsZQaGMHgtWKAa5icsaZ0IHnFfipia9p/bp0lR3uQ3nmqJDGZfyUURorcV
	CyryFsL3cAWs2E9Wo5aDXydqTYrBu8lxMq2pZTL22QoUfIBSYmU/frIX2POMMERy
	T/+Ueh0Zdyp89t7f+U9rqQ11B6UgUu80IC8z8rxye8TmEHEWRysu0voeDX8CU3wP
	E6Xb34GSMPe7qDedENBsUrNFB3zuRgAs8zu1WEWEqejO3bvJSILRErcMZRzik1PN
	ATg3lA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj2s2kcs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:49:38 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-988b5c59668so321225241.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790614177; x=1791218977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oHKcEqme2xcoknVD7+KnaF778ZgT1c2/tD4kiWYN7M4=;
        b=Kj/aA0DLWG5P8WLqM2MeTlqNbInPhVvXyTpT9SdtJR1YvK4HG5849diRVzE2uS3Nmr
         +Opl9Uyw2bcj0zaF5wCrX/zZQeHNDjNnJCkdNOFyLuMKNyh1REGJVFue70FPa4QW4TKY
         57weQQZJAef38gLWU0XHS8ytNLMUoa5Q3ubcgaOvucaOYof2w1XYMvKQsXFbBPT8o7o6
         dWl3vzzjobtX4rjp117DKNCbyamHcHfuhBRyViWdI4iTolWVUzODSLZF0x/hQKckThiL
         v/3SLOOwnodvxIj8IcYMEekSdiTYvMM0l3S2yBikEIk2lgrOX96ecX0BSPqev68xqs+o
         SnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790614177; x=1791218977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oHKcEqme2xcoknVD7+KnaF778ZgT1c2/tD4kiWYN7M4=;
        b=ObL3AE5WizRL0WxGsFSnZGbFffjBr9B3Xn1494J400rmfLwwntyIhgQwm2hKzdiFhu
         tGUdHzj2A2tti7EigEyzplSMyVQiYnfIapFjLkGdLngvCwT3NOUOxM8hTKkJtuGc5Khq
         wxfVwqDODHe7xOBrRoqTV1tVC0hZLHqw4UrccZ5UHhlZFJAc5/BXgF0APOR7oXgm712O
         gbyhTfn6TI38KrcPRgKMFVZMyIAvLxRFglpwpoiT2jqvnIO/KaMlWo2GY9ShsdhToh3K
         7atCYkc1HYsXXLys1vQy7i+zyOuZqvW2rxD5QEwUzZeFM/qBdB0tjz5qbcR4UTO6jl/N
         cNoQ==
X-Forwarded-Encrypted: i=1; AKwUvBznL3EMCC3TU4SfXtN41FU8zH+OUAWYDldg7HWdt//QNm5r9rHCBtW8jHXx9spp+BKOfOhj4sw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEf/YywAL4Ecq7Bd3tBzmeu3EfBkKBtDu4wLGfDrX5hSyH4afz
	8FEfBPb2/17Ry4z8nSoKJghZRJyBaZxqreFP9ElXK6NbpuHwBGdj6yxBE/FYzNd4xCDRHHfUnFT
	jNXaHlyWpbvZQkWudWnLWNGPh1YAhyU+/L2cUUVt1RFoybuzYx0pEDqPH5nY=
X-Gm-Gg: AYBFou2EQcQlajZ/EZr90RMLA4pIy44DCFOZvXvtJ9HCz+Qselw0di6FKM+Rik+Vxbj
	iefD5c3jnH7NrXacT128PfnJ2ELAzC+UZ5vGnGrLtdftB0PzC6ynq61w5KwMrJgkIuVEZsxwNus
	USR9O438LUMl2Mkd+vTgzykAWqkZwGTGDFZ2Nb6+785fuB73EZRWh6BpsjtR6BvBn6Jfs7wujjZ
	t7eeVvbybl2ehsoPg/YAO87fhCSN07XFNfbC/ZUiNEs4lVofnzrL9cb/e6n1IeiXlVbnP+gsYJ+
	60AGqEt1acEfE+T3taISnjZfCYaGCu7BkIv/Sb6+sYowmqdQhNCHx+BFcTxyyLoghCO+EJl3nFk
	iiA4qe4/rVPAVZw==
X-Received: by 2002:a05:6102:5121:b0:7b4:879c:bb8d with SMTP id ada2fe7eead31-7b4879cc104mr1638947137.37.1790614177245;
        Mon, 28 Sep 2026 09:49:37 -0700 (PDT)
X-Received: by 2002:a05:6102:5121:b0:7b4:879c:bb8d with SMTP id ada2fe7eead31-7b4879cc104mr1638300137.37.1790614137480;
        Mon, 28 Sep 2026 09:48:57 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a64f9bcsm28953976f8f.32.2026.09.28.09.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:48:56 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:48:14 +0200
Subject: [PATCH net-next v3 2/2] net: stmmac: align real_num_tx_queues to
 mqprio configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-stmmac-mqprio-prio-offload-v3-2-abbe181f5024@oss.qualcomm.com>
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
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NyBTYWx0ZWRfX6R/GKL43HvjV
 dYvdHkoOq2gMRh3G33Nt3TKQx+IZLNmlcAWxaZF1fwi1GudVJjzWI8DuFxyKNgs+AxObc52f60o
 sD959Jr2R78KwrZyDBhNZ3SoOn5vL7kkP2TjD7ewUCIUscwEBPVybiHfkHCW3NxLbf8s2pXMUW7
 5GEZT30yJVGmayn36toKsIyG0S4ybraq/yHTC9P5uIlw7Qtpu8Czywe8ZREPMTtzlEryko6f/6/
 mNO+fiTroq8q3nvJjCeQxf8l0kndamUw7lZmVdtaGSWwKlRG+3w9SJSWjvKPzzLK8T86orQqdmM
 dCThg0wp4GAEXym70ONNXZpC8nks4X+EJK/EUySihkTb63fBjSI+8DGiKJ0lLSj+H8Ir81iZD9e
 bE6CFiSgZrLupIi32Bdtik088EOdwe1l+XRdmV2BxLwvGmhQ0g/nGtbNkUtCXKJLLukBVGYfGRn
 JUtBkdylPgCh/PZ0PlA==
X-Proofpoint-ORIG-GUID: 0v4PWpLUL5amnj9wWBgzTxNL0iFlmm2n
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NyBTYWx0ZWRfX91UQ017516HA
 89p+BLB/bTXXBGQ59W7sWk7zxf7E+5siKmpmH9uNlm6sbW+007qOVQzkmzwO5aMKVgm0+5+IUXn
 kjNbNOrrUnXsSfiRL+zjqR+7fW+QmpU=
X-Proofpoint-GUID: 0v4PWpLUL5amnj9wWBgzTxNL0iFlmm2n
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6aba9aa2 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=dbvV_YUU-CEaD36rsUoA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280067

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

Fixes: 195e4f409a40 ("net: stmmac: support fp parameter of tc-mqprio")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 +++++++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   |  6 ++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index f1bdb65d0fe6..40eab899027b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -301,8 +301,10 @@ struct stmmac_priv {
 	struct stmmac_est *est;
 
 	struct {
+		bool enabled;
 		u32 prio[MTL_MAX_TX_QUEUES];
 		bool prio_offload;
+		u32 num_tx_queues;
 		u8 algo;
 	} xmit_qdisc;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 27e4e86e3c8b..1c25d1c129d4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3772,7 +3772,7 @@ static int stmmac_hw_setup(struct net_device *dev)
 
 	/* Configure real RX and TX queues */
 	netif_set_real_num_rx_queues(dev, priv->plat->rx_queues_to_use);
-	netif_set_real_num_tx_queues(dev, priv->plat->tx_queues_to_use);
+	netif_set_real_num_tx_queues(dev, priv->xmit_qdisc.num_tx_queues);
 
 	/* Start the ball rolling... */
 	stmmac_start_all_dma(priv);
@@ -7676,6 +7676,10 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
 	struct stmmac_priv *priv = netdev_priv(dev);
 	int ret = 0, i;
 
+	if (priv->xmit_qdisc.enabled &&
+	    tx_cnt < priv->xmit_qdisc.num_tx_queues)
+		return -EINVAL;
+
 	if (netif_running(dev))
 		stmmac_release(dev);
 
@@ -7683,6 +7687,9 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
 
 	priv->plat->rx_queues_to_use = rx_cnt;
 	priv->plat->tx_queues_to_use = tx_cnt;
+	if (!priv->xmit_qdisc.enabled)
+		priv->xmit_qdisc.num_tx_queues = tx_cnt;
+
 	if (!netif_is_rxfh_configured(dev))
 		for (i = 0; i < ARRAY_SIZE(priv->rss.table); i++)
 			priv->rss.table[i] = ethtool_rxfh_indir_default(i,
@@ -8003,6 +8010,9 @@ static int __stmmac_dvr_probe(struct device *device,
 	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			     NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
+	/* Default qdisc num_tx_queues */
+	priv->xmit_qdisc.num_tx_queues = priv->plat->tx_queues_to_use;
+
 	ret = stmmac_tc_init(priv, priv);
 	if (!ret) {
 		ndev->hw_features |= NETIF_F_HW_TC;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 07cf4582ed76..8bdc411e902f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1290,6 +1290,9 @@ static int stmmac_reset_tc_mqprio(struct net_device *ndev,
 		priv->xmit_qdisc.prio_offload = false;
 	}
 
+	priv->xmit_qdisc.num_tx_queues = priv->plat->tx_queues_to_use;
+	priv->xmit_qdisc.enabled = false;
+
 	netdev_reset_tc(ndev);
 	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
 
@@ -1438,6 +1441,9 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 	if (mode == TC_MQPRIO_MODE_CHANNEL)
 		tc_mqprio_config_queue_prio(priv, qopt);
 
+	priv->xmit_qdisc.num_tx_queues = num_tx_queues;
+	priv->xmit_qdisc.enabled = true;
+
 	return 0;
 
 error_reset_num_tx_queues:

-- 
2.55.0


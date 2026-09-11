Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C125469820
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117134; cv=none; b=X3bw1NrYCSWCkixJu+WMePtqPCMZWQvQHZ38GX0QQpCamITqz1t6hWzEJ1wKWL6wHB36FOwORyFSISY7tFew87Rkfaq4jfnGF49THSvm6UAbW7ZR7I3jyW0fbHCP3ruk1UWsSvYH6+mWxsWcVAlySxna5FJGycm8CURaSTCgNhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117134; c=relaxed/simple;
	bh=gSNd7n+u9NhBgz2YruBDJDFMzG9D4yqP4XNwV8wnc/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSoEu77WGmmkbPIMBMugs9hFdFmwdb0oH74Z0pi2X0dxTeiLpqr8bFVGdV5ZPF0FeyO6D75esl9Zwqvq5eTFLRSwD7LR9qYBZbKnIHAe/ugWZqg+Bis8qsbDWSyBi+TX2AvnSzCR/p3t89GmgMI5EX4qHcXaJ7kahR0GHW9YvcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bb9GhZk6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CB7MQ6tG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bb9GhZk6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CB7MQ6tG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7klZ23017007
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m3HjjQY/dE3cRcwJS8qtQGYaELgdNeUTwOrJbPhHwVo=; b=bb9GhZk6v5YdCdz0
	z9I3/NWv4IgzM4Qpy6UCFTE4kdcmNjP7JesW1i0Uws6npYyc9T2B5GEmzgyTtkU7
	5CgFuqnXdaawrCcix6Fm9uL4YPLq3truxMDNbrW+yb4Yni5rLVGsdhAQQbir9DtP
	ZcWeVP8+QmSzcqMdEgnkXN/f2llVSsBPgjys+L4ZdOG8zapc6X83ebkM5nzU/ZP0
	IR4mifLM/+UHZasbWLx4ZTEjb9MzK3urTeBQYKI0IeDLqrOiN1HzfRz7pzzheEzt
	bQTPCV4/OVOYPey/ztl4SWpcuhTjLZ0qHR4alOGog2r8etypiaeCG6UuyFHfBeKc
	+pCVMA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwvx4bfh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:58:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9382f9430deso117770085a.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 01:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789117131; x=1789721931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m3HjjQY/dE3cRcwJS8qtQGYaELgdNeUTwOrJbPhHwVo=;
        b=CB7MQ6tG+0hRjUw21WbBamXX9vbPb04ShGGMZ+BBdlKbYK3StHjjEWfrZUCne100hu
         7aZt/QjKEsRuXo3VDIxHMT0KzGcFcmUbPxqM20nk5RA0Yagj44LFaRojyKFQcg4AMJuv
         AmstWaZo4zzryE+JxJ2AG9tAMuz9HnGw6qOWC2RJupNvRHZqwRpTstnY/zDgDE6Tp6WV
         2BHSPrNJA3uFqazH5al6V22vkrqOOpV2tCyoXSbhAy3Ny2tJuaH7RtQX1qtN9SruTXyc
         UX3n62ZcGII97VVYuoqT9TDkQcRzcbYFUGGgYayRZCbARtSqiDCRfZOW59RjyMuoxPsA
         oY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117131; x=1789721931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m3HjjQY/dE3cRcwJS8qtQGYaELgdNeUTwOrJbPhHwVo=;
        b=YMmx5gmUtDl1M6W5LhD6UCEWlLpelMJvnhiGJb6GgVGo22UeotW/4mTEKJpXdKr4rE
         bE8/oftRPDkCcKzEQpyi0Nq+fZIyFue2ySUu3NagqlNWWTPBJm8k3sdqMovtqRn0CepL
         CVKCKxhljUpJxP3fnlfizVEkyrp4BIkN2zQjzkP8aj0yhOC+GlmjEcHw88SpQGk91LXE
         FKZ8mYYOE8d+qJ4HsDEHllhuvjdi0Dm778jki4uc2MnxIz5MYujCBisVZiV5D1uoZGKW
         0tobeWkqz6Qgfks6SHw37gelJ2KIHgTSZTyoy2S8v1QAHHS91MenbnTFtpwkWZSURZkS
         pq/A==
X-Gm-Message-State: AFuF++lKFfFoCcfI7zJ2UjhW+MF/jzr246EEfrZZPt+tk1pXik2LW3oS
	ZVVT0nQW12fFA0uedQm6U2MoCUaMbBCsuIqFDYg1aIJgcZ8PWaxwVG0otUtxpIn2DEfpUQTSoQW
	NpWj7SNWat5eqThMBvqmhISpni/kcy5N8BwHEMs9ausFxS8lYl0bt4EKEwIg=
X-Gm-Gg: AYBFou3kXfU1aeb+QCiG0B7rx8ou9Wb9QNptGc7XNQ7v928w8HUM2ClzzqM20sabcwi
	niNVWx48qbI1c9KHzFYA/vtEyzR71bJWW9uTn8bugKuB+o3X4zciHCT0fC2PnxymX7KkBFQfgFN
	iwruboO/BOPBrn+VvmWm/iLXjaD+w1WJgfYk7K0lMVYSkwWArwfDu9Tb81z6L24dg/aCvTXyte2
	bQ0wJBFRf9f1vwOdgk634nRE+SUn3aqE2p6OAEKMzHwjJCSd/H+cCOAy1a0LnfSvtpKXLFTJrki
	nf6XAmzNdL2MZgi3wBacLtdFDSKtujfB02/YxzCYDk+qszw11iFtthUYIGolIafikVoiWXlWMGE
	Or8wTmIkkxSmf8A==
X-Received: by 2002:a05:620a:1995:b0:939:d91f:1656 with SMTP id af79cd13be357-939ea0e6b22mr384945785a.23.1789117131139;
        Fri, 11 Sep 2026 01:58:51 -0700 (PDT)
X-Received: by 2002:a05:620a:1995:b0:939:d91f:1656 with SMTP id af79cd13be357-939ea0e6b22mr384942085a.23.1789117130679;
        Fri, 11 Sep 2026 01:58:50 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e5765152asm91148055e9.11.2026.09.11.01.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 01:58:49 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 10:58:30 +0200
Subject: [PATCH net v3 2/2] net: stmmac: preserve real_num_tx_queues on
 mqprio setup failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-stmmac-tc_setup_dwmac510_mqprio-error-path-v3-2-a76b1e2547c1@oss.qualcomm.com>
References: <20260911-stmmac-tc_setup_dwmac510_mqprio-error-path-v3-0-a76b1e2547c1@oss.qualcomm.com>
In-Reply-To: <20260911-stmmac-tc_setup_dwmac510_mqprio-error-path-v3-0-a76b1e2547c1@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Furong Xu <0x1207@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDEyMyBTYWx0ZWRfX1VVk5vLVl0De
 B9S7ENPdv3n4sGOa+oO5uB/ABEjPrZJrdEgfWpQNt03Pz4Asdpm3nXUtPZ4D8RT7CKyqwILyXE3
 doXSSswtyk2XOf8wgnUyYE1V2UTa1UqWqEVDgMFxdX9mCmWVO2N/MIaJ7tu74w72IfwaurcMJXS
 b5wM5N++ntiDYanpNhCIbyIfuViMnE2oDCXK4HMDfGXFXmPKOQs+TFjoSK0g5gfHCSgc4GcCptU
 x8OMmV9MrL/bUtS9TnT19OSoUbhGARp0rNNCgW4V8ACpmGHT3R5ZZstmPQA0/SlOxIRN/7u2o8M
 UXiJxUl5vREhwgmnkHHzWz9+YZ5Llc6ArvvtXBug+F+ymtCrJVOFNuLqTAal0WqBknplanud3Mz
 iNRmQ1idGF0s5Faul2XMtNtW8R7BSw0TvABVWpVL+aYT3PdgQVSxApxQiFT7chNh7uH3R1j8q1m
 Yfx+kQeQRl6zEVbA0kw==
X-Proofpoint-ORIG-GUID: G-nO24WK6eqx1G9iZWRp7eXP-yTF9RKW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDEyMyBTYWx0ZWRfXwHvlUSl6R3dD
 dQBBZPLkkXBQdklMAch+rWHWsZRvFlLSYUIfCDZEAOqxVrdkppMlIKwxp1SQfQPERlCuaeq5So6
 Q3mKQR8W41hutOiAV+xulQV3+jiSafQ=
X-Authority-Analysis: v=2.4 cv=AdkkjHXG c=1 sm=1 tr=0 ts=6aa3c2cc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=0NSVpFHRlRhN2sU1BpMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: G-nO24WK6eqx1G9iZWRp7eXP-yTF9RKW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110123

With the FPE preemption-class mapping error now propagated from
stmmac_fpe_map_preemption_class(), tc_setup_dwmac510_mqprio() can fail
on the mapping step. The error path used to call stmmac_reset_tc_mqprio(),
which resets the number of real TX queues to priv->plat->tx_queues_to_use
(the platform maximum), overwriting the value that was active before the
offload was attempted (for example a lower count left over from a previous
mqprio configuration).

The issue can be triggered using the following configuration:

  # First mqprio config lowers the hw queue count below the platform
  # default (e.g. 8 TX queues).
  $tc qdisc add dev eth0 root handle 1: mqprio queues 2@0 2@2

  # Replace mqprio configuration with a second one that fails FPE
  # preemption-class mapping. stmmac driver resets the real_num_tx_queues
  # to the platform maximum, losing the previous configuration.
  $tc qdisc replace dev eth0 root handle 2: mqprio queues 2@0 2@2 fp E P

Save ndev->real_num_tx_queues before lowering it and restore it,
together with the TC-to-queue and priority-to-TC mappings, when the FPE
preemption-class mapping fails, instead of resetting the queue count to
the platform maximum.

Note that a failed setup makes the qdisc layer run mqprio_destroy() on
the new qdisc. Because priv->hw_offload is only assigned after
ndo_setup_tc() succeeds, mqprio_destroy() calls netdev_set_num_tc(dev, 0),
so dev->num_tc ends up 0 regardless of the driver-side restore and the
previous qdisc is not reactivated. The restore is still needed to keep
real_num_tx_queues and to avoid leaving the failed configuration's
TC-to-queue and priority-to-TC mappings in place.

Fixes: 195e4f409a40 ("net: stmmac: support fp parameter of tc-mqprio")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 82 +++++++++++++++++++------
 1 file changed, 62 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 5398616fcdfe..42a00446e9b4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1237,6 +1237,30 @@ static int tc_query_caps(struct stmmac_priv *priv,
 	}
 }
 
+static int stmmac_set_ndev_tcs(struct net_device *ndev, u8 ntc,
+			       struct netdev_tc_txq *tc_to_txq)
+{
+	int i, err;
+
+	netdev_reset_tc(ndev);
+	if (!ntc)
+		return 0;
+
+	err = netdev_set_num_tc(ndev, ntc);
+	if (err)
+		return err;
+
+	for (i = 0; i < ntc; i++) {
+		u16 count, offset;
+
+		count = tc_to_txq[i].count;
+		offset = tc_to_txq[i].offset;
+		netdev_set_tc_queue(ndev, i, count, offset);
+	}
+
+	return 0;
+}
+
 static int stmmac_reset_tc_mqprio(struct net_device *ndev,
 				  struct netlink_ext_ack *extack)
 {
@@ -1251,43 +1275,61 @@ static int stmmac_reset_tc_mqprio(struct net_device *ndev,
 static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 				    struct tc_mqprio_qopt_offload *mqprio)
 {
+	unsigned int ndev_num_tx_queues, num_tx_queues = 0;
+	struct netdev_tc_txq ndev_tc_to_txq[TC_MAX_QUEUE];
+	struct netdev_tc_txq tc_to_txq[TC_MAX_QUEUE] = {};
 	struct netlink_ext_ack *extack = mqprio->extack;
 	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
-	u32 offset, count, num_stack_tx_queues = 0;
 	struct net_device *ndev = priv->dev;
-	u32 num_tc = qopt->num_tc;
-	int err;
+	u8 ndev_prio_tc_map[TC_BITMASK + 1];
+	int i, err, ndev_ntc;
 
-	if (!num_tc)
+	if (!qopt->num_tc)
 		return stmmac_reset_tc_mqprio(ndev, extack);
 
-	err = netdev_set_num_tc(ndev, num_tc);
-	if (err)
-		return err;
-
-	for (u32 tc = 0; tc < num_tc; tc++) {
-		offset = qopt->offset[tc];
-		count = qopt->count[tc];
-		num_stack_tx_queues += count;
+	if (qopt->num_tc > ARRAY_SIZE(tc_to_txq))
+		return -EINVAL;
 
-		err = netdev_set_tc_queue(ndev, tc, count, offset);
-		if (err)
-			goto err_reset_tc;
+	/* save current tc values for reset */
+	ndev_ntc = netdev_get_num_tc(ndev);
+	for (i = 0; i < ARRAY_SIZE(ndev->tc_to_txq); i++)
+		ndev_tc_to_txq[i].combined =
+			READ_ONCE(ndev->tc_to_txq[i].combined);
+	for (i = 0; i < ARRAY_SIZE(ndev_prio_tc_map); i++)
+		ndev_prio_tc_map[i] = READ_ONCE(ndev->prio_tc_map[i]);
+
+	for (i = 0; i < qopt->num_tc; i++) {
+		tc_to_txq[i] = (struct netdev_tc_txq) {
+			.count = qopt->count[i],
+			.offset = qopt->offset[i],
+		};
+		num_tx_queues += qopt->count[i];
 	}
 
-	err = netif_set_real_num_tx_queues(ndev, num_stack_tx_queues);
+	err = stmmac_set_ndev_tcs(ndev, qopt->num_tc, tc_to_txq);
+	if (err)
+		goto error_reset_tc;
+
+	ndev_num_tx_queues = ndev->real_num_tx_queues;
+	err = netif_set_real_num_tx_queues(ndev, num_tx_queues);
 	if (err)
-		goto err_reset_tc;
+		goto error_reset_tc;
 
 	err = stmmac_fpe_map_preemption_class(priv, ndev, extack,
 					      mqprio->preemptible_tcs);
 	if (err)
-		goto err_reset_tc;
+		goto error_reset_num_tx_queues;
 
 	return 0;
 
-err_reset_tc:
-	stmmac_reset_tc_mqprio(ndev, extack);
+error_reset_num_tx_queues:
+	if (netif_set_real_num_tx_queues(ndev, ndev_num_tx_queues))
+		netdev_warn(ndev, "Failed to restore %u TX queues\n",
+			    ndev_num_tx_queues);
+error_reset_tc:
+	stmmac_set_ndev_tcs(ndev, ndev_ntc, ndev_tc_to_txq);
+	for (i = 0; i < ARRAY_SIZE(ndev_prio_tc_map); i++)
+		netdev_set_prio_tc_map(ndev, i, ndev_prio_tc_map[i]);
 
 	return err;
 }

-- 
2.55.0


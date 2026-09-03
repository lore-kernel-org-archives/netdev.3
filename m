Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3B645DF58
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426558; cv=none; b=NPwlm++Vd4GoMEY6gDV5hzoPIhf3TWLvXJ8mBETpXzzzsBIPpXcDkl0rm50WvjfpPNizaITcVoqHpVtrGzOe5PUQbAqMNZWcueDhZyZP7z45jFSuUbpGnV9zAf24mggxlcyuWzPwBVWBqO7cHK5pivwxo/khm54pNrdIc9f3Fqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426558; c=relaxed/simple;
	bh=IzIe2onD9pmr7wZemYI6FFDtj4e2XA89rPmJIh0jRkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qBrbXIRRHzWyWDcyznIHyCswX83Yr+WJXyAfW7ZB25gIx9FrC5Lmde+ogAA1S+MSNu+pbntGV0RmYGnwsQi1tkVsUNw4427vlgOtG6utmwYG3tbMn1blC/r9xs8VT+2jbhu0kNi7OL/e5tmWFme3uHuOSOI3wDz4klkVv1uo2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UfBn7RhR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TpmgmNao; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UfBn7RhR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TpmgmNao"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683923JO3549390
	for <netdev@vger.kernel.org>; Thu, 3 Sep 2026 09:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Nm0b3decWts16dJvCGu7/4
	gLHqIVSBuSg/h+YMAas2c=; b=UfBn7RhRJtjrWytUbJFGvf0MsF64YrLjo4VdZu
	CeXHuCjaSF/+Di10p8rnF0vghqCBzeyX0MF7cJgyC3Hw9sbp0YYB0sZTc1kL5g0m
	uhRMKuvCGQ3XSYzkPZLP+/WUv23evKLfy6mmoHxNKL1NoabKO4mpwJXO4dg6ZPgU
	1bIp73cyI7IIq74FObcFWDKTrPjr+BEKJ5B/HNJA1r28B4QlKjKspY/5pH2NBnsA
	cVZA0JE6EexEVSgstmTjaynORI+Hiqi0WlcE+O19cA2zjLsQ2napq0ftnuU5LNrD
	RiegAhoRB72knvTSH5lnrJgCOJV+T1g+MUfB/x0njSo7c2ww==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf0gjsauj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 09:09:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-939281526e1so113263585a.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 02:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788426555; x=1789031355; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nm0b3decWts16dJvCGu7/4gLHqIVSBuSg/h+YMAas2c=;
        b=TpmgmNaoWlDl2UWCUd3PyBRX5j93pshzeQiPcMlZiaDdndFS6ShPBWEgbVKpKevGh/
         gnQKmqioAoUZFDNWO12o5GuEh0DsdXcLiSjaWYHKBlidWo0j6vUD19u923iKV9+wueZQ
         BYnmRP7j7YEReblumjtskwGT5ROw1z0f5aALcwnnPNGjYpUILXsye/XraNhzJrTkVah1
         zaftV40dynxYNnqHuxQWNmuqD24iuWAaj+0LyLzc857DzbJ8Geobr8qYMjP+lgk+/+sQ
         /2OGsVsC7SepJJgHE0fwcCALZMiRZyBiCqWnSsRXKaZADosjgC9ZlYzdGKdMC40Z+y9p
         fx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788426555; x=1789031355;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Nm0b3decWts16dJvCGu7/4gLHqIVSBuSg/h+YMAas2c=;
        b=qt9LQ1EnU8/gj/fJkQzWUEX7Etrddh/oze22XbpzNRWIFgTFCxpJQGPBADb6yJVS+F
         mfeZorZxVDPxoYoQ/6/4CajqRy0pVOGBSQFK+ENTDOwpYMC/JEZ36XQCPHfOrw/p+Wwo
         akqubGJ9Lsrv3vKwDQxFcGzAKgleNtoYHMj0s/dXvurAA6FhAt2K9Pe86cgxh4SgZE6e
         FrMISkK12qZiRydLSGe+s23HtarceEnwckULWIs1FqB40wd8zGGiDpUuUsc7Drl9Z6j2
         SQoA6wGlHGlY13tUs4niYXXdbEa8Fb2uGLmBwq3xue2oHu9BjE3lOjCCYUnB9HDjQAYw
         EN6g==
X-Gm-Message-State: AFuF++l1z0kzG00VY/OWP3t96qwKXRZ0+46inP7KkqqbFylmxjlljOqo
	lGbV2lRRcAZr2V/ACWN0NONCtmr6vDmJixce0im33LNyGuBSK+OoEbK9LY822t5smVnpTrK3o7S
	8SQu2BFMC3qdMugnfHnZwI4/sP3H+9UZxVUpTphDU9tbKyeu9F4NVUHRYGTenRau2LVc=
X-Gm-Gg: AYBFou1r8oHdjgqf5DaPU2sUpqTNSGRYz7SZCVpH9o6r9xW4CqH3pQSA5ChvCl6cQbG
	Yzs1DNDNnzcDH+SpXewFskH/KuoUjxtE4ch9RWSjg/pJZ3NdWY50+bnlwQ/qDGb+MRk8OHZ8LaC
	m4ucGyQ8fXC8r6qycgK4hokSAP9NrVV9f2cqd1wTqdGKcCZbfSlbGACaAeZ2+RlaTq56T8MNlUk
	CXFyKoa5bivNNjB3B0iaqlG53Zm/JHaq84JsWg9mkKBPQLZSLxt/t08qRoF9eiuxHX7RV5kHZO7
	l2+tJPXYj2c7RbBTcam2uQkMrgveyGHrIwe5gqEuMnHCrSWJ/eNNzxv+mwgn+uAW8IHMf7lnq/h
	NgyruF2j9yLtVRQ==
X-Received: by 2002:ae9:e707:0:b0:939:6df7:73f1 with SMTP id af79cd13be357-9396df775admr458433185a.51.1788426555139;
        Thu, 03 Sep 2026 02:09:15 -0700 (PDT)
X-Received: by 2002:ae9:e707:0:b0:939:6df7:73f1 with SMTP id af79cd13be357-9396df775admr458426985a.51.1788426554489;
        Thu, 03 Sep 2026 02:09:14 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e72d2asm11700770f8f.8.2026.09.03.02.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:09:13 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 11:08:42 +0200
Subject: [PATCH net] net: stmmac: preserve real_num_tx_queues on mqprio
 setup failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-stmmac-tc_setup_dwmac510_mqprio-error-path-v1-1-eb171bdd340a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NSQ7DIAxA0atEXtcSgXS8SlQhBE7jBUMNHaQod
 y/q8m3+36CSMFW4DRsIvblyTh3jYQC/uvQg5NANWumTuiqDtcXoPDZvK7VXseHTeRyVjc8inJF
 EsmBxbcVLmM7aTSaYRUMPFqGFv//ZDIka3Pf9B6jLUIGBAAAA
X-Change-ID: 20260903-stmmac-tc_setup_dwmac510_mqprio-error-path-8d472a43d3f2
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA3NyBTYWx0ZWRfX4tdZu2RxZHDK
 sTOFzggZblH3zYBWGzhsu03R+6vtuxIU37RHYA5KRFGnLVlXhsMP7NK6eS9aUY1ylouKJdLP6EH
 9jHL9VhJCo3nEOOx3R6IbzHA9a1j1w2U2xsR5lWGBU8xoyGObi5jj5mPI1DLgVIFmxmYVMsSknu
 Rrm4LNQPp9EXIVpQgNyQ/WLFCUu2cuTYGM77Ry5syl7dik6TOjjhPsMUHyiAS3s4Gb1FDceEoWe
 65DkxW8Q+sMmC7NDM9si4TWFj1rIuTMKynBTSH3KgPFvN2n6afdN97AVEp6+VRo7DTM+YOW8+Y+
 Vq/P6lLcSPzVBsouU03uXnMQV95+ZHirSbpDL2EjrgWDVUIBuDR9oIEgfJ4gdoanBcQQFfNNhcA
 Bf7XmsLOSjBlfbl9FO9y9ohLD3PmFe7uh6EB1ZBptP6YmIUf2/2w6VGhxcrgVV2tN1CMdiSiQYE
 DV1kKRfmW5dUnP4HPJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA3NyBTYWx0ZWRfXwRF/u0LC2eZJ
 Bx8R8J+JGSfNekOEwwvgYtrz16KqZSPkakrNCixrvhhXKQSHYvuUoMNXPv5UHn9TROYBTyRONU0
 0wwjvl9bpmKAeZ2gJ1f8QiKv+snEwIo=
X-Proofpoint-GUID: gVLBD-v6_mcnccH1jidjd84q3I35BuTV
X-Proofpoint-ORIG-GUID: gVLBD-v6_mcnccH1jidjd84q3I35BuTV
X-Authority-Analysis: v=2.4 cv=LZ4MLDfi c=1 sm=1 tr=0 ts=6a99393c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=0Ze0suNwVZWZK1odzWoA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030077

In tc_setup_dwmac510_mqprio(), if stmmac_fpe_map_preemption_class()
fails after the number of real TX queues has been set to
num_tx_queues, the error path calls stmmac_reset_tc_mqprio(), which resets
the number of real TX queues to priv->plat->tx_queues_to_use
(the maximum the platform supports).
This overwrites the value that was active before the mqprio offload was
attempted, which may have been lower than the platform maximum (for
example after a previous mqprio configuration reduced the queue count).

Save ndev->real_num_tx_queues before lowering it and restore it if the
FPE preemption-class mapping fails. Drop the use of
stmmac_reset_tc_mqprio() from the error path: the queue count is now
preserved and the TC-to-queue and priority-to-TC mappings are restored
to the previously saved values.
Introduce stmmac_set_ndev_tcs utility routine.

Fixes: 195e4f409a40 ("net: stmmac: support fp parameter of tc-mqprio")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h      |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 80 ++++++++++++++++++-------
 2 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 04dafec021b4..9314bcb85c22 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -494,7 +494,7 @@ struct stmmac_ops {
 #define stmmac_set_arp_offload(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, set_arp_offload, __args)
 #define stmmac_fpe_map_preemption_class(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, fpe_map_preemption_class, __args)
+	stmmac_do_callback(__priv, mac, fpe_map_preemption_class, __args)
 
 /* PTP and HW Timer helpers */
 struct stmmac_hwtimestamp {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 14cabe76e53e..c99d9b7e26dc 100644
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
 static void stmmac_reset_tc_mqprio(struct net_device *ndev,
 				   struct netlink_ext_ack *extack)
 {
@@ -1250,45 +1274,61 @@ static void stmmac_reset_tc_mqprio(struct net_device *ndev,
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
 
-	if (!num_tc) {
+	if (!qopt->num_tc) {
 		stmmac_reset_tc_mqprio(ndev, extack);
 		return 0;
 	}
 
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
+	netif_set_real_num_tx_queues(ndev, ndev_num_tx_queues);
+error_reset_tc:
+	stmmac_set_ndev_tcs(ndev, ndev_ntc, ndev_tc_to_txq);
+	for (i = 0; i < ARRAY_SIZE(ndev_prio_tc_map); i++)
+		netdev_set_prio_tc_map(ndev, i, ndev_prio_tc_map[i]);
 
 	return err;
 }

---
base-commit: 2f38e26a5741abdf152c1b56b22144a06d30fd66
change-id: 20260903-stmmac-tc_setup_dwmac510_mqprio-error-path-8d472a43d3f2

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>


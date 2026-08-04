Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5551C30B51E
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867493; cv=none; b=IAH+HpLr/6UxFN+fyJeml4L1wxwTIXvSQYbQh08l9GLAIp/6oJv6TlsqqW5yzeeMtD4/uafkrYt5v4VcBRZxQFuWxdRrDJdmMBpBYiTw7nD/pGXWLl9ko1bppHPee7s6EeP2ObITrKIbOqavWgRtnbnsT2WntqbZBobPAOgqyQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867493; c=relaxed/simple;
	bh=rQO/ku7rhJNWWciyJsMvLSoIqI31m9XLEOWcUdgRZfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B+8c3UN9MI8UduEVrYAR+HuqscTjIixRjprP9bR13NXDpTDI1UjZzX50rm9ZdSF+38uZ33Jam9VznwzJD3thufY0twB58zn5HId24z+2WW7rXMkI0uFkwi+Js1c8CeXQZURepvNpqdJhmkAWjFtX3wL25z6wNVZtppLysQsvDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pSsd4KLi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PniQeLoN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pSsd4KLi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PniQeLoN"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674G5BI44072256
	for <netdev@vger.kernel.org>; Tue, 4 Aug 2026 18:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QR9ClPuBMuHzwg6AqtRW2N
	xHD7YJh16VACOa8a1PgRc=; b=pSsd4KLiwt4RvnFgf0/q4JxacmupQzzv+PwYEG
	2uISJtni6NcGSu68UEX/B8DuiHGwvDRFuf/Ah0Ol/zK6H1Ei+UqbIxmfjO/+MbTm
	eLavw6L9V0SHgTqgRC6REEVGS7XpNvpUNzt9J3XtPCCa2BJdBou2V0fon/BkBKzF
	uZDUUYEXiphyXRVz7p1p+q3BORQuh+aA0nftm5J6pR+i0N0g4AX+0pqJx330KOlL
	uYSkDkPcFCOQ9WAoUFCk5XnYTjahs+hx+EfH8NI23d5ixStAyDzRMn7Rytb++Mn1
	v9TZ6WGgMHt+LbfqycvSllOiywLoQRaq5XLcT+tZq0Br2Z+Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fuk9u0mqj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 18:18:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c20762d21so959481cf.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 11:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785867489; x=1786472289; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QR9ClPuBMuHzwg6AqtRW2NxHD7YJh16VACOa8a1PgRc=;
        b=PniQeLoN6W8qsTBhGELuSak2NNVjm55zYoimj/ZKKBq8V8bEua2V/qGGI6nc9XT+9H
         2CWBJGgHB4du+6aj1ewMCamHXRPsPxZwlG68OKRYesri7gd5k8tYmBZLo1NB+T+69xRH
         ymFdauRfyIYzzsG1OkBGi/gXJy4knjxc1DMRSjl5eHbt/AEIUBbThyZV16C4WOxJjY2m
         qPUtxlWLs41VJbt1cUJqisnSQEvSOL+3uFgtARwhZpBQIjqCCvosCEqwy20lZd30Q1VS
         kplfl+YK6+iQNyGYahMwONyfL55HXpp4PEVQQ+2q/Ssuw1Pv5c63opWS7map4EsWSdRn
         WJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785867489; x=1786472289;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QR9ClPuBMuHzwg6AqtRW2NxHD7YJh16VACOa8a1PgRc=;
        b=QujYA/Jnj4Qw/E4hnvQruW5pk3zEGIpycAjt94Oog8t7ua17JZK3IRxXiBoixgDd1R
         LLoNu1DUiFaqv2JnJZ1KRYfyFUrxMGX022O2oZcxRvaSdn2Hbz+NsPeO1/LHhZT6mtvo
         e334QBcHFmnD3xA456JX0hpVioaLbjV7OHgC+TwhERi7wDTAoXphBsoM2rPXlrCY3Y1U
         jsOduhZrS0updTnXdToNJDVUl+DSYFlY+neS/3mi1eitp8rsoSDrKx1QEesyzRlMfH0C
         z63g0ZOS1EWiKPQCI73SgE5cekk1TxGwXYABD9VZ3Afdm/zxiYipq3q2C7YD+uk+8CxC
         tQCw==
X-Forwarded-Encrypted: i=1; AHgh+RrSGUfsrCYxz1pqwdOPNfjOzlB6qUdJnf/hFPzzeYCN6FeBkoFn8MEZFTDjO6r0LeiQFA6fpGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN4uObvQzrNEpf0IA7nTXvadCi9GgODo9vdGo7RvmZjcHjCbgT
	oS175v4HgOWwLZe+9Nzt/T7TTJi0VODd5ee0kix/VjGbG9PihCmPc3cBTUv6sylkCrNqQDBcv1E
	JKzn/WR1iTTHPFEiVrn/HxxwUkEl28ox/gu1odRAzy9ng53IH9T7GSFbYbic=
X-Gm-Gg: AR+sD13THADccyzJ/RLtVwpxUiz3WM40rb8pOfrvtAeDO9vAVtnU1IjXAP68Eguss0s
	Bgn9OblbtcgMmEzfQLrkx7OZzXfzDl6t8w50ZfCHwk9X7XPMhj3qO8P7fjudx/N2ZQtF0d89ffS
	ACbLArVZKBNrE+NpYHxifFjm4YCMAVFkmtXZt9yqC5C0ukQAjDZVuK8zqNHioLlAlyOYwAwKV3S
	/Hg0WUbGQXd07MDVsCyS1xlO9lbEuzSEIa/t8pcod5fR1wI664We23REJK6f5KuXX0RBg2vinb2
	wfLCX3YO2InFpFKsRI6j7V0Dt5vzK7FGZ+m5BASYnZpHM/btvfUFLpcDPANjbFVjBOlHS76Fj1U
	6FaNgIJVF2xSNF0U=
X-Received: by 2002:a05:622a:4818:b0:51c:164b:b241 with SMTP id d75a77b69052e-52ce5f71ee3mr12899231cf.13.1785867489243;
        Tue, 04 Aug 2026 11:18:09 -0700 (PDT)
X-Received: by 2002:a05:622a:4818:b0:51c:164b:b241 with SMTP id d75a77b69052e-52ce5f71ee3mr12898491cf.13.1785867488722;
        Tue, 04 Aug 2026 11:18:08 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7bf4sm109490455e9.11.2026.08.04.11.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:18:07 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 04 Aug 2026 20:17:35 +0200
Subject: [PATCH net-next] net: stmmac: add tc-ets qdisc offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-stmmac-ets-offload-v1-1-f3a09169d22b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBA0avIrB2IVqTpVYqLdDKxAzUpmSAB8
 e4Gl2/x/wHKWVjh1R2QeReVFBuGvgP6urgyim+G0YyzeZoJtWybI+SimEL4JeeRyD5msjb4zwA
 t/GcOUu/pGyIXjFwLLOd5AdpkLNFuAAAA
X-Change-ID: 20260804-stmmac-ets-offload-cc936c99fdb1
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Daniel Thompson <daniel@riscstar.com>, Alex Elder <elder@riscstar.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=NInlPU6g c=1 sm=1 tr=0 ts=6a722ce3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=zDO8lxRZ4TI0GpO-95QA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: _0hFL_Ranwn5pJC-LeSj90qsDr9cnMIW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0OCBTYWx0ZWRfX2OBHWkEAaLQh
 oVVolfJPAc6+D0ZpH+Vq8ZE/3Gs3+Xt+r6yR2tZKW1YS96sx80Jk4zrgIGm03eFVSqfp9WaeMfi
 UZ0UftWsm3uzxa5GYAQlk1RIYrkCfhc=
X-Proofpoint-ORIG-GUID: _0hFL_Ranwn5pJC-LeSj90qsDr9cnMIW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0OCBTYWx0ZWRfX1mfysoRadgW4
 ZKL+90pd0bRB3pwnX1/gARidwmSgKvq/CJjOpXppkcTQrgMaYuaJvvvaEq0zQ6pDdrwdFJ69RJx
 TrQy8y75o041NClFjFrQ/77tfhgk9RqyCu+53OE+/02ebN+vzEYLiVsmbhPD+ST75E7blA549pU
 Gabnez1W5tTU7J/f4SgllcMArhSEpvLUCj0N+x7aQTEcivYLelhE1AiBVNGNanb/KcWLEjym24A
 CWDYnkHxrIt3h7lr9NG3bQ/IynYhqNnaNrGt1QbCvkvCKhTdRcd7APaXGBtQGqhhQNEIovpJXfk
 2Wyk0Nn2vhffpZVkKm00scjdUVYQedO/6UO1uyeIyOq8k8ZVTxFoQaT8hzsgH9xEbgEn1KdutuY
 SXzkEl2ZXuvG4Z5yZl60mjkvXUC2PJMEqzV8/quzPbzytCo5HtBnorxZkyl0aePiCAhwI4R4Zf/
 L0LCbWCEZ9bqyzRILgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1011 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040148

Implement offload of the tc-ets qdisc in the stmmac driver. The number
of ETS bands cannot exceed the number of TX queues, and mixing strict
priority bands (zero quanta) with weighted bands is rejected.

When all bands are strict priority, the MTL scheduler is programmed with
SP scheduling; otherwise the requested weights are applied to the TX
queues and the scheduler is switched to DWRR. The TC_ETS_STATS command
is accepted and handled.

Export stmmac_set_tx_queue_weight() so the ETS path can reprogram queue
weights, and wire TC_SETUP_QDISC_ETS into stmmac_setup_tc().

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h        |  4 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 69 +++++++++++++++++++++++
 4 files changed, 77 insertions(+), 1 deletion(-)

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
index 8ba8f03e1ce0..8ea6dd0c1697 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -394,6 +394,7 @@ enum stmmac_state {
 
 extern const struct dev_pm_ops stmmac_simple_pm_ops;
 
+void stmmac_set_tx_queue_weight(struct stmmac_priv *priv);
 int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 79b71466d5b0..404f4132f223 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3419,7 +3419,7 @@ static void stmmac_set_rings_length(struct stmmac_priv *priv)
  *  @priv: driver private structure
  *  Description: It is used for setting TX queues weight
  */
-static void stmmac_set_tx_queue_weight(struct stmmac_priv *priv)
+void stmmac_set_tx_queue_weight(struct stmmac_priv *priv)
 {
 	u8 tx_queues_count = priv->plat->tx_queues_to_use;
 	u32 weight;
@@ -6424,6 +6424,8 @@ static int stmmac_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 		return stmmac_tc_setup_taprio(priv, priv, type_data);
 	case TC_SETUP_QDISC_ETF:
 		return stmmac_tc_setup_etf(priv, priv, type_data);
+	case TC_SETUP_QDISC_ETS:
+		return stmmac_tc_setup_ets(priv, priv, type_data);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 14cabe76e53e..17be37e43bf8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1210,6 +1210,73 @@ static int tc_setup_etf(struct stmmac_priv *priv,
 	return 0;
 }
 
+static int tc_setup_sp_sched(struct stmmac_priv *priv)
+{
+	struct plat_stmmacenet_data *pdata = priv->plat;
+	int i;
+
+	for (i = 0; i < pdata->tx_queues_to_use; i++)
+		pdata->tx_queues_cfg[i].weight = 0;
+	stmmac_set_tx_queue_weight(priv);
+
+	pdata->tx_sched_algorithm = MTL_TX_ALGORITHM_SP;
+	stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
+				      pdata->tx_sched_algorithm);
+
+	return 0;
+}
+
+static int tc_setup_ets_sched(struct stmmac_priv *priv,
+			      struct tc_ets_qopt_offload *qopt)
+{
+	struct tc_ets_qopt_offload_replace_params *p = &qopt->replace_params;
+	struct plat_stmmacenet_data *pdata = priv->plat;
+	int i, nstrict = 0;
+
+	if (p->bands > priv->plat->tx_queues_to_use)
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < p->bands; i++) {
+		if (!p->quanta[i])
+			nstrict++;
+	}
+
+	if (p->bands && nstrict)
+		return -EOPNOTSUPP;
+
+	if (nstrict) {
+		tc_setup_sp_sched(priv);
+	} else {
+		for (i = 0; i < pdata->tx_queues_to_use; i++) {
+			if (i < p->bands)
+				pdata->tx_queues_cfg[i].weight = p->weights[i];
+			else
+				pdata->tx_queues_cfg[i].weight = 0;
+		}
+		stmmac_set_tx_queue_weight(priv);
+		pdata->tx_sched_algorithm = MTL_TX_ALGORITHM_DWRR;
+		stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
+					      pdata->tx_sched_algorithm);
+	}
+
+	return 0;
+}
+
+static int tc_setup_ets(struct stmmac_priv *priv,
+			struct tc_ets_qopt_offload *qopt)
+{
+	switch (qopt->command) {
+	case TC_ETS_REPLACE:
+		return tc_setup_ets_sched(priv, qopt);
+	case TC_ETS_DESTROY:
+		return tc_setup_sp_sched(priv);
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
@@ -1308,6 +1375,7 @@ const struct stmmac_tc_ops dwmac4_tc_ops = {
 	.setup_cls = tc_setup_cls,
 	.setup_taprio = tc_setup_taprio_without_fpe,
 	.setup_etf = tc_setup_etf,
+	.setup_ets = tc_setup_ets,
 	.query_caps = tc_query_caps,
 	.setup_mqprio = tc_setup_mqprio_unimplemented,
 };
@@ -1319,6 +1387,7 @@ const struct stmmac_tc_ops dwmac510_tc_ops = {
 	.setup_cls = tc_setup_cls,
 	.setup_taprio = tc_setup_taprio,
 	.setup_etf = tc_setup_etf,
+	.setup_ets = tc_setup_ets,
 	.query_caps = tc_query_caps,
 	.setup_mqprio = tc_setup_dwmac510_mqprio,
 };

---
base-commit: 828c4a5a9518117f9f7bdc445a7eeca85fc91bf8
change-id: 20260804-stmmac-ets-offload-cc936c99fdb1

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>


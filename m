Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004D435AC11
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380278; cv=none; b=M+lwWFfRHwh5gC6LZsfeep6u2r33vZASrCfxoRSmKul65hYGKioNaZBKElYm8loTXDGHp8w7R/Ew06krDdteLWPYzPdX31Bsky+I+NGcWVAUj1yggArz5FKVxsYkR3udE9Zn3G7uUi9SQ8VBVEwx+zW4KX5q+S1PpsIcwC2rmTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380278; c=relaxed/simple;
	bh=a74RwhKOzKO2aMZM9dGHFvUrKg/bQrbdI3oc5mLOjNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjpMFNu251tHu9PP3EDA1Wt/LTotLm92d2vUGlJEjHAnUyMNfpa+U4vmebEBURRwNUiq93sxuGuI0UAOpUD7tUN6bhCp0vb+ZVMNyl0vGcEVBrcEtYgK2aWEiY/tshPmaBKXhZghEBQAfHsQimC7rbzfxq/+P6+0mM2R5/CSz8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fxlBvkH+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d3WzqBCw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fxlBvkH+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d3WzqBCw"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KHAxx2686139
	for <netdev@vger.kernel.org>; Wed, 2 Sep 2026 20:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dyYScNOtdHH5lkgudhM8EXCmcZZ2OIA7V31pDbai0PQ=; b=fxlBvkH+vXl0Gx0O
	ag8gnUdA9OsyNqIr10AuWOAq5z/1Qs6DF0Z9g+wiV6At2goJbvh8a+819ZDOM2Bc
	PwV1kRM9w2VHUBvvxKjqZmIQmXEu8Sl2ID54ndP9NcJi591kgVzg75D5/ioBLpkx
	R3Ya+gTWoPLz6LGLVoIORazrkBhpyxkeDTYFuD8RDLo+uD+6rTqkD3t2AX4rxwgP
	ZiS8R8WC+YuSylM+t/OjfgQ/e8XEL3Wv7lMq/wM+iieZt/0l5wqYhUqvAuFInEC9
	/VhDYj7kzcVaRv8vjhM35caDGGzS6VNml0OiapBRnot/GfMECgKM5iV1O2BTlQ24
	7oX+Mg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gejv8a86b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 20:17:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e820609d9so312927585a.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 13:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788380275; x=1788985075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dyYScNOtdHH5lkgudhM8EXCmcZZ2OIA7V31pDbai0PQ=;
        b=d3WzqBCw6molNuJbOf9LX5ZgInYs70fjGOYT4v75eD8vu3tzWQv+4AqRkoO3AHm9IH
         A6T6ftdegdG2GxyP+nGKb+NOTx8AKpkcdGjWRmfooubht5hnM6N9ScCLtAU7dt7UeDHx
         0/lnIZxnZzpK30KesJ5m+Qr46Oo3YFCKTGPttFL/GLJR9pgLGvj7IyxGXV1jviLTxQfH
         v0EcaIsyp1Ab55pjcD/q6Dzo7/gNsZn0NjMktPPCs/25GWg3jebvefvqjzPufRi9GfKV
         UnKK8TEMloKEQEjcAmzLxDtS9thsAmCPstpy9LpocS2vobC5f48mZ+38pJwzsAd9A/aC
         NVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380275; x=1788985075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dyYScNOtdHH5lkgudhM8EXCmcZZ2OIA7V31pDbai0PQ=;
        b=BAboPsPryjOKVYZK9r5wKh1+6H4Zm6F4SADAgi1lJlSF4O2pyNgESW2vvy2kph19AR
         TxGQ/EbQfhlmVtrcLa8CUhBEmdympIQ5LXLasv0sxg/NfYXldddkIF4iT7YYqueCfJJn
         jchrCAy7UNJJExkxaDwrpG8oYCnoADsoj0nnoqmqE5yjFDBZdYKpbA02GoKaEEpgOi6L
         caqiFfwcb3oMEbjoEPcmUYo2LaZ3KRr75Rr8S76/vVhYEt6C51dzcEc8ZDaeDkYQ+BnO
         16U0OaE3tWJy8438hvWfRFQ1BnGtwpjJQTb3ok5grLHS7yBZVE4TzAVPULBsiC6MxVy3
         nSOQ==
X-Gm-Message-State: AFuF++lX/+iNyfIwmmETzYtbdYfkg8yT1BZxC+HnAz/oQDwciblVY+Z6
	GEBtD6F27RnzPZwYGd+S0qkXpp9ETfXQtodXSiOPK4mpBPPr2mQDwirsTx9vuycCHSOy7vmf6Fw
	S8/krOId3Y48nwXu9O3LS4q+iFhU6Z9tXoNBfw9lbWobxWRHRBPW6ZPwMQee0U5a7Ufs=
X-Gm-Gg: AYBFou098tc+2gBB2rvWw+jVH3wCx9RMZmIKKr7SwcCXbAEaEVU/WeR1SE6njRw38LR
	AUSe1HVFQozpYC/dgn4CNg/xtGl3hgPxGm934ydgQCeGGJqhj3HdCH0llMfMhvM1rbhqwaoNu77
	vKeNzCBWmspoCvUWQ7oQsqWR7NxrXZ3JHm1ayximFfKgPp23T5qI8DGZwNsvrNRH0Vs2GYqg9Fz
	FX6L1SWZmO1z8fCxL/XnGNhzVjcKhL8fePVQf2LpN4fdTx0VtHXPAyxEE86neUn3A7AEl48P+TT
	MgERvdw0LAIeAI2hZb6IDPUOIe3CQuwJ75pX8n1LhMjP54+eJhx+HDKwek/u7hHYah1axkP0xfm
	qZE6WBIrMyAMWvA==
X-Received: by 2002:a05:620a:2682:b0:939:1459:efb2 with SMTP id af79cd13be357-93960ef3c8amr950529885a.24.1788380274075;
        Wed, 02 Sep 2026 13:17:54 -0700 (PDT)
X-Received: by 2002:a05:620a:2682:b0:939:1459:efb2 with SMTP id af79cd13be357-93960ef3c8amr950521185a.24.1788380273528;
        Wed, 02 Sep 2026 13:17:53 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d6029sm15725085e9.6.2026.09.02.13.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:17:52 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 02 Sep 2026 22:15:42 +0200
Subject: [PATCH net v3 2/4] net: stmmac: embed struct stmmac_est in
 stmmac_priv struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-stmmac-est-reapply-after-open-v3-2-e72a6df5a7ef@oss.qualcomm.com>
References: <20260902-stmmac-est-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com>
In-Reply-To: <20260902-stmmac-est-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Rayagond Kokatanur <rayagond@vayavyalabs.com>,
        Thierry Reding <treding@nvidia.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: ezyEzbSThRRPSJeotiTua1v9qkGZ7jIS
X-Authority-Analysis: v=2.4 cv=L+wtheT8 c=1 sm=1 tr=0 ts=6a988473 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=8m_mm4JullfRwlNGEJsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX0Q/IyPbidnlV
 3gvp0nekDP2mzq+xJoZkwPy8QGCqlMasmwFC+moabAVnc6Q/GLsiUaNeG3mDRDdWTi1yHbTNQx2
 o+EjK7pe3i51PnOzpEOUZl6vmKC6TId75K4Yj62mUkpH2HZctH6P3ZkXhBDRRHhTq65bCsOIdFg
 Q54RF3dkz/MhGPLRcnfvLmnrC0/+O14np4W6ympmZwtEOmJHjE6JrgSahN4yMvSxP68Rtkr99GW
 K/RyHAsBjGrvBlzj2kpQzXE6vR99NkXEGmMw7r94z5sJVl7DO/N+cIo3uyatenxDZDHKyNJHNwc
 sSV+6l6sV+VemffC4RLPzyjVscQBY163Qbh9v4+vUjerJa6NKd5/u0ZrSgTZhwZJdGXe2Qh18dT
 BNstKoDV634v+RjuJ3ZHW1gVTmRUtGJrogZR/9Ebyf4ivTGbQOqhXcgR24/pWNuJcXT/TXqdJup
 sqVavnungkZUXUCzRwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX+oXIeCBQRs2I
 XTMNWaupqPXe2n1nfgTq9pKYZQq7xp3uNKpj+EMomu2kluX5YL4YJPOImZKLUCUU3wJsijzdbQ3
 X+arWrkGsQ7bn61J3fNLVD5kUQFpxHo=
X-Proofpoint-ORIG-GUID: ezyEzbSThRRPSJeotiTua1v9qkGZ7jIS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020179

This is a preliminary change to fix EST reconfiguration in the open
and resume paths: the taprio offload must be re-applied after the DMA
soft reset clears the MTL_EST registers, but the current layout makes
that fragile.
priv->est is currently a pointer allocated with devm_kzalloc() on the
first taprio REPLACE, and the mutex guarding it (priv->est_lock) is
initialized at the same time. That ties the lock's validity to whether
taprio has ever been configured, so the EST parameters can not be
read under the lock (e.g. to check priv->est->enable in the open and
resume paths) before the first offload setup.
Embed struct stmmac_est into struct stmmac_priv and initialize the mutex
in probe(). This makes the code simpler (no logical changes added).
Moreover, the lock is now unconditionally valid, so the enable flag can
be inspected under the lock from any control path.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 17 +++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 22 ++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 61 ++++++++++-------------
 4 files changed, 45 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 7582fca63741..a8c8be34ff81 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -298,7 +298,7 @@ struct stmmac_priv {
 	struct plat_stmmacenet_data *plat;
 	/* Protect est parameters */
 	struct mutex est_lock;
-	struct stmmac_est *est;
+	struct stmmac_est est;
 	struct dma_features dma_cap;
 	struct stmmac_counters mmc;
 	int hw_cap_support;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 47295845371a..a9fb15bdda43 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2723,9 +2723,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		if (!xsk_tx_peek_desc(pool, &xdp_desc))
 			break;
 
-		if (priv->est && priv->est->enable &&
-		    priv->est->max_sdu[queue] &&
-		    xdp_desc.len > priv->est->max_sdu[queue]) {
+		if (priv->est.enable && priv->est.max_sdu[queue] &&
+		    xdp_desc.len > priv->est.max_sdu[queue]) {
 			priv->xstats.max_sdu_txq_drop[queue]++;
 			continue;
 		}
@@ -4788,13 +4787,12 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (skb_is_gso(skb))
 		return stmmac_tso_xmit(skb, dev);
 
-	if (priv->est && priv->est->enable &&
-	    priv->est->max_sdu[queue]) {
+	if (priv->est.enable && priv->est.max_sdu[queue]) {
 		sdu_len = skb->len;
 		/* Add VLAN tag length if VLAN tag insertion offload is requested */
 		if (priv->dma_cap.vlins && skb_vlan_tag_present(skb))
 			sdu_len += VLAN_HLEN;
-		if (sdu_len > priv->est->max_sdu[queue]) {
+		if (sdu_len > priv->est.max_sdu[queue]) {
 			priv->xstats.max_sdu_txq_drop[queue]++;
 			goto max_sdu_err;
 		}
@@ -5198,9 +5196,8 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
 		return STMMAC_XDP_CONSUMED;
 
-	if (priv->est && priv->est->enable &&
-	    priv->est->max_sdu[queue] &&
-	    xdpf->len > priv->est->max_sdu[queue]) {
+	if (priv->est.enable && priv->est.max_sdu[queue] &&
+	    xdpf->len > priv->est.max_sdu[queue]) {
 		priv->xstats.max_sdu_txq_drop[queue]++;
 		return STMMAC_XDP_CONSUMED;
 	}
@@ -8029,6 +8026,7 @@ static int __stmmac_dvr_probe(struct device *device,
 	stmmac_napi_add(ndev);
 
 	mutex_init(&priv->lock);
+	mutex_init(&priv->est_lock);
 
 	stmmac_fpe_init(priv);
 
@@ -8160,6 +8158,7 @@ void stmmac_dvr_remove(struct device *dev)
 	stmmac_mdio_unregister(ndev);
 
 	destroy_workqueue(priv->wq);
+	mutex_destroy(&priv->est_lock);
 	mutex_destroy(&priv->lock);
 	bitmap_free(priv->af_xdp_zc_qps);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 960249960004..be5b26edd04c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -69,11 +69,11 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	nsec = reminder;
 
 	/* If EST is enabled, disabled it before adjust ptp time. */
-	if (priv->est && priv->est->enable) {
+	if (priv->est.enable) {
 		est_rst = true;
 		mutex_lock(&priv->est_lock);
-		priv->est->enable = false;
-		stmmac_est_configure(priv, priv, priv->est,
+		priv->est.enable = false;
+		stmmac_est_configure(priv, priv, &priv->est,
 				     priv->plat->clk_ptp_rate);
 		mutex_unlock(&priv->est_lock);
 	}
@@ -91,19 +91,19 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		mutex_lock(&priv->est_lock);
 		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
 		current_time_ns = timespec64_to_ktime(current_time);
-		time.tv_nsec = priv->est->btr_reserve[0];
-		time.tv_sec = priv->est->btr_reserve[1];
+		time.tv_nsec = priv->est.btr_reserve[0];
+		time.tv_sec = priv->est.btr_reserve[1];
 		basetime = timespec64_to_ktime(time);
-		cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC +
-			     priv->est->ctr[0];
+		cycle_time = (u64)priv->est.ctr[1] * NSEC_PER_SEC +
+			     priv->est.ctr[0];
 		time = stmmac_calc_tas_basetime(basetime,
 						current_time_ns,
 						cycle_time);
 
-		priv->est->btr[0] = (u32)time.tv_nsec;
-		priv->est->btr[1] = (u32)time.tv_sec;
-		priv->est->enable = true;
-		ret = stmmac_est_configure(priv, priv, priv->est,
+		priv->est.btr[0] = (u32)time.tv_nsec;
+		priv->est.btr[1] = (u32)time.tv_sec;
+		priv->est.enable = true;
+		ret = stmmac_est_configure(priv, priv, &priv->est,
 					   priv->plat->clk_ptp_rate);
 		mutex_unlock(&priv->est_lock);
 		if (ret)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 14cabe76e53e..e25a08e4be5f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -959,7 +959,7 @@ static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
 		count = qopt->mqprio.qopt.count[i];
 
 		for (j = offset; j < offset + count; j++)
-			priv->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
+			priv->est.max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
 	}
 }
 
@@ -1023,24 +1023,15 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (qopt->cycle_time_extension >= BIT(wid + 7))
 		return -ERANGE;
 
-	if (!priv->est) {
-		priv->est = devm_kzalloc(priv->device, sizeof(*priv->est),
-					 GFP_KERNEL);
-		if (!priv->est)
-			return -ENOMEM;
-
-		mutex_init(&priv->est_lock);
-	} else {
-		mutex_lock(&priv->est_lock);
-		memset(priv->est, 0, sizeof(*priv->est));
-		mutex_unlock(&priv->est_lock);
-	}
+	mutex_lock(&priv->est_lock);
+	memset(&priv->est, 0, sizeof(priv->est));
+	mutex_unlock(&priv->est_lock);
 
 	size = qopt->num_entries;
 
 	mutex_lock(&priv->est_lock);
-	priv->est->gcl_size = size;
-	priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
+	priv->est.gcl_size = size;
+	priv->est.enable = qopt->cmd == TAPRIO_CMD_REPLACE;
 	mutex_unlock(&priv->est_lock);
 
 	for (i = 0; i < size; i++) {
@@ -1065,7 +1056,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			return -EOPNOTSUPP;
 		}
 
-		priv->est->gcl[i] = delta_ns | (gates << wid);
+		priv->est.gcl[i] = delta_ns | (gates << wid);
 	}
 
 	mutex_lock(&priv->est_lock);
@@ -1075,22 +1066,22 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	time = stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
 					qopt->cycle_time);
 
-	priv->est->btr[0] = (u32)time.tv_nsec;
-	priv->est->btr[1] = (u32)time.tv_sec;
+	priv->est.btr[0] = (u32)time.tv_nsec;
+	priv->est.btr[1] = (u32)time.tv_sec;
 
 	qopt_time = ktime_to_timespec64(qopt->base_time);
-	priv->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
-	priv->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
+	priv->est.btr_reserve[0] = (u32)qopt_time.tv_nsec;
+	priv->est.btr_reserve[1] = (u32)qopt_time.tv_sec;
 
 	ctr = qopt->cycle_time;
-	priv->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
-	priv->est->ctr[1] = (u32)ctr;
+	priv->est.ctr[0] = do_div(ctr, NSEC_PER_SEC);
+	priv->est.ctr[1] = (u32)ctr;
 
-	priv->est->ter = qopt->cycle_time_extension;
+	priv->est.ter = qopt->cycle_time_extension;
 
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
-	ret = stmmac_est_configure(priv, priv, priv->est,
+	ret = stmmac_est_configure(priv, priv, &priv->est,
 				   priv->plat->clk_ptp_rate);
 	mutex_unlock(&priv->est_lock);
 	if (ret) {
@@ -1106,19 +1097,17 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	return 0;
 
 disable:
-	if (priv->est) {
-		mutex_lock(&priv->est_lock);
-		priv->est->enable = false;
-		stmmac_est_configure(priv, priv, priv->est,
-				     priv->plat->clk_ptp_rate);
-		/* Reset taprio status */
-		for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
-			priv->xstats.max_sdu_txq_drop[i] = 0;
-			priv->xstats.mtl_est_txq_hlbf[i] = 0;
-			priv->xstats.mtl_est_txq_hlbs[i] = 0;
-		}
-		mutex_unlock(&priv->est_lock);
+	mutex_lock(&priv->est_lock);
+	priv->est.enable = false;
+	stmmac_est_configure(priv, priv, &priv->est,
+			     priv->plat->clk_ptp_rate);
+	/* Reset taprio status */
+	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
+		priv->xstats.max_sdu_txq_drop[i] = 0;
+		priv->xstats.mtl_est_txq_hlbf[i] = 0;
+		priv->xstats.mtl_est_txq_hlbs[i] = 0;
 	}
+	mutex_unlock(&priv->est_lock);
 
 	stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
 

-- 
2.55.0


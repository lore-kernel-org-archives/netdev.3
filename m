Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109D837D11A
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846803; cv=none; b=RGlGURgg6FwWcXUaknTpr6R3paIJRLjbaWL0M959dDneGvrZCbuzvITSmZ7ELy3Xw4WYgy+KzE5s6tND+XX9CQfiwcVFvDoRywTNvVc9kV3txB1dwP1ykzrurC0REe0lMJMUbXTMtP6SgDK4dhDYEDbIWGsK2py9hyqmeVd1DPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846803; c=relaxed/simple;
	bh=e3oXcS7+K1HRYAoj42uAUlJEEBG3L+4F57mJ3fec7Xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eVhQ0sqjITOHO7HmOpaG4IqAp9/mO+541B7Z9bX9WHGP/nhEGLZkh2V5SZNd+SH7L5/OEYQFmdXD+2cPHe39rrWKTgxCGnZC1bfvFezMCRRBBrwW7rk1qLjcHZZyWQBJM3VC+QwQT9JleLu6RRYDAhGj4eVdXM2f+p10uwBONI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tp2Babzk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cpYALioB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tp2Babzk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cpYALioB"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6916xcTM2176973
	for <netdev@vger.kernel.org>; Thu, 1 Oct 2026 09:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4crrq+kperLPKrz6unSPTu6Yz68NeVuDjB50rFifJ1s=; b=Tp2BabzkHq9z9vYo
	q8Z0L7YolKT/pK3m+ytWofLtyiIkzRmbJt6QP19Xskob2jDb3y+zRc84q1q4CTfq
	fJHDnIk8igUspsHxKLzvfaQDzZlpIapSDqEKBNxJW5NTsCQ2JARfevP4M3GBPuFQ
	T3HeHgRHjOg8z7gSFkzY37v5oruQWIOu8EnfDEiEresi/V9i9jQns7Ce1sMBkZpj
	PjRzUn3s3wBvYWoCGXR/ze9VLaMYo7ZhA86o1rh7V95cU6j37dnBnQgpoNBOeH10
	xdbogkVk7AsMv3NAW30Wsxywah1Ivl6RSlUYsKPbtT5nCkYod6WwwlJeXp619mps
	Maz/Og==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1h7ns0ce-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 09:26:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cc40759b2so2465985a.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 02:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790846796; x=1791451596; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4crrq+kperLPKrz6unSPTu6Yz68NeVuDjB50rFifJ1s=;
        b=cpYALioBQYVTz6yK9LEhSE/3YTIpJ1GfVbWbelAd5VtLF6pvfJ+rR0CxOtx7mNCT4Y
         k6Im+SDmv1c/eWcLXP+SdAdiuJvZWMx5NuajNjjnxcbpaH1d4N9fKdkz/mVTmlEhgLnB
         +S4R8hux4L19v6NxBvnlWMsLfkh2Ip5WquRlspCTzQPmrQvUMDGW3I1l9paIRoYV7o70
         ibfD5GvrkvIYdJr0LiYCrvpWxpJXyvNbJebpDhED1Mv5Ut42Dz+GQNpCujGcm5xoVZK3
         MROhzLrXQhlALRn2lov5gMoEhVPxwxRLj96JoEJ49jI2I8k7zPkJVlCVK80mOL1TkXIM
         Duwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790846796; x=1791451596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4crrq+kperLPKrz6unSPTu6Yz68NeVuDjB50rFifJ1s=;
        b=PiMbEYhGtFeKt9eeXJUDstuhH4n6p7s/6xKFmpvgOG7HbSIquCjU+bBvDMSJ9ErNAG
         eRjp4k1YGGI2mG6CL87MS6ApQ/qjIIuYS/Sl5Eh7GDvP+oTHnQhjUd4GffH/5amnbKq7
         /vZMHzoI1YANLAi5Rw66mtLB27lDDI8DrKfuXQs2VS8rTC8KkBkiKiVEly3iJ7bdA80G
         m3LvjZZ/I81u7azItl+ZSV+0aC97dEiGnopDY8YZImiPh0xtVQXzd9tSGiYhnF18eMZi
         WEEcgq5iQU63u1+QNlELs6Vs7h1/KqJjQHOArk3+dXCiYVOuY8KxKA5vry7Vg+K93Dbi
         Ljsg==
X-Gm-Message-State: AFuF++nsrkPxfl4Aj0AbDxowMIAvYo1RCdKBT91K/B6cDobi81ocUc8I
	kXRNFksxmC5Rt27c7/0l/zLTJxNcJ4B8bMV7oQABMCjSzsWmjzhiB8ynPiD3on1eq9VBxS2IyZg
	7NNMMh+ZRlMrSFAs0zOc+FrE2meYaC0zdO88WkOiYitaBLADJLrLr+vWuCL8=
X-Gm-Gg: AYBFou1Fw4aAIoiOiB6UqIiru5EBn9IgXacMxgv7/lVc7mUCm4Jrc2I/R3KMV35ZTle
	UzkDaDSc03UGsjellcN5LahXpaXRwuNrNgFshACcvr+qYhTI+BaY6VUxaGPA83gido7MLvwhLUc
	T0uhwLBHeZZmZnxaNSixtP8HDXb2tsWcwi5ngQFwspdiPXuAvz5WDQer2fcwPctMiTnNp3aMPQC
	3yef2Q1t2oesbSiUgUXBAVSiyUVx5+e30aUQlVaswnhGxxZjKnbBaMdBIOwLcuDhPckmd+aX1Fq
	0wj9dPDqehzD+uTZCZv30ffzhYs73+9NtdyP9Eo8Cds5BEt0xyDPbo2hkLkcSUv7hFEkPicxdkI
	VAaHSUB3XZWexHg==
X-Received: by 2002:a05:620a:17aa:b0:93c:73a:3996 with SMTP id af79cd13be357-93ca977a317mr742131785a.57.1790846795787;
        Thu, 01 Oct 2026 02:26:35 -0700 (PDT)
X-Received: by 2002:a05:620a:17aa:b0:93c:73a:3996 with SMTP id af79cd13be357-93ca977a317mr742129085a.57.1790846795239;
        Thu, 01 Oct 2026 02:26:35 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f900c23sm34817125e9.1.2026.10.01.02.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:26:33 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 01 Oct 2026 11:26:13 +0200
Subject: [PATCH net-next v4 2/2] net: stmmac: add XDP multi-buff support
 for TX side
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-b4-stmmac-xmit-mb-v4-2-664e0c3eb289@oss.qualcomm.com>
References: <20261001-b4-stmmac-xmit-mb-v4-0-664e0c3eb289@oss.qualcomm.com>
In-Reply-To: <20261001-b4-stmmac-xmit-mb-v4-0-664e0c3eb289@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=OI6yTiaB c=1 sm=1 tr=0 ts=6abe274c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=JYNNWCGdvEbVgmh2GQ0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzNyBTYWx0ZWRfX2tl/8IHijoPZ
 VDMlhjPIvSh68ju6IXZQj+4p1K41ds1RZzF8r+1uSgT+Qya1hIgyLsDRg23/pqZOzl6SthloQeT
 b0mkc1k8hewHHI4OE4OJML4EZ71uAqQ=
X-Proofpoint-ORIG-GUID: 8Pki5YUXpvBPRbYJp4Hi_tKqFH6zUyDf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzNyBTYWx0ZWRfXwPmfzSSdps00
 AynPWKANsNvK6FzxOkZFO22gcHegz/UPasRVgo7CpjGrswK+hnPoxrx7eWPfq8AtTVm7q1opgxw
 vZPyh7oNuq6Wk8OGQxt71YHg70AXkvwNdNgHOKllAmta0x3X27Xt+NtnbVwtrmbrKD3JW6BQlMN
 sWwRwVk6WvaSC2KdvsZjuxK726nuVhA1RY0ZOc6tH/UNyYaxRtGVetGA8HkkOMPPBy++chmAl7D
 sBgJsq0fLFdlpK1tvMtPHrsPdbRzRaKO04fx9UmgFCU78JLSw55qLPGEP2yv5wzMkk9DisI2u1M
 xYGDaMwEaJz3I229sla10ELTlZctcBJSkYn3eHxqyMgdzzhIZIIbHtQqOqc41nJIo2GcstgVaGQ
 bCA94gMAJ8AC2n6Aj0tLDXe8QwURpIZ+75hS9qciiH8Tggiiwt7TALODQiaBC9F/PyV9clCUQxI
 hcyPDhQYJpO7TOhcKQg==
X-Proofpoint-GUID: 8Pki5YUXpvBPRbYJp4Hi_tKqFH6zUyDf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010037

Extend stmmac_xdp_xmit_xdpf() to transmit XDP frames with fragments
(multi-buff). Each buffer, i.e. the frame head and every frag, is mapped
and programmed into a dedicated TX descriptor.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 122 +++++++++++++++-------
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c  |   2 +-
 2 files changed, 85 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index df6a329fdb80..508e865f9387 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5249,73 +5249,119 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
 static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 				struct xdp_frame *xdpf, bool dma_map)
 {
-	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_frame(xdpf);
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
 	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
+	unsigned int txq_thr = STMMAC_TX_THRESH(priv);
+	unsigned int first_entry = tx_q->cur_tx;
 	unsigned int entry = tx_q->cur_tx;
-	enum stmmac_txbuf_type buf_type;
-	struct dma_desc *tx_desc;
-	dma_addr_t dma_addr;
+	unsigned int num_frames = 1;
+	struct dma_desc *desc;
 	u32 tx_coal;
+	int i = 0;
 
-	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
+	if (unlikely(xdp_frame_has_frags(xdpf)))
+		num_frames += sinfo->nr_frags;
+
+	if (stmmac_tx_avail(priv, queue) < max(num_frames, txq_thr))
 		return STMMAC_XDP_CONSUMED;
 
 	if (priv->est && priv->est->enable &&
 	    priv->est->max_sdu[queue] &&
-	    xdpf->len > priv->est->max_sdu[queue]) {
+	    xdp_get_frame_len(xdpf) > priv->est->max_sdu[queue]) {
 		priv->xstats.max_sdu_txq_drop[queue]++;
 		return STMMAC_XDP_CONSUMED;
 	}
 
-	tx_desc = stmmac_get_tx_desc(priv, tx_q, entry);
-	if (dma_map) {
-		dma_addr = dma_map_single(priv->device, xdpf->data,
-					  xdpf->len, DMA_TO_DEVICE);
-		if (dma_mapping_error(priv->device, dma_addr))
-			return STMMAC_XDP_CONSUMED;
-
-		buf_type = STMMAC_TXBUF_T_XDP_NDO;
-	} else {
-		struct page *page = virt_to_page(xdpf->data);
-
-		dma_addr = page_pool_get_dma_addr(page) + sizeof(*xdpf) +
-			   xdpf->headroom;
-		dma_sync_single_for_device(priv->device, dma_addr,
-					   xdpf->len, DMA_BIDIRECTIONAL);
-
-		buf_type = STMMAC_TXBUF_T_XDP_TX;
-	}
+	while (true) {
+		skb_frag_t *frag = i ? &sinfo->frags[i - 1] : NULL;
+		int len = frag ? skb_frag_size(frag) : xdpf->len;
+		bool last_frame = i == num_frames - 1;
+		enum stmmac_txbuf_type buf_type;
+		dma_addr_t dma_addr;
 
-	stmmac_set_tx_dma_entry(tx_q, entry, buf_type, dma_addr, xdpf->len,
-				false);
-	stmmac_set_tx_dma_last_segment(tx_q, entry);
+		desc = stmmac_get_tx_desc(priv, tx_q, entry);
+		if (dma_map) {
+			if (frag)
+				dma_addr = skb_frag_dma_map(priv->device,
+							    frag, 0, len,
+							    DMA_TO_DEVICE);
+			else
+				dma_addr = dma_map_single(priv->device,
+							  xdpf->data, len,
+							  DMA_TO_DEVICE);
+			if (dma_mapping_error(priv->device, dma_addr))
+				goto error_dma_unmap;
 
-	tx_q->xdpf[entry] = xdpf;
+			buf_type = STMMAC_TXBUF_T_XDP_NDO;
+		} else {
+			struct page *page;
 
-	stmmac_set_desc_addr(priv, tx_desc, dma_addr);
+			page = frag ? skb_frag_page(frag)
+				    : virt_to_page(xdpf->data);
+			dma_addr = page_pool_get_dma_addr(page);
+			if (frag)
+				dma_addr += skb_frag_off(frag);
+			else
+				dma_addr += sizeof(*xdpf) + xdpf->headroom;
+			dma_sync_single_for_device(priv->device, dma_addr,
+						   len, DMA_BIDIRECTIONAL);
+			buf_type = STMMAC_TXBUF_T_XDP_TX;
+		}
 
-	stmmac_prepare_tx_desc(priv, tx_desc, 1, xdpf->len,
-			       csum, priv->descriptor_mode, true, true,
-			       xdpf->len);
+		stmmac_set_tx_dma_entry(tx_q, entry, buf_type, dma_addr, len,
+					dma_map && frag);
+		stmmac_set_desc_addr(priv, desc, dma_addr);
+		stmmac_prepare_tx_desc(priv, desc, !i, len, csum,
+				       priv->descriptor_mode, !!i, last_frame,
+				       xdp_get_frame_len(xdpf));
+		tx_q->xdpf[entry] = last_frame ? xdpf : NULL;
+		if (last_frame) {
+			stmmac_set_tx_dma_last_segment(tx_q, entry);
+			break;
+		}
 
-	tx_q->tx_count_frames++;
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		i++;
+	}
+	tx_q->tx_count_frames += num_frames;
 
 	tx_coal = READ_ONCE(priv->tx_coal_frames[queue]);
-	if (tx_coal && !(tx_q->tx_count_frames % tx_coal)) {
+	if (tx_coal && (tx_q->tx_count_frames % tx_coal) < num_frames) {
+		struct stmmac_txq_stats *txq_stats;
+
+		desc = stmmac_get_tx_desc(priv, tx_q, entry);
+		stmmac_set_tx_ic(priv, desc);
 		tx_q->tx_count_frames = 0;
-		stmmac_set_tx_ic(priv, tx_desc);
+
+		txq_stats = &priv->xstats.txq_stats[queue];
 		u64_stats_update_begin(&txq_stats->q_syncp);
 		u64_stats_inc(&txq_stats->q.tx_set_ic_bit);
 		u64_stats_update_end(&txq_stats->q_syncp);
 	}
 
+	/* Set the OWN bit on the first descriptor now that all descriptors
+	 * for this xdp_frame are populated.
+	 */
+	desc = stmmac_get_tx_desc(priv, tx_q, first_entry);
+	dma_wmb();
+	stmmac_set_tx_owner(priv, desc);
+	tx_q->cur_tx = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
 	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
-	entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
-	tx_q->cur_tx = entry;
-
 	return STMMAC_XDP_TX;
+
+error_dma_unmap:
+	while (first_entry != entry) {
+		desc = stmmac_get_tx_desc(priv, tx_q, first_entry);
+		stmmac_release_tx_desc(priv, desc, priv->descriptor_mode);
+		stmmac_free_tx_buffer(priv, &priv->dma_conf, queue,
+				      first_entry);
+		first_entry = STMMAC_NEXT_ENTRY(first_entry,
+						priv->dma_conf.dma_tx_size);
+	}
+
+	return STMMAC_XDP_CONSUMED;
 }
 
 static int stmmac_xdp_get_tx_queue(struct stmmac_priv *priv,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
index d7e4db7224b0..9af9e0cb366c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
@@ -135,7 +135,7 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 		stmmac_xdp_open(dev);
 
 	if (prog)
-		xdp_features_set_redirect_target(dev, false);
+		xdp_features_set_redirect_target(dev, true);
 
 	return 0;
 }

-- 
2.55.0


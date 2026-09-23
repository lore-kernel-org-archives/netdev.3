Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E091241A4E8
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157572; cv=none; b=KKd11NpvK0JWE6McZhbyCz8VqiaSkLtTZ+OMVt8siA1l7SZNLY8mYYj9ZSvIA5mi09SaEtmkcTLnpH/+R8nwtQhsxKBRRjWEmVPtSCf/2S+oPCSHrK+kG9aBqW/Vxy0fP6bJbsTNYqooJw8QTDOC0rrsQdga+GEiDeLfgdNDYSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157572; c=relaxed/simple;
	bh=wu2ajQBBKmZJFz7lYB1o+jajVYOPIjqFA2K0JkVtDao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XaYZZR6QaFU5WkYHiVa4NMmocEsVqFIMTWIncl8sA+PHADKGKssX9/koiF8rRDkVCQNfiqxe9HxAJh08rjiL1WDTwBDsfphOkK6ohgs4IZQDD1ZQVOsPW0k4Ye1/0g2Ud2YxnYPy8ksPif1/3Cg+c4JrjEIUNDjJz+eWGfGZNVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pULr+Xd8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hVVapv7x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pULr+Xd8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hVVapv7x"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N9A5462701017
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 09:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=egCUu3HTqrsn7eQkpEjxXZ
	vLWBaQva+luRds8de5Z0U=; b=pULr+Xd8XAVBz/sdE5twh4HNRw+ebJzrrThyMZ
	pLNHlC5/5hqCICWIM81lHUCQtuPXFBFqVvWBgp9UXQnu2MjZjSd9ojDhht8sHWOL
	6hZ7nvf6JDbu2ow0+RBko8FVnhHcUTCox1RPxU/8Q0Q7J8lZfT3ZuojeHyI2+o5o
	dGJjbPDdZxTKenjWWQLk1tv3enPkROH0Z6grTlrXLBBSWFhARco+ieEoddI0pBPI
	80QR8LhuEhYZ61prP1DDmw2ihAtQJtooHlIMeZZR9zWJC6Aa8jc3JQvThhzgBcVY
	LpoR8QyDaCTLuR7CVUcjSCf680HGzTsCnYH76z62NdfMueOg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwar755-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 09:59:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a00c70d28so151879985a.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790157568; x=1790762368; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=egCUu3HTqrsn7eQkpEjxXZvLWBaQva+luRds8de5Z0U=;
        b=hVVapv7xr3lAN7cAHuWfg1/BgBuA8ivLF9LcP4S+mFtiYAXMDCgPe/6YMlGHeGzT4E
         WXT7/7/XEauokviYMxfVkhc6rS+oA8h2Pw57ZaDeBLCdAPC+PwuuJkypPG6PiFdPwshU
         Hk9wWsmEk6PFa3eHrkjygz2s+G4xevhAWOHPUgpeEh8gB7wcpJUB5Pip8GPb7Hsf4o1r
         tnX8LcLHPJF4zBQ/G4Rinas8ywfc4IqcApX2hvGnSVMeAGXkWJl3ftx05rpAXwpslESM
         mTPHWTzZtYx2nJ2bjv2Qh/aXx+sMdknQWKrguDKDMXFF4Uz0/jHcTiYKQop3gGK+uFXk
         Rgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790157568; x=1790762368;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=egCUu3HTqrsn7eQkpEjxXZvLWBaQva+luRds8de5Z0U=;
        b=tBMjuKZBz24dvTaWvPUFy/ZXVaK4AjNzyASayuvdrtHfmJVumZlrVh63oiOEdp831n
         A8tOTEWXycX3P6WE7crGPyMBxHjEsDCp9eLFEbf0nYO7Rd3IExfpc1czZNeLY6N8Iq6o
         G6QHUHkUtHZxk0BHT69WZeLV/f4GV7U7zmLey8d6kG4xp3ZqYrNG68kroYC3m6ImNLz7
         0gRCTzJ1/Q5PFsT8bsNAYxPjagGGDkMSxZBXQaPGjyOOuC0ncl9MSzuoMi1Pwqhn4R5E
         jOOsqyb/Ujzkx+v3nTXuiPM6NVVDfLwJ7xQNgg/yN21IaSe2sjxS8V20xJVFIjC1dNm/
         OPTw==
X-Gm-Message-State: AFuF++kwpnBTvZqaKcyswY89kZs99V9iXThPGp6tDa4azInCUfKP5vP4
	HXfenhPUxtx3xDPQ3VAlRqhcitks4GdyVbf+Lp8d1KDq4s8DL7+hEXckwEFxIkG6FsSrqpk3A6J
	fae02mSEoOEOG6TN9c63QrO84PHMRQPk9X+Bl7rGkf2d4HVt6IPQpsxFhbD8=
X-Gm-Gg: AYBFou1TteLM6oFp2gQWRnrD4Fni3H1kSQnAue35nU4rL5RG8E1stpqba7YaZZg11j8
	ycTgo3bS5TooTr7fguXPQkgX9sPqUyd4iAz0KBzFe7BRs3Tob0UA+IRO2fGs1hP9KIoci0xtaJJ
	5Kv8lRRBBguPvVJOmONZvM57V0p9I/O7iwUcsmCTgawej9LErUJihaFCKSuSoBK5gAWxpETkEw7
	r9p6nyuaAVpoYqHViWRhBLYW61vpJVFY3Nwt1QO2jLttFLf47caoorUcDdqkOZJSBK5lzdk4dYF
	fKuXmP9+C0BBaKChZ6+uvNEGeO86ZVO0ijuqi9H7q0Ht9XkguIMlPMKofDtClNRjS/NXvY0laOW
	T36sU+kVWW2mYzA==
X-Received: by 2002:a05:620a:269b:b0:93b:d7a2:83cf with SMTP id af79cd13be357-93c2528273emr274069485a.62.1790157567765;
        Wed, 23 Sep 2026 02:59:27 -0700 (PDT)
X-Received: by 2002:a05:620a:269b:b0:93b:d7a2:83cf with SMTP id af79cd13be357-93c2528273emr274067585a.62.1790157567272;
        Wed, 23 Sep 2026 02:59:27 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab386e596sm1310754a12.7.2026.09.23.02.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 02:59:26 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 11:58:48 +0200
Subject: [PATCH net-next] net: stmmac: add XDP multi-buff support for TX
 side
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-b4-stmmac-xmit-mb-v1-1-a71a1c522142@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBswkbKuEi3SppqFFiohSHdPW
 r7F/wUiBaYIU1Mg0MORL1/RtQ3Yc/UHIW/VIIXsxSglGoUxObdazI4TOoPGDJpEr5XdFdTuDrR
 z/p8zeEroKSdY3vcDU8QwMm0AAAA=
X-Change-ID: 20260922-b4-stmmac-xmit-mb-bb78e0684cf4
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzOSBTYWx0ZWRfX00SIcu6geRGT
 CVqjObP04Bv3YC4I3SRpXXlc6B/dp/GOwodPuB0rmch1334uekh2pNVRg7OKZkgdfAMyz2HmRGn
 eDNteKKJhUQie70mdSxpOHKhV3lVzWd89auEaTq5nLTtpEkaF4uVoQ6yb2aXZ0UI3YZQVjJ2pyj
 73VTlM+Tss0Z3Y4s543DVEiXX2GTopJMoYhyEyw1+SWBfEp8IPM1LAisdjWeD7ExwThuOhwJxSh
 OUHt/wnk3DVEXvB2EXdxFrMVim/1QpNVp/PvNAjzAq6FIKKz34Elt2JLj0O70PLW5BDMXZgwECX
 uBinauZCymSS3ICpV0hwZkGy/EKRebkkjarbuurP5XilU1kGSROh+eWfSHmls2jaA6ZhxqjaWXO
 tFvxrfEUZdKslzu/owJZedA93qEj2WX9jdIALgqbDWz3VekzsMzwfKS5hABoK9N+l/P4vu5Y/kY
 IlqNKipKqUe8DM7oXqQ==
X-Authority-Analysis: v=2.4 cv=HfuB3SE8 c=1 sm=1 tr=0 ts=6ab3a300 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=kSU5s68tBFIkprDc3QkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: Ifnlqg4siPHNyuiT4DR9tngbyUr6Kyj8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzOSBTYWx0ZWRfX+a4EOHEQmruD
 D22ovYTjTcQ2H61eo2Mg2pawxZdVowERs5HUpsjhJ0jnR1o/1cTpdnm0heA7Wo8p24Kkt2oe51C
 8hZfkrstym2UDo6gNI1qq8SZh06UIjs=
X-Proofpoint-ORIG-GUID: Ifnlqg4siPHNyuiT4DR9tngbyUr6Kyj8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230039

Extend stmmac_xdp_xmit_xdpf() to transmit XDP frames with fragments
(multi-buff). Each buffer, i.e. the frame head and every frag, is mapped
and programmed into a dedicated TX descriptor.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 123 ++++++++++++++--------
 1 file changed, 80 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index bf9e7e4cb1c3..41ccde6371ec 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5239,77 +5239,114 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
 static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 				struct xdp_frame *xdpf, bool dma_map)
 {
-	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_frame(xdpf);
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
 	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
+	unsigned int first_entry = tx_q->cur_tx;
 	unsigned int entry = tx_q->cur_tx;
-	enum stmmac_txbuf_type buf_type;
-	struct dma_desc *tx_desc;
-	dma_addr_t dma_addr;
-	bool set_ic;
+	int i = 0, num_frames = 1;
+	struct dma_desc *desc;
 
-	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
+	if (unlikely(xdp_frame_has_frags(xdpf)))
+		num_frames += sinfo->nr_frags;
+
+	if (stmmac_tx_avail(priv, queue) < num_frames)
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
+	while (true) {
+		skb_frag_t *frag = i ? &sinfo->frags[i - 1] : NULL;
+		int len = frag ? skb_frag_size(frag) : xdpf->len;
+		bool last_frame = i == num_frames - 1;
+		enum stmmac_txbuf_type buf_type;
+		dma_addr_t dma_addr;
 
-		buf_type = STMMAC_TXBUF_T_XDP_TX;
-	}
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
 
-	stmmac_set_tx_dma_entry(tx_q, entry, buf_type, dma_addr, xdpf->len,
-				false);
-	stmmac_set_tx_dma_last_segment(tx_q, entry);
+			buf_type = STMMAC_TXBUF_T_XDP_NDO;
+		} else {
+			struct page *page;
 
-	tx_q->xdpf[entry] = xdpf;
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
 
-	stmmac_set_desc_addr(priv, tx_desc, dma_addr);
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
 
-	stmmac_prepare_tx_desc(priv, tx_desc, 1, xdpf->len,
-			       csum, priv->descriptor_mode, true, true,
-			       xdpf->len);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		i++;
+	}
+	tx_q->tx_count_frames += num_frames;
 
-	tx_q->tx_count_frames++;
+	if (!(tx_q->tx_count_frames % priv->tx_coal_frames[queue])) {
+		struct stmmac_txq_stats *txq_stats;
 
-	if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] == 0)
-		set_ic = true;
-	else
-		set_ic = false;
-
-	if (set_ic) {
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
+	 * for this skb are populated.
+	 */
+	desc = stmmac_get_tx_desc(priv, tx_q, first_entry);
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

---
base-commit: 944ae66642b726bd6b25ae71b1e9ff88a0e0bdb0
change-id: 20260922-b4-stmmac-xmit-mb-bb78e0684cf4

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>


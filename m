Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313564B2046
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823484; cv=none; b=QFe4A840l0T944Zvu4dA4K4h8s6GEByrevKl5CPNMbG/EhXOIWBQ0A4EFH4ei3JxtmgyeAPDdvJbntEiEBstB25Z3InYv7lQ65t1KLwTySnuxQ+6i+8gZCILZNyc4IMYeMuYYticMLT3qtJ2NGJws5oQaCgfAWOpyFUMs/hq738=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823484; c=relaxed/simple;
	bh=YTcaGiKHiBzOKEwIUiSeJVnujiJGLolNhYDEcvXD2So=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s/rznzBC18GoTFMjCExno4AyK0DvwZey2fXI226CdJ1IH1Y8BYrERs1K046VwVb635W/y0TtFRekqpNK1vCkcgwG55ArMunYpoG9v8BcfOLnbU3mjn3AiQ4itDCPQwpqcN0s9iJAmhuZFXrqSEmRqxIYwW7R/Vcbbz9k6gJqgkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F1tBvOK8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NQsDHPIh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F1tBvOK8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NQsDHPIh"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFexZ31290958
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m7uLNSvnwZ8teVL1fB+yhjFqyopjcpDVtN+2BWDZq7o=; b=F1tBvOK8B2AxcIUO
	LpM6x2HLcYiRFoLoNFrept/HxD9K/vpIjOlKCSt07FSFKEQqd2u/Y5F/pCh9vMgz
	vzhXSHAvITMZ/d9Qy3I/no7F8ZKTqS006q0rGETsGBqi8Oq0SDsepxPMX1KsfBGo
	bw/p4B7OkSbBKMbBjTkqKUbtLEIp+iR+/k9VFnu3XZX4wKjSkfx8rJePZxCY4NX3
	5ZOb7V0q7P5c81VWFCq3I9h3Bg0WEyn9otBVS1eAGrggzzff7Fdid4QNI3rPBUYQ
	3qy0ogare8GhAuuNiXqQJTykaUi/PJDOeNKWsqWeW8ZKm4skkgMbEpgEhKhr4cur
	dFjn5w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wfcsrtt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:44:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb7f9bb86so393754185a.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791823481; x=1792428281; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m7uLNSvnwZ8teVL1fB+yhjFqyopjcpDVtN+2BWDZq7o=;
        b=NQsDHPIhtcmAtIm7elX+stZ7/DViYhmlIdPtwhaKTU7fkGXcJiXwryRQdcCTuNPJyf
         gabVqfz96anKBAi7xU/+dzWY9oBrj4+6iTXouH7Wk0n62A18ip2tc6WoNk7nz4bvJ8IF
         fQk7LofU/9eogVspFMEL/oepuMwdoXfcvC6eUjgxBK2zB4iqZgm5RUSXiPMUkLz3SACy
         5IZiXK01H/aCPR45527RhPP0jimdmcDDLa8CUc4gAH0jq20dOQQdsqBrZukbKnrhMR5X
         a+6PPWcVBK17OjiRtv9t5wPHxlJlLAuoihizsKA7T8BSVHYD0O+HMD8WtD/+2J7rTwlI
         Mvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791823481; x=1792428281;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m7uLNSvnwZ8teVL1fB+yhjFqyopjcpDVtN+2BWDZq7o=;
        b=tGSN/PfJwS22BZ++W2Tlk9aGQJRqdpuJQ0lkYwrIYiVsLu4cHLR7EPW54F7MXRFDFm
         QwTGXjcnk0wXKnvD4HAPb0YHzVWQGRjQLwS1lLTsSMYnu4C0WqpEuenG8aY1eferCPHl
         QH6xeA581x0R4EuWPkAN458hziM4gcg9inrKB4UGdceTxs7hijQ3Nnge+v/Pb1H0PejX
         zYwvkl1Q22bGYziZ+uTvES6trKcb53bpCeOGFQRrVbnE6HpH6u6QuKcMRRx+3xSZA+j/
         MklAY3wOoPROXF3Qzo4ZYidrSQaZOJMtRtDLpnVYOUOHHUnWcAYEDm1hn8+UbS6zLmK+
         PDpw==
X-Gm-Message-State: AFq9FYKr86PGGoNwHzg4+uUC2u5x4Wmrzdm70aSm/gBUsvxxDJOCzHXV
	55QEiP2TSl+au5sxaGdgPN94qapA0CCOKAeWINLwwkmGYSVctsw+AG6TZPDa6iQqRk8zKU4oBvO
	PG4P04Q94llTyV2azTbkA1OTqlOtOqOmH7eLr2qC4SNjR8nE8+ncCYFW4//QLASUXwkilsg==
X-Gm-Gg: AYBFou32H/9BswITMjf4ffZzBtIvvQKVSOdVDkSZVxtIaMpFkUTlyFdApcsR3R9+5fe
	2htuN2jmzHxQGXlBsNwPNe3Pv0/d8W1eTFDiLhDxMjK0F2EsqmWxBhGaZHQO0eXEt/Zajvvgd3n
	+r8OKnfjZ3Kdp6TA2sZwO2Jt0IfXtvFh+aJzObX6F3on3Qt4g1khPiYI6xkNQGZPFMtJMQ3ZxVh
	LSooR/tlUg8zAbOjs4ocEX0AOVNJzlq/EbZfhttXs052G/Q+FuA4GueUC85L20xsdXx1V9yUi9p
	flx8jsKxIGCTp1kJBSu1xNo21B+xa+jezw6FZDsbcIXhyhRf4RweS8EsWPnYvgtOPsW3SLCjcWE
	QWoNn7+teQSNQQg==
X-Received: by 2002:a05:620a:a0ca:20b0:93e:c12c:f137 with SMTP id af79cd13be357-93ec12d0800mr1060277585a.82.1791823481156;
        Mon, 12 Oct 2026 09:44:41 -0700 (PDT)
X-Received: by 2002:a05:620a:a0ca:20b0:93e:c12c:f137 with SMTP id af79cd13be357-93ec12d0800mr1060273085a.82.1791823480416;
        Mon, 12 Oct 2026 09:44:40 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a197c465b4sm134323325e9.3.2026.10.12.09.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 09:44:39 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 18:44:23 +0200
Subject: [PATCH net-next v6 1/4] net: stmmac: take ownership of saved RX
 state at poll entry
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-stmmac-rx-mb-v6-1-2225050915c1@oss.qualcomm.com>
References: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
In-Reply-To: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
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
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: HzXsjM7bh1sbSi4QoQh_Bh_m18Dt_Zs2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfXytpYt/EPTgI/
 rCHdDZwa6Xb/DZxeymihRzroiwHIsLIBABEL+FlUWg5YKK3tmQee8egL6e+EDfGw3mBjUZHYWpN
 U4uLZtsBaI7OFSk/U/B+/7BHqT0pPf0=
X-Proofpoint-ORIG-GUID: HzXsjM7bh1sbSi4QoQh_Bh_m18Dt_Zs2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfXw2uvNh4itJYy
 nJaz0QhOR/npFWNzSOKHytLa+g6c0iItfHmQihAoTj9kL3owAE7xSYME4iGXcCcGSKrazmiuXtW
 pDWTG+YRxCcQfcKsvBHStbDMfPV+ONPw4TBw0E5TaUYME+bd3mhVPre7IWp+Yjawsj7kW6FYg1n
 RiW3qa6FszEnHvB4psD9WS1wPeRDNOMx/Ost2aHSYRiMqfvp5ktYs8TXYqtgSlUSx7jbA28I7Uk
 m1TOk+NZr28GPkVyTntn7nPGTca8uzFpcIn5EO87Y+Sl224wplFo9n7MMCX4dNyu7H9x+Puxw3X
 CMvUfNS/ba81v2eGKx3WIB1BiEXU8IP6nnXQVTDvYmWpQqYIOvCu2bRyHbTsII/CJuEuXIGNcge
 0we0nJqyuJSu+lNH7ECbFfQ9TGvUv6e0SIy3vZ+VpANsC3XDWTICl9GLIUSEE3jsJiflj+S/TAw
 PrGEQmU5im5RQKlT94g==
X-Authority-Analysis: v=2.4 cv=PbhqFShd c=1 sm=1 tr=0 ts=6acd0e7a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=-gjLCbu4MZEjzEcwt_QA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120066

From: James Hilliard <james.hilliard1@gmail.com>

When a saved partial packet completes with a poll budget of one, the
old loop can leave state_saved and state.skb pointing at an skb that
has already been delivered or freed. The next poll then reuses that
pointer, causing a use-after-free or double free.

Take the saved state at poll entry and clear the stored ownership
immediately. Save it again only if the packet remains incomplete,
including when the next descriptor is still DMA-owned.

Track the frame-in-progress flag independently of the status read from
the next descriptor. The old code keyed the save on the status of the
last descriptor looked at, so a loop stopped at a DMA-owned descriptor
(rx status not yet valid) could drop the saved error/length bookkeeping
in stmmac_rx_zc().

Drop the saved state both when the queue parameters are reset and when
the ring is destroyed. stmmac_reset_rx_queue() is reached from
__stmmac_open(), stmmac_xdp_open(), stmmac_resume() and
stmmac_enable_rx_queue(); without draining it there, a partial frame
saved before suspend (or before a queue is disabled and re-enabled)
survives while cur_rx and dirty_rx are re-armed, and the first poll
resumes that stale skb with descriptors from the freshly initialized
ring. __free_dma_rx_desc_resources() releases it on teardown.

Apply the same state handling to stmmac_rx_zc(), which also leaves
state_saved set when a saved frame finishes at the budget boundary.
That path saves only error and length bookkeeping, not an skb pointer.

Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")
Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 72 +++++++++++++----------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b8b4de4c5b1a..f66b796f7725 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2180,6 +2180,9 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 	else
 		dma_free_rx_skbufs(priv, dma_conf, queue);
 
+	dev_kfree_skb_any(rx_q->state.skb);
+	rx_q->state.skb = NULL;
+	rx_q->state_saved = false;
 	rx_q->buf_alloc_num = 0;
 	rx_q->xsk_pool = NULL;
 
@@ -5620,12 +5623,12 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 	unsigned int count = 0, error = 0, len = 0;
 	int dirty = stmmac_rx_dirty(priv, queue);
 	unsigned int next_entry = rx_q->cur_rx;
+	bool in_progress = rx_q->state_saved;
 	u32 rx_errors = 0, rx_dropped = 0;
 	unsigned int desc_size;
 	struct bpf_prog *prog;
 	bool failure = false;
 	int xdp_status = 0;
-	int status = 0;
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head = stmmac_get_rx_desc(priv, rx_q, 0);
@@ -5636,23 +5639,25 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
 				    rx_q->dma_rx_phy, desc_size);
 	}
+
+	if (rx_q->state_saved) {
+		error = rx_q->state.error;
+		len = rx_q->state.len;
+		rx_q->state_saved = false;
+	}
+
 	while (count < limit) {
 		struct stmmac_rx_buffer *buf;
 		struct stmmac_xdp_buff *ctx;
 		unsigned int buf1_len = 0;
 		struct dma_desc *np, *p;
-		int entry;
+		int entry, status;
 		int res;
 
-		if (!count && rx_q->state_saved) {
-			error = rx_q->state.error;
-			len = rx_q->state.len;
-		} else {
-			rx_q->state_saved = false;
+		if (!in_progress) {
 			error = 0;
 			len = 0;
 		}
-
 read_again:
 		if (count >= limit)
 			break;
@@ -5691,6 +5696,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (!buf->xdp)
 			break;
 
+		in_progress = status & rx_not_ls;
+
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats,
 						  rx_q->dma_erx + entry);
@@ -5763,7 +5770,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		count++;
 	}
 
-	if (status & rx_not_ls) {
+	if (in_progress) {
 		rx_q->state_saved = true;
 		rx_q->state.error = error;
 		rx_q->state.len = len;
@@ -5805,9 +5812,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
 	unsigned int count = 0, error = 0, len = 0;
-	int status = 0, coe = priv->hw->rx_csum;
 	unsigned int next_entry = rx_q->cur_rx;
+	bool in_progress = rx_q->state_saved;
 	enum dma_data_direction dma_dir;
+	int coe = priv->hw->rx_csum;
 	unsigned int desc_size;
 	struct sk_buff *skb = NULL;
 	struct stmmac_xdp_buff ctx;
@@ -5827,25 +5835,28 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
 				    rx_q->dma_rx_phy, desc_size);
 	}
+
+	if (rx_q->state_saved) {
+		skb = rx_q->state.skb;
+		error = rx_q->state.error;
+		len = rx_q->state.len;
+		rx_q->state.skb = NULL;
+		rx_q->state_saved = false;
+	}
+
 	while (count < limit) {
 		unsigned int buf1_len = 0, buf2_len = 0;
 		enum pkt_hash_types hash_type;
 		struct stmmac_rx_buffer *buf;
 		struct dma_desc *np, *p;
-		int entry;
+		int entry, status;
 		u32 hash;
 
-		if (!count && rx_q->state_saved) {
-			skb = rx_q->state.skb;
-			error = rx_q->state.error;
-			len = rx_q->state.len;
-		} else {
-			rx_q->state_saved = false;
+		if (!in_progress) {
 			skb = NULL;
 			error = 0;
 			len = 0;
 		}
-
 read_again:
 		if (count >= limit)
 			break;
@@ -5874,6 +5885,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		prefetch(np);
 
+		in_progress = status & rx_not_ls;
+
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
 		if (unlikely(status == discard_frame)) {
@@ -5886,11 +5899,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		if (unlikely(error && (status & rx_not_ls)))
 			goto read_again;
+
 		if (unlikely(error)) {
 			dev_kfree_skb(skb);
-			skb = NULL;
-			count++;
-			continue;
+			goto next;
 		}
 
 		/* Buffer is good. Go on. */
@@ -5964,9 +5976,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 						      STMMAC_XDP_REDIRECT)) {
 					xdp_status |= xdp_res;
 					buf->page = NULL;
-					skb = NULL;
-					count++;
-					continue;
+					goto next;
 				}
 			}
 		}
@@ -6023,10 +6033,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		/* Remove FCS if needed */
 		if (!fcs_stripped && pskb_trim(skb, len)) {
 			dev_kfree_skb_any(skb);
-			skb = NULL;
 			rx_dropped++;
-			count++;
-			continue;
+			goto next;
 		}
 
 		stmmac_get_rx_hwtstamp(priv, p, np, skb);
@@ -6051,14 +6059,15 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		skb_record_rx_queue(skb, queue);
 		napi_gro_receive(&ch->rx_napi, skb);
-		skb = NULL;
-
 		rx_packets++;
 		rx_bytes += len;
+next:
+		in_progress = false;
+		skb = NULL;
 		count++;
 	}
 
-	if (status & rx_not_ls || skb) {
+	if (in_progress || skb) {
 		rx_q->state_saved = true;
 		rx_q->state.skb = skb;
 		rx_q->state.error = error;
@@ -8378,6 +8387,9 @@ static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue)
 {
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 
+	dev_kfree_skb_any(rx_q->state.skb);
+	rx_q->state.skb = NULL;
+	rx_q->state_saved = false;
 	rx_q->cur_rx = 0;
 	rx_q->dirty_rx = 0;
 }

-- 
2.56.0


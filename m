Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428CB457E7F;
	Fri, 11 Sep 2026 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789115370; cv=none; b=kHz1h8WPqnw0PWkoxNttinlS4f80XsjSpUWPjciPLjBISf+Iijsnms4BJjaBKmlzPjmTkpsiLh2RSvkAJ6gNtUsXful1mwJcaZi4HJP1+rF1IQ2o9WZ+CejkO1pZTxxflzTSNvWhNNBwnwlwJnWxSHsestBrNaBFhe5QIhbzNZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789115370; c=relaxed/simple;
	bh=6CVP5GcFXHi3ZgM72VAnSfBOMr620cKsdYkpdMtypmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LIIu/0TfxFC0KIR+rlWYKFoHt3/PP3lE73je0eUFxlfe9svOrpPrH7+EDdlM1W7ao6+KQiZniEFvfglnMRFd0eJMjInbo1X5TJafhd9o1yrUhHp4xYPbevnaT27TsErT+SP1cnit84R9J3g6WgflnY4MwMsz4mJr9B4oH0esv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=pbh5wuar; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="pbh5wuar"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1789115345;
	bh=RL//GKIUhW/6C2BRjPuDBhhaE0pi+YpAlPAK2RaLvCE=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=pbh5wuarFa98h+S4YyRlzvSU9GajI/uuzuVZF3nbKnxp91Q2qAjSxzSljM3JIJIz1
	 5zkVjmMkbMIPWK4AeGz2BhD41qq+/yJa2BkKTm6VB5MBpBI4RipBYMXTCpUzMxJ45I
	 YXkpfyZqzyTV61cb4zscUJhMdzF+TVdDn/TCijOU=
X-QQ-mid: zesmtpsz3t1789115340tc43675da
X-QQ-Originating-IP: /hI0ol1iPIE9XVEfypdu4CfwXTtVb49TTBdhq2EL5Tg=
Received: from [10.10.7.69] ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 11 Sep 2026 16:28:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13687663228813789641
EX-QQ-RecipientCnt: 14
From: ZhaoJinming <zhaojinming@uniontech.com>
Date: Fri, 11 Sep 2026 16:28:48 +0800
Subject: [PATCH net v2] net: stmmac: fix stale descriptors and DMA mapping
 leak on Tx map failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-stmmac-fix-vlan-desc-leak-v2-1-817a8a4d4a76@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAL+7o2oC/32OwQ6CMAyGX4X0bE1HAogn38NwKFuRRRhkm4uG8
 O4uePf4tf//tRsE8VYCXIsNvCQb7OIylKcC9MjuIWhNZiiprKmlFkOcZ9Y42DemiR0aCRon4Sc
 OVDV9T7UyzJD7q5ecOtx3cBKhy8PRhrj4z3EvqWP1Uyv6o04KFdY9NUZzJZVcbi+XH42ix7NeZ
 uj2ff8CdyfpT8sAAAA=
X-Change-ID: 20260909-stmmac-fix-vlan-desc-leak-f057bb061daa
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>
X-Mailer: b4 0.14.2
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NJJwj9KsLFdtFrs3fxzT+mQAXCoUrCtOrhDGz4Y07aBG0M//w20xbSQ3
	Lt/hnAPe4FRyqZLhDPmXhE0sKFAIGXaoGO7DUGJt1VIrDeEFgf3+WiPMVXFseyKx6L96WIu
	oFtR4ZX3tiS6QgtfScouN3ekc860iWc5ISrcVED0UzAgaUPkLeiK//WrIptmWW9M8Kx8j+e
	pFq1OupB3FLIMEYJmAfyM3xB3ilXS5IJtqivN9zjckNJqcOAZmIKocmYSy6WyJpG32G8i9w
	yqU/ge3RewJG/3vi+20uczI/X6Zhm+anb4jbyFheDgBRW01QWyipXZ+R5ZP3JhDXRE8p8JO
	8ErIK3c91wL+2I/NVo+O/xQmxWUE++cVmZyUmrTFxaK4yTINkHxNBKmD0WWD1JJHhv6lIVd
	n4T71n6MqqYWsthQbv/taNqbZkNOMF7Yuq7MDUM5yM/mPn9+kB03cHFok6jDw0r74UuDFtZ
	aPVaSQuc6E5fmVPIZ9oAJ1CtcfdE4zy9IeRuzWRQ6u818Bgmm94vL/uxjmcR1xu2XZSh/lS
	AAtQgzt4YPZAAPNQO1jXX5yNZyqCJXUd+55LTmnKALGp2Z1uJ/o1ln/1khcd+b5YzrKY0Rm
	QTdA2RTXQSSneMPEmQldI0rlSZ4uL+5rHhgRYv6ioDEFSMwL6MxNDOvly+bsAXKk9rsyKmY
	kXuGztEoITfAzC7vqvXCRRQ3Wqh6ykmcv1pnkHNVrhHpBt9HaYVO2iymmxdnreAfANNWTkw
	snHkv0NZ67x1NbJbKzajQAq0lsevG+bNG9kCCldy0IVXp49pzZmhcibLWG0DM6ZR49e8mJK
	kGs85uaCAfVgHtplM+/oEWUul3GvLY6/HaDqkLVlMlc2VkCuKpWU7a4cuvaFcgCNpdLuDfm
	ahjGKz++1fukQhNg1cZZVlpWbpUjt+cwmT8+YDTpbI4pW11WtPtATjHmJprXMsWJZsG6lda
	BgWe8Dr4D5MyICoUoZPERVob5hXZAmMj3WNLkG3KHMdr08sdHfS6v6XnMbwrlLCqGdcfVhT
	dsczEfMwtZOIgeBbtKkKjU7f2CCva6ls5NvUjYHO2MRiIkOFm3
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

In stmmac_xmit(), when the DMA mapping of the linear part or of a
fragment fails, the error path only frees the skb.  This leaves behind
the DMA mappings already created for the linear part and for the
fragments mapped before the failure, which are never unmapped.

The VLAN context descriptor programmed by stmmac_vlan_insert() is also
left behind with its OWN bit set while tx_q->cur_tx has been advanced
past it, so the DMA engine later consumes the orphaned descriptor and
applies its stale VLAN tag to an unrelated frame.

Release the descriptors and their DMA mappings in the dma_map_err path
with stmmac_release_tx_desc() and stmmac_free_tx_buffer(), walking from
first_entry to entry, then roll back tx_q->cur_tx and release the VLAN
context descriptor.

jumbo_frm() has the same issue: when the DMA mapping of a subsequent
jumbo buffer fails, the buffers already mapped are never unmapped.
Unmap them before returning an error in both ring and chain modes.

Fixes: 30d932279dc2 ("net: stmmac: Add support for VLAN Insertion Offload")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
Changes in v2:
- Reorder stmmac_xmit() variable declarations in reverse xmas tree
  order.
- Unmap partially-mapped buffers in jumbo_frm() when a subsequent
  buffer mapping fails (ring and chain modes).
- Link to v1: https://lore.kernel.org/r/20260910-stmmac-fix-vlan-desc-leak-v1-1-6b07dca5e5e8@uniontech.com
---
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c  | 19 +++++++++++++--
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c   | 10 +++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 29 +++++++++++++++++++----
 3 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
index 66025e2509e91f863571041f5b148d04e3708832..8415c740ee9eee32cd8b4c3e9b61517690b58f9d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
@@ -20,6 +20,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 	unsigned int nopaged_len = skb_headlen(skb);
 	struct stmmac_priv *priv = tx_q->priv_data;
 	unsigned int entry = tx_q->cur_tx;
+	unsigned int first_entry = entry;
 	unsigned int bmax, buf_len;
 	unsigned int i = 1, len;
 	struct dma_desc *desc;
@@ -57,7 +58,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 					      bmax, DMA_TO_DEVICE);
 			desc->des2 = cpu_to_le32(lower_32_bits(des2));
 			if (dma_mapping_error(priv->device, des2))
-				return -1;
+				goto err_unmap;
 			tx_q->tx_skbuff_dma[entry].buf = des2;
 			tx_q->tx_skbuff_dma[entry].len = bmax;
 			stmmac_prepare_tx_desc(priv, desc, 0, bmax, csum,
@@ -70,7 +71,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 					      DMA_TO_DEVICE);
 			desc->des2 = cpu_to_le32(lower_32_bits(des2));
 			if (dma_mapping_error(priv->device, des2))
-				return -1;
+				goto err_unmap;
 			tx_q->tx_skbuff_dma[entry].buf = des2;
 			tx_q->tx_skbuff_dma[entry].len = len;
 			/* last descriptor can be set now */
@@ -83,6 +84,20 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 	tx_q->cur_tx = entry;
 
 	return entry;
+
+err_unmap:
+	while (first_entry != entry) {
+		dma_unmap_single(priv->device,
+				 tx_q->tx_skbuff_dma[first_entry].buf,
+				 tx_q->tx_skbuff_dma[first_entry].len,
+				 DMA_TO_DEVICE);
+		tx_q->tx_skbuff_dma[first_entry].buf = 0;
+		tx_q->tx_skbuff_dma[first_entry].len = 0;
+		first_entry = STMMAC_NEXT_ENTRY(first_entry,
+						priv->dma_conf.dma_tx_size);
+	}
+
+	return -1;
 }
 
 static bool is_jumbo_frm(unsigned int len, bool enh_desc)
diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index f7949419eb9fdca891a50ad0956f40e17f9b0967..4170c897bd1a8b5b757b576250e82e5407cfa325 100644
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -37,6 +37,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 	len = nopaged_len - bmax;
 
 	if (nopaged_len > BUF_SIZE_8KiB) {
+		unsigned int first_entry = entry;
 
 		des2 = dma_map_single(priv->device, skb->data, bmax,
 				      DMA_TO_DEVICE);
@@ -62,8 +63,15 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 		des2 = dma_map_single(priv->device, skb->data + bmax, len,
 				      DMA_TO_DEVICE);
 		desc->des2 = cpu_to_le32(lower_32_bits(des2));
-		if (dma_mapping_error(priv->device, des2))
+		if (dma_mapping_error(priv->device, des2)) {
+			dma_unmap_single(priv->device,
+					 tx_q->tx_skbuff_dma[first_entry].buf,
+					 bmax, DMA_TO_DEVICE);
+			tx_q->tx_skbuff_dma[first_entry].buf = 0;
+			tx_q->tx_skbuff_dma[first_entry].len = 0;
+			tx_q->tx_skbuff_dma[first_entry].is_jumbo = false;
 			return -1;
+		}
 		tx_q->tx_skbuff_dma[entry].buf = des2;
 		tx_q->tx_skbuff_dma[entry].len = len;
 		tx_q->tx_skbuff_dma[entry].is_jumbo = true;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 24656b35350b14454fb10deced6516eb89e2c0c9..9050611862108065dfa19c1a80961bd78073df9a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4767,15 +4767,15 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool enh_desc, has_vlan, set_ic, is_jumbo = false;
 	struct stmmac_priv *priv = netdev_priv(dev);
 	unsigned int nopaged_len = skb_headlen(skb);
+	unsigned int first_entry, entry, tx_packets;
 	u32 queue = skb_get_queue_mapping(skb);
 	int nfrags = skb_shinfo(skb)->nr_frags;
-	unsigned int first_entry, tx_packets;
 	struct stmmac_txq_stats *txq_stats;
 	struct dma_desc *desc, *first_desc;
 	struct stmmac_tx_queue *tx_q;
 	int i, csum_insertion = 0;
-	int entry, first_tx;
 	dma_addr_t dma_addr;
+	int first_tx, ret;
 	u32 sdu_len;
 
 	if (priv->tx_path_in_lpi_mode && priv->eee_sw_timer_en)
@@ -4832,9 +4832,10 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	csum_insertion = skb->ip_summed == CHECKSUM_PARTIAL;
 
 	if (unlikely(is_jumbo)) {
-		entry = stmmac_jumbo_frm(priv, tx_q, skb, csum_insertion);
-		if (unlikely(entry < 0) && (entry != -EINVAL))
+		ret = stmmac_jumbo_frm(priv, tx_q, skb, csum_insertion);
+		if (unlikely(ret < 0) && (ret != -EINVAL))
 			goto dma_map_err;
+		entry = ret;
 	} else {
 		bool last_segment = (nfrags == 0);
 
@@ -4984,6 +4985,26 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 dma_map_err:
 	netdev_err(priv->dev, "Tx DMA map failed\n");
+
+	/* entry points one past the last descriptor written for this frame:
+	 * on failure it is the descriptor whose DMA mapping failed, so walk
+	 * from first_entry up to, but not including, entry.  Reset cur_tx
+	 * unconditionally as both stmmac_vlan_insert() and stmmac_jumbo_frm()
+	 * may have advanced it, and release the VLAN context descriptor.
+	 */
+	while (first_entry != entry) {
+		desc = stmmac_get_tx_desc(priv, tx_q, first_entry);
+		stmmac_release_tx_desc(priv, desc, priv->descriptor_mode);
+		stmmac_free_tx_buffer(priv, &priv->dma_conf, queue, first_entry);
+		first_entry = STMMAC_NEXT_ENTRY(first_entry,
+						priv->dma_conf.dma_tx_size);
+	}
+
+	tx_q->cur_tx = first_tx;
+	if (has_vlan) {
+		desc = stmmac_get_tx_desc(priv, tx_q, first_tx);
+		stmmac_release_tx_desc(priv, desc, priv->descriptor_mode);
+	}
 max_sdu_err:
 	dev_kfree_skb(skb);
 	priv->xstats.tx_dropped++;

---
base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
change-id: 20260909-stmmac-fix-vlan-desc-leak-f057bb061daa

Best regards,
-- 
ZhaoJinming <zhaojinming@uniontech.com>


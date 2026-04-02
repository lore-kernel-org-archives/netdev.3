Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274B526E6E1
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147807; cv=none; b=VJHGNSxvJiCTQxksV77SoYpQWPitq6h3j/mJsm9BSmmNq6vPfVSZL+8kuPtdoSbQiOxX1Xoc6EMUpHN7Lsj0OpknaM4FErG8anHt/tV2gvoHFinZdJXXXL2srLNL05rKXT+IZ+6FhaDLJCet3z6YIykZWnckUbLg37KHXDeFaK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147807; c=relaxed/simple;
	bh=uLmS0HsUDr2BokeD+jSdwx3Xz2Gctb+uLNXQ4boAXU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MN45fptqyN2VOsMmNUhZYq0G6/o8MoEFoK8UNVHWkxyyXVW4vUKtT4w1/B9j6/9/Wq2kfimnSyefHKo64n+PixCvYuR8bDBJXYlSPMBumlLHVm7SfbToefT3ZItVeHmE3Gv89sJ7VtxCWMdhIJwx5/MEHTrolnz9KLeMpHukQ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwhXBHWn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwhXBHWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D028C19423;
	Thu,  2 Apr 2026 16:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775147806;
	bh=uLmS0HsUDr2BokeD+jSdwx3Xz2Gctb+uLNXQ4boAXU0=;
	h=From:Date:Subject:To:Cc:From;
	b=OwhXBHWnXxQbgi+Lr/d+FvS3AagvKuOJYOhfaXr08zbUSER3M5c3OxYjwjYv1c0Tj
	 ZF2yShxfaOil38PS1vqkSxJnvE4VW98G385tH3yHFDyuW4QVLvnkI7oY+1zX0wS5zg
	 hw9sCi/Ys6iEnDf6wIq55kG1f6CJQPU6PonA/mEcjhwBiuYNrf6y2pmrMvPfzPPoFW
	 Krb47bfx+9KYhZA1PL+O/O6uO0BY2p5MFBFgTYwUbbp/cN5PjKyosdYEEccBIkFbuj
	 w57xRsiPbM1DoOoiRjuGtpRRTujC1WyHHDN5ub32eSW8FfraqyrjDtfc/fPGKCMFUD
	 KDfUjKtjwIyuA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 02 Apr 2026 18:36:28 +0200
Subject: [PATCH net] net: airoha: Add dma_rmb() and READ_ONCE() in
 airoha_qdma_rx_process()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-airoha_qdma_rx_process-fix-reordering-v1-1-53278474f062@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2N0QrCMAwAf2Xk2UCNdoq/IqPUNW55sJ2JyGDs3
 w0+Hhx3GxirsMGt20D5KyatOhwPHYxzrhOjFGegQH04B8Is2uac3uWVk65p0TayGT5lReWmxXN
 1wgvRKVwpxkcfwVuLshv/zx0qf2DY9x9LzFK9fAAAAA==
X-Change-ID: 20260402-airoha_qdma_rx_process-fix-reordering-722308255b65
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Xuegang Lu <xuegang.lu@airoha.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Add missing dma_rmb() in airoha_qdma_rx_process routine to make sure the
DMA read operations are completed when the NIC reports the processing on
the current descriptor is done. Moreover, add missing READ_ONCE() in
airoha_qdma_rx_process() for DMA descriptor control fields in order to
avoid any compiler reordering.

Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 95ba99b89428e4cafb91ff7813e43ffeb38e6d9b..29dea8b35f64bfdcf88bc09fd711e0d8b4f7b6fa 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -612,15 +612,17 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 	while (done < budget) {
 		struct airoha_queue_entry *e = &q->entry[q->tail];
 		struct airoha_qdma_desc *desc = &q->desc[q->tail];
-		u32 hash, reason, msg1 = le32_to_cpu(desc->msg1);
-		struct page *page = virt_to_head_page(e->buf);
-		u32 desc_ctrl = le32_to_cpu(desc->ctrl);
+		u32 hash, reason, msg1, desc_ctrl;
 		struct airoha_gdm_port *port;
 		int data_len, len, p;
+		struct page *page;
 
+		desc_ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
 		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
 			break;
 
+		dma_rmb();
+
 		q->tail = (q->tail + 1) % q->ndesc;
 		q->queued--;
 
@@ -637,6 +639,7 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		if (p < 0 || !eth->ports[p])
 			goto free_frag;
 
+		page = virt_to_head_page(e->buf);
 		port = eth->ports[p];
 		if (!q->skb) { /* first buffer */
 			q->skb = napi_build_skb(e->buf, q->buf_size);
@@ -670,8 +673,8 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 			 * DMA descriptor. Report DSA tag to the DSA stack
 			 * via skb dst info.
 			 */
-			u32 sptag = FIELD_GET(QDMA_ETH_RXMSG_SPTAG,
-					      le32_to_cpu(desc->msg0));
+			u32 msg0 = le32_to_cpu(READ_ONCE(desc->msg0));
+			u32 sptag = FIELD_GET(QDMA_ETH_RXMSG_SPTAG, msg0);
 
 			if (sptag < ARRAY_SIZE(port->dsa_meta) &&
 			    port->dsa_meta[sptag])
@@ -679,6 +682,7 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 						  &port->dsa_meta[sptag]->dst);
 		}
 
+		msg1 = le32_to_cpu(READ_ONCE(desc->msg1));
 		hash = FIELD_GET(AIROHA_RXD4_FOE_ENTRY, msg1);
 		if (hash != AIROHA_RXD4_FOE_ENTRY)
 			skb_set_hash(q->skb, jhash_1word(hash, 0),

---
base-commit: ec7067e661193403a7a00980bda8612db5954142
change-id: 20260402-airoha_qdma_rx_process-fix-reordering-722308255b65

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


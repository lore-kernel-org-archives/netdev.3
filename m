Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD893446CA
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 03:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791344789; cv=none; b=N1EFJkhyCZPdzgr7fbpDiL4EmM/Da0xijpZFk8xwY8HedUypJlap+Kw3EyZUEXZW+sjee5LeQX4Jpka07vh8LaXHII6y1HE4z0/rQe7nAxz4TKwIAa6LpquXHydrfMR94oBEy3BkpW1xiFJ1vLW4k+Ta4jUVfq7sNwAKHfv5whA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791344789; c=relaxed/simple;
	bh=PAZt7RXdExcqJ7WRH5yaF6lHXDUYrWSlg/LlVWuqfSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrITOE74sdHrKEXOnL/mx8yDO4Rq1AdkX8QfTEQZIQEYTxzkKnWquLRgeHOvZ0lOQSyBwPrf8tUh4H6B1LpDIvSQD5K/2gt0ZHRoZGv1D6ovJ0oBHByx2ZlIMaGd4xm1/PVCSvLnJorNBzWDCknMppdxwGGkbIz6ZLap+fiZ1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyKjBBn5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyKjBBn5"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so40136285e9.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 20:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791344786; x=1791949586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ZsRuBkhBUg+LwbJLoNuYgv5+8GqPNF2cVHjSy/4rFo=;
        b=lyKjBBn5JUEfG7WKYz/c2nNefPdCTbWli2fjET/J4uw0/znXHPGlo9kZu927ftUEPo
         zaIXTP9AX2H0x+5+RgmXzs7S76OhnVIFSrGPA/0QwEzD16bY0fUnYcM35ZT+Vdmr8uGh
         W+fLUSkfVCseBovuFazOh7WbBfLBLg7gaiDi1aeKHG0TyTj8pxzfj7n2TsxfUHJK7DJf
         ef4ekGvwt2sPecK4bFCp9vhhY6zPW9Z0UqIL/b26vg/RWjELVjQOCwpG3ADyxMAYhDXY
         b1tQmbdazd09l5XLWPd5Z6ND7Vv1Hl5fhTRGv0NZmqP7/xAMWxLTWALJ78qckkJz4GNk
         O2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791344786; x=1791949586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ZsRuBkhBUg+LwbJLoNuYgv5+8GqPNF2cVHjSy/4rFo=;
        b=as85yG6oH8wGZMqTD20HoNpVHP5iPu5HFEYYNj8JJScaOtUJyBy481oQdLaFvgRHYB
         mHUUMB+hPYF3VktRjHLzycMQej6Z2l6FU5Mmh+A37BPOJM8kit7b5vwa4MP6KmCq44UJ
         L7vTFOhl0nUXP5G/f/JKGBm9S9RT+IS1/qnHyCL0S3LXxgjGt3DnlTv5WbbUTRxti4zf
         bUFFeEreC7Fp72pBPWRdA84ui51F8vZCa8wbg8PyHt15xJJPpgafPZvhrSwPxI8QfIto
         jv06SLabQbLppc96xNAtwYi1LeG8u/VIq9Xfeicr3wnyBGC9Wg+6uoNyIV8lfT+1codz
         vY5g==
X-Gm-Message-State: AFuF++lWkV+l0ikOxn+K2FXpqWN+o4E9jTgDtwTT5hLUEHJbdbOqFFoc
	gO5HVqLtdj4jFsjJNal8CFVEE7rq7/O1Xu00kUogGR/FjlcCIshh0ZiMSHa/Z6Ah
X-Gm-Gg: AYBFou2aEiWvYB0bm1h4R6f1Ltuhu8/UD80FNy5xSd7l1g8ObjHHt/Vy+4fHugpC5e8
	l5CEyUa06ZSvv8Fum9wklj+be8Vhmqmyoh3SoKJsm/1+Q6ky572b+uWOU6tkozPHagsZyUnDCxp
	GqUq+MEAi0Adl0NTYigQm+MiWT5n396xJFqHHCwRHH5gcrr/pKC3ip2FDVJ2pgC5YrtNE5/alH4
	jNCV4Vy0Qz+/6xobxPt8y0JWVvRNOrk+CxpVJirOmf8kQFmb78rUH2xuO2y7UbznoQyKif0jAbA
	1Geg5kuoLwNoI8t0OnrHQGVVLQ7JNul1x+Sc2p1N1vHyMw3TiqoGaE+7hfNY3IuGzlcRwL841Pl
	EFh+DcBLmDCeFLsH05YnzzgQcb/JWfm81nnz+pW4IEVbv0avH09WMYptOwu9R+4FXaITxgr6Wc2
	Ehy8aq71gw4lyN5pKEAqcXOFVG8Rkc/+LQTCC8LQVP1vzc2RsV/X1uRnyDdwuiiwbBjnCD/FyuO
	oxFNxeTzWpibASxQohIXPmvt7wk9T76j6qBfu6w
X-Received: by 2002:a05:600c:c165:b0:49c:ffab:551f with SMTP id 5b1f17b1804b1-4a181b33928mr731065e9.22.1791344785546;
        Tue, 06 Oct 2026 20:46:25 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1ffbcsm2763573f8f.36.2026.10.06.20.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 20:46:24 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: netdev@vger.kernel.org
Cc: radhey.shyam.pandey@amd.com,
	michal.simek@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	jacob.e.keller@intel.com,
	joe@dama.to,
	suraj.gupta2@amd.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net v4] net: axienet: free outstanding TX buffers in axienet_dma_bd_release()
Date: Wed,  7 Oct 2026 06:46:20 +0300
Message-ID: <20261007034620.1360542-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20261004083759.1016519-1-maimon.sagi@gmail.com>
References: <20261004083759.1016519-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

axienet_dma_bd_release() walks the RX ring to unmap and free every
receive buffer before releasing it, but frees the TX descriptor ring
with dma_free_coherent() alone.  Any descriptor that
axienet_free_tx_chain() had not yet reclaimed still holds its skb and
its streaming DMA mapping, and both are lost.

axienet_stop() disables TX NAPI and stops the DMA engine before calling
it, so nothing reclaims those descriptors afterwards.  Bringing the
interface down while frames are in flight therefore leaks up to
lp->tx_bd_num skbs and mappings each time.

axienet_dma_err_handler() already walks the TX ring this way before it
restarts the DMA engine: it unmaps every descriptor whose cntrl is still
set - axienet_free_tx_chain() clears it on reclaim - frees any skb still
attached, and clears the descriptor.  Move that loop into a helper,
axienet_free_tx_bufs(), and call it from axienet_dma_bd_release() too.
This relies on axienet_stop() having stopped the DMA engine first, as
the RX walk in the same function already does.  The helper frees the
skbs with dev_kfree_skb_any(), as drops: in the error handler, which
runs from a workqueue, that frees them directly rather than deferring
them to softirq as dev_kfree_skb_irq() did.

The walk must not run on a ring that is not there.  axienet_open() does
not check the result of the reset that runs axienet_dma_bd_init(), so
when that reset fails tx_bd_v is either still NULL or, after an earlier
close, points at the ring that close freed.  Clear tx_bd_v and rx_bd_v
once their rings are freed, and skip the walk when tx_bd_v is NULL.
That also ends the second dma_free_coherent() of a stale ring which the
same path already did.  On the axienet_dma_bd_init() error path the TX
ring has just been allocated zeroed, so the walk does nothing.

This was reported by the Sashiko AI review bot.

Tested on the AXI Ethernet MAC of an ADVA TimeCard X2 (PCIe card, with
the built-in AXI DMA): traffic passes, and after each of ten down/up
cycles and five module reloads, all made with traffic running and each
running axienet_dma_bd_release(), traffic resumes and nothing is logged.
The leak itself was not measured, and neither the failed-reset paths nor
axienet_dma_err_handler() were exercised.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Reviewed-by: Joe Damato <joe@dama.to>
Assisted-by: LLM sparse
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---

Notes:
    Changes in v4:
    - Move the TX ring walk of axienet_dma_err_handler() into a helper,
      axienet_free_tx_bufs(), and use it from axienet_dma_bd_release()
      instead of a second copy (Joe, Jakub).  The error handler now frees
      the skbs with dev_kfree_skb_any() instead of dev_kfree_skb_irq().
    - Kept Joe's Reviewed-by, as the helper is what he asked for; dropped
      Jacob's, as the error handler changes too.  Jacob, Joe: please take
      another look and say if either tag should change.
    - v3: https://lore.kernel.org/netdev/20261004083759.1016519-1-maimon.sagi@gmail.com/
    
    Changes in v3:
    - Clear tx_bd_v and rx_bd_v after freeing the rings.  v2 only caught a
      NULL tx_bd_v from a first open; after a close followed by a failed
      reset the walk would have read the freed ring (Sashiko).
    - Reword the comment on the skb free: a descriptor can complete after
      TX NAPI was disabled, so "never transmitted" was not always true
      (Sashiko).
    - Say in the commit message which hardware the test ran on.
    - v2: https://lore.kernel.org/netdev/20260930133851.663023-1-maimon.sagi@gmail.com/
    
    Changes in v2:
    - Skip the TX walk when tx_bd_v is NULL (Sashiko).
    - Free the skbs with dev_kfree_skb_any(), so they count as drops as in
      axienet_dma_err_handler() (Sashiko).
    - v1: https://lore.kernel.org/netdev/20260927081034.350422-1-maimon.sagi@gmail.com/

 .../net/ethernet/xilinx/xilinx_axienet_main.c | 74 +++++++++++++------
 1 file changed, 50 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 09443623a3e2..318ff03b04e6 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -173,6 +173,46 @@ static dma_addr_t desc_get_phys_addr(struct axienet_local *lp,
 	return ret;
 }
 
+/**
+ * axienet_free_tx_bufs - Release the buffers still held by the TX ring
+ * @lp:		Pointer to the axienet_local structure
+ *
+ * Unmap every descriptor whose mapping is still live, free any skb still
+ * attached, and clear the descriptor for reuse.  axienet_free_tx_chain()
+ * clears cntrl when it reclaims a descriptor, so a non-zero value means
+ * the mapping is live.  The DMA engine must be stopped.
+ */
+static void axienet_free_tx_bufs(struct axienet_local *lp)
+{
+	struct axidma_bd *cur_p;
+	u32 i;
+
+	for (i = 0; i < lp->tx_bd_num; i++) {
+		cur_p = &lp->tx_bd_v[i];
+		if (cur_p->cntrl) {
+			dma_addr_t addr = desc_get_phys_addr(lp, cur_p);
+
+			dma_unmap_single(lp->dev, addr,
+					 (cur_p->cntrl &
+					  XAXIDMA_BD_CTRL_LENGTH_MASK),
+					 DMA_TO_DEVICE);
+		}
+		/* not reclaimed by axienet_free_tx_chain(), so a drop */
+		if (cur_p->skb)
+			dev_kfree_skb_any(cur_p->skb);
+		cur_p->phys = 0;
+		cur_p->phys_msb = 0;
+		cur_p->cntrl = 0;
+		cur_p->status = 0;
+		cur_p->app0 = 0;
+		cur_p->app1 = 0;
+		cur_p->app2 = 0;
+		cur_p->app3 = 0;
+		cur_p->app4 = 0;
+		cur_p->skb = NULL;
+	}
+}
+
 /**
  * axienet_dma_bd_release - Release buffer descriptor rings
  * @ndev:	Pointer to the net_device structure
@@ -186,11 +226,18 @@ static void axienet_dma_bd_release(struct net_device *ndev)
 	int i;
 	struct axienet_local *lp = netdev_priv(ndev);
 
-	/* If we end up here, tx_bd_v must have been DMA allocated. */
+	/* tx_bd_v is NULL if axienet_dma_bd_init() did not get as far as
+	 * allocating it, and is cleared below once the ring is freed;
+	 * dma_free_coherent() accepts NULL.
+	 */
+	if (lp->tx_bd_v)
+		axienet_free_tx_bufs(lp);
+
 	dma_free_coherent(lp->dev,
 			  sizeof(*lp->tx_bd_v) * lp->tx_bd_num,
 			  lp->tx_bd_v,
 			  lp->tx_bd_p);
+	lp->tx_bd_v = NULL;
 
 	if (!lp->rx_bd_v)
 		return;
@@ -221,6 +268,7 @@ static void axienet_dma_bd_release(struct net_device *ndev)
 			  sizeof(*lp->rx_bd_v) * lp->rx_bd_num,
 			  lp->rx_bd_v,
 			  lp->rx_bd_p);
+	lp->rx_bd_v = NULL;
 }
 
 static u64 axienet_dma_rate(struct axienet_local *lp)
@@ -2749,29 +2797,7 @@ static void axienet_dma_err_handler(struct work_struct *work)
 	axienet_dma_stop(lp);
 	netdev_reset_queue(ndev);
 
-	for (i = 0; i < lp->tx_bd_num; i++) {
-		cur_p = &lp->tx_bd_v[i];
-		if (cur_p->cntrl) {
-			dma_addr_t addr = desc_get_phys_addr(lp, cur_p);
-
-			dma_unmap_single(lp->dev, addr,
-					 (cur_p->cntrl &
-					  XAXIDMA_BD_CTRL_LENGTH_MASK),
-					 DMA_TO_DEVICE);
-		}
-		if (cur_p->skb)
-			dev_kfree_skb_irq(cur_p->skb);
-		cur_p->phys = 0;
-		cur_p->phys_msb = 0;
-		cur_p->cntrl = 0;
-		cur_p->status = 0;
-		cur_p->app0 = 0;
-		cur_p->app1 = 0;
-		cur_p->app2 = 0;
-		cur_p->app3 = 0;
-		cur_p->app4 = 0;
-		cur_p->skb = NULL;
-	}
+	axienet_free_tx_bufs(lp);
 
 	for (i = 0; i < lp->rx_bd_num; i++) {
 		cur_p = &lp->rx_bd_v[i];

base-commit: 23609bce9e1de525d1d0e73fc68c6e7971d0b49e
-- 
2.47.0


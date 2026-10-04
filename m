Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8218F390C8D
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791103087; cv=none; b=e+HRu2NchQOh6hNOCK2t8tM6GrkcHaOzMxIMoS2pnWI5nG8Zsm++QIEvOGFO3zBHXsH6aDwF208aqLdiuwsdKOg4SDnxwQK77NemsHl7HKNnBIQ5ebG47zoC6FEmkoQhRHwOWtOkRpg5n9H53cDg58DOp5OFYXQpuBjAfvrRkfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791103087; c=relaxed/simple;
	bh=z4RzOrKDb588quTWl5K8AHG+o8U6K6BzoqWIihT5pvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=st3vm0p27znSOk/7bpAZMe40BIBJpn/Gb0KxW8XKCvk8lboENJvF6KuDZPsjhn0c7dYSlKDnPnHasTX8FstQ3ZQaXhii2i8kr6aNz/4+T3oXNIe1O7HP1a2Z2ipxXVPnFXZJJOVDqDPfAWQnW5CFXKASjSM4AaGYJSobHj65wRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzoBOQ6k; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzoBOQ6k"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so5383105e9.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 01:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791103083; x=1791707883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=McuNVp32CTxlLQ2QlE0pJplIh7P/8gxpjbSLGhtHHVw=;
        b=MzoBOQ6k++FfKG1vuDMndhLIACrHFYydq3OKwbz+viPJtujTbM1ZTmzRhpAbpONEj6
         Bvu669MMrXrKSouZIqI5wUR+UNQkm22Kh+NSVOeOQMMz64vv/fELfCT9/ily8rl9AL7B
         MNHIG6NKFKuZNTTvFa/QaeACOR4RBb2YfrfXuoFssgoCT6lYqV5YN7VNG2OsXdiDKpxw
         uz1hZA3HdTOmEe9/cGETDs+K30Z0oIcZhnBoPHnxke185OucsacqBkem2sCkAbQ/ecuN
         ooux204lnERXunnD6sGawoW4czu+e0xpzXydcQV993CHVnjpenpe8xVLhwiyzDlVyoD2
         UV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791103083; x=1791707883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=McuNVp32CTxlLQ2QlE0pJplIh7P/8gxpjbSLGhtHHVw=;
        b=qy5pHtFhqIALOWjVJtZ0wvfKFdBAUzsQfA81Ym+EvnwP4UTouE0AU/oaTu7yqiwJXk
         588niGcfdxLBqpt+U2jFdsapOUa2cYeKjfOwnEv/vMv+gsBeNEiw738mqVQVQT3HonwN
         QcvmBwxeouCtcZH9y0adARBGJ3JW29+OH/MSo56J93JcVT8RHUejU/8W4UDeaQSscgI0
         Ndj7qmCpnfdyYob69wRH0F+OWtI5XfAqScMS4gD8+oIYuzpM9qjP3TJmUBS7QBS27ewn
         h0dWCWi6V0Lr5DCeRA821gk+Cw8ERpL9MnQKQMJY2jqQowmAWU3jInlRU2R0VnDOx+kl
         ZLFg==
X-Gm-Message-State: AFuF++mb1pJGkDq3d4ESKc0sr/jM8bKdxmssVMdEWJqkMn2GLAYLOw5g
	zBXmd6FDHwkO1O2ApTg1k08AowKeGqELeX5f+z2w/nFzLnLDZo8hvI+FKdCd8fU8
X-Gm-Gg: AYBFou0Oe30Q3FCfe6ERj+rAqlxn/HwEgihoYXKyaIo6oOHLxHxPzZ6vEkU3SCbxitJ
	lAdWJf11/ksVA8u84dyF/amiM6VMoOaZOo6e21ey8Z0foPh+mVrBbt4ywm07RJY7MGnuWDpcqla
	HPsBibtn/jXQIvp9dUaQgAGTcXJMvEY93qIWoPxs3X6uMhDqeeB1pyTbI6TvgxzhpFDngeqhFsA
	MQhOorSJ/iDNhgRn7vyxv4GRafHQ/SAH3LFlOO78crFqqQmrYBFy87fG5zbCVP9+SO61r1TALQP
	YMQQ0fn1aRs3lv/l/LxtukMpuuWsLpnyr8lAu2AfHASKefunhpyvk+eJ51C0sb8YpkheSc+NFl9
	Cb25nrzDAviZI16VfYc2KtItQc1F4+OuZrCGsJwoorz/OaIUs87LbAfSzSfuuiE1pjLdiSmteB7
	iQk8n5d8LdQd3YNFL8t2u6dYpeiYklkDvNG+bEdEijndaloqIx9chQ38i7GhICOasj0qnnJiOQQ
	0fBfgvg1k2IUqbYlNcItYJgyIY1TbZrqyGpkdi8
X-Received: by 2002:a05:600c:3e07:b0:49f:fe39:5bc8 with SMTP id 5b1f17b1804b1-4a027585dfemr125622175e9.12.1791103083428;
        Sun, 04 Oct 2026 01:38:03 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027f2a4cfsm206540565e9.1.2026.10.04.01.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 01:38:02 -0700 (PDT)
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
Subject: [PATCH net v3] net: axienet: free outstanding TX buffers in axienet_dma_bd_release()
Date: Sun,  4 Oct 2026 11:37:59 +0300
Message-ID: <20261004083759.1016519-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
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

Walk the TX ring the way axienet_dma_err_handler() already does: unmap
every descriptor whose cntrl is still set - axienet_free_tx_chain()
clears it on reclaim - and free any skb still attached, as a drop.
This relies on axienet_stop() having stopped the DMA engine first, as
the RX walk in the same function already does.

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
The leak itself was not measured, and the failed-reset paths were not
exercised.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Assisted-by: LLM sparse
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---

Notes:
    Changes in v3:
    - Clear tx_bd_v and rx_bd_v after freeing the rings.  v2 only caught a
      NULL tx_bd_v from a first open; after a close followed by a failed
      reset the walk would have read the freed ring (Sashiko).
    - Reword the comment on the skb free: a descriptor can complete after
      TX NAPI was disabled, so "never transmitted" was not always true
      (Sashiko).
    - Say in the commit message which hardware the test ran on.
    - Kept Jacob's Reviewed-by, as the changes are small; please say if
      that is not OK.
    - The hardware test is v1's.  The changes since only affect the
      failed-reset paths, which it did not exercise, and how the freed skbs
      are accounted.
    - v2: https://lore.kernel.org/netdev/20260930133851.663023-1-maimon.sagi@gmail.com/
    
    Changes in v2:
    - Skip the TX walk when tx_bd_v is NULL (Sashiko).
    - Free the skbs with dev_kfree_skb_any(), so they count as drops as in
      axienet_dma_err_handler() (Sashiko).
    - v1: https://lore.kernel.org/netdev/20260927081034.350422-1-maimon.sagi@gmail.com/

 .../net/ethernet/xilinx/xilinx_axienet_main.c | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 09443623a3e2..c88c671f8b2d 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -186,11 +186,34 @@ static void axienet_dma_bd_release(struct net_device *ndev)
 	int i;
 	struct axienet_local *lp = netdev_priv(ndev);
 
-	/* If we end up here, tx_bd_v must have been DMA allocated. */
+	/* tx_bd_v is NULL if axienet_dma_bd_init() did not get as far as
+	 * allocating it, and is cleared below once the ring is freed;
+	 * dma_free_coherent() accepts NULL.
+	 */
+	for (i = 0; lp->tx_bd_v && i < lp->tx_bd_num; i++) {
+		struct axidma_bd *cur_p = &lp->tx_bd_v[i];
+
+		/* axienet_free_tx_chain() clears cntrl when it reclaims a
+		 * descriptor, so a non-zero value means the mapping is live.
+		 */
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
+	}
+
 	dma_free_coherent(lp->dev,
 			  sizeof(*lp->tx_bd_v) * lp->tx_bd_num,
 			  lp->tx_bd_v,
 			  lp->tx_bd_p);
+	lp->tx_bd_v = NULL;
 
 	if (!lp->rx_bd_v)
 		return;
@@ -221,6 +244,7 @@ static void axienet_dma_bd_release(struct net_device *ndev)
 			  sizeof(*lp->rx_bd_v) * lp->rx_bd_num,
 			  lp->rx_bd_v,
 			  lp->rx_bd_p);
+	lp->rx_bd_v = NULL;
 }
 
 static u64 axienet_dma_rate(struct axienet_local *lp)

base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
-- 
2.47.0


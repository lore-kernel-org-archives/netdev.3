Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1337A2C21F2;
	Sun,  1 Mar 2026 01:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329641; cv=none; b=PmjuZGVCQx5U/JzYlL+tMER9XIYMmbot3vuo/TBQSb9PaswZwNx3urvidaa7vMzeihyE2sUPmmVYSCM3GgwtKWGBFUu16hMvzpWbnnnLLWD8hBbmdZ0TIDDWmMPyuNxtKro5ioatUIILl3xtgN1olq9M3H/I3Rtw2a2swFHei/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329641; c=relaxed/simple;
	bh=1trQEGkKTKRdzT5fnsVduQTOCtCVju6e1vyMNymHyfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C/MKlwxOGXW2DGVvpwli/wnkxf1GSGLOv166Cg5FO9gkiq9ZLjFCy8Py6RiEELe+/sjnjV+jK7QzJil1uUniEmxVw2XbMUPWdPi+OJlUs+GhYBTig2Uv8Vg4UlVSHCA0EkIm67fkph96aG+RE6d4IvjnKKLURsYxsBhYXNg0PUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adOfaWN8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adOfaWN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C02C19421;
	Sun,  1 Mar 2026 01:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329641;
	bh=1trQEGkKTKRdzT5fnsVduQTOCtCVju6e1vyMNymHyfE=;
	h=From:To:Cc:Subject:Date:From;
	b=adOfaWN8AnhRUrIcWkI5N5Gcy6PlQRzxlYBaNy2HUvppXSijHvwfLdL9XA1ZsISoE
	 Od0N5QZbv6PE+PfPAbHSQphEIV/SLDEleA1+I14FZUMZ54+8Vf88L/1iPWYVcqTrpe
	 UyepBpUVbwxQ+GwAIhxFn0JTo5jeL3BYqY20lfKc2LSYisBwtrw2iPKjYGwvfFY1kg
	 xQiJnzj5Z/uufhlLgkN2h5Uxu39bOymqg+r4a08iA50FTNcG1dVC6x3NCqZYjpx4rt
	 X/6lhxyHed3yGOnflYINkIYGS4Ue0G7nNLw76Br9t2rQhTPkPL1/mef8Cq1R9TDIYB
	 03W3N76wPmEfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	haokexin@gmail.com
Cc: Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: macb: Fix tx/rx malfunction after phy link down and up" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:47:18 -0500
Message-ID: <20260301014719.1711250-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bf9cf80cab81e39701861a42877a28295ade266f Mon Sep 17 00:00:00 2001
From: Kevin Hao <haokexin@gmail.com>
Date: Sun, 8 Feb 2026 16:45:52 +0800
Subject: [PATCH] net: macb: Fix tx/rx malfunction after phy link down and up

In commit 99537d5c476c ("net: macb: Relocate mog_init_rings() callback
from macb_mac_link_up() to macb_open()"), the mog_init_rings() callback
was moved from macb_mac_link_up() to macb_open() to resolve a deadlock
issue. However, this change introduced a tx/rx malfunction following
phy link down and up events. The issue arises from a mismatch between
the software queue->tx_head, queue->tx_tail, queue->rx_prepared_head,
and queue->rx_tail values and the hardware's internal tx/rx queue
pointers.

According to the Zynq UltraScale TRM [1], when tx/rx is disabled, the
internal tx queue pointer resets to the value in the tx queue base
address register, while the internal rx queue pointer remains unchanged.
The following is quoted from the Zynq UltraScale TRM:
  When transmit is disabled, with bit [3] of the network control register
  set low, the transmit-buffer queue pointer resets to point to the address
  indicated by the transmit-buffer queue base address register. Disabling
  receive does not have the same effect on the receive-buffer queue
  pointer.

Additionally, there is no need to reset the RBQP and TBQP registers in a
phy event callback. Therefore, move macb_init_buffers() to macb_open().
In a phy link up event, the only required action is to reset the tx
software head and tail pointers to align with the hardware's behavior.

[1] https://docs.amd.com/v/u/en-US/ug1085-zynq-ultrascale-trm

Fixes: 99537d5c476c ("net: macb: Relocate mog_init_rings() callback from macb_mac_link_up() to macb_open()")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260208-macb-init-ring-v1-1-939a32c14635@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6511ecd5856bd..4ebb40adfab37 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -705,14 +705,12 @@ static void macb_mac_link_up(struct phylink_config *config,
 		if (rx_pause)
 			ctrl |= MACB_BIT(PAE);
 
-		/* Initialize rings & buffers as clearing MACB_BIT(TE) in link down
-		 * cleared the pipeline and control registers.
-		 */
-		macb_init_buffers(bp);
-
-		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+			queue->tx_head = 0;
+			queue->tx_tail = 0;
 			queue_writel(queue, IER,
 				     bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP));
+		}
 	}
 
 	macb_or_gem_writel(bp, NCFGR, ctrl);
@@ -2954,6 +2952,7 @@ static int macb_open(struct net_device *dev)
 	}
 
 	bp->macbgem_ops.mog_init_rings(bp);
+	macb_init_buffers(bp);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		napi_enable(&queue->napi_rx);
-- 
2.51.0





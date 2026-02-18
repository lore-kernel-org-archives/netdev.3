Received: from bm.lauterbach.com (bm.lauterbach.com [62.154.241.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFE62FF643
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.154.241.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771411786; cv=none; b=suea6Wfo7gXK7iV06Y4JKclew13TBk4HgqIaL6I/MfgTrTw/s6Lez3a7VSwcpuKs18EnbSS2ZLDlHiZlfXp2riTLA18PyuGXxmpJa3wsGfU56THgCjElkNCv0qSoB7woKq0I4fyuY2NU4GZX8KMefapX3Ws27nIHLHx3tC6aXwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771411786; c=relaxed/simple;
	bh=rwnJ9mwrCsxJTsYhhxdnmQvZc7D0S3fW/42jJaLFKk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=afJmt5FrzaZwn/VIAaYq/9Ond5fnGXEl57OAKXnI7frTY9+e64FEBib2cC0vr9BuSrbdEG9zSQs1hcF3wZfFio/VFwH+CAXbJeNROosC/JRNXJidqCUl+/KAFcpXdYFC7fLYW5ebdLUBsIQNdwpxrVMWDOxBzORaBT/hWNDI87w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lauterbach.com; spf=pass smtp.mailfrom=lauterbach.com; arc=none smtp.client-ip=62.154.241.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lauterbach.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lauterbach.com
Received: from ingpc2.intern.lauterbach.com (unknown [10.2.10.44])
	(Authenticated sender: ingo.rohloff@lauterbach.com)
	by bm.lauterbach.com (Postfix) with ESMTPSA id EB518577FB85;
	Wed, 18 Feb 2026 11:43:43 +0100 (CET)
From: Ingo Rohloff <ingo.rohloff@lauterbach.com>
To: nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	Ingo Rohloff <ingo.rohloff@lauterbach.com>
Subject: [PATCH] net: macb: fix race condition in TX queue initialization
Date: Wed, 18 Feb 2026 11:43:25 +0100
Message-ID: <20260218104325.28381-1-ingo.rohloff@lauterbach.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1771411424011

Commit bf9cf80cab81e ("net: macb: Fix tx/rx malfunction after phy link
down and up") initializes queue->tx_head and queue->tx_tail to zero
without holding queue->tx_ptr_lock.

As established in commit 99537d5c476c ("net: macb: Relocate
mog_init_rings() callback from macb_mac_link_up() to macb_open()"),
macb_start_xmit() and macb_mac_link_up() can execute concurrently.
Consequently, modifying the TX pointers without locking creates a race
condition.

To resolve this, this patch ensures that the netif tx queues are stopped
before the device is registered via register_netdev().  The TX queues are
now enabled only at the end of macb_mac_link_up() rather than during
macb_open(). This avoids concurrent execution of macb_mac_link_up()
and macb_start_xmit() thus avoiding the race condition.

This is consistent with the behavior of macb_mac_link_down(),
which also stops the tx queues.

Signed-off-by: Ingo Rohloff <ingo.rohloff@lauterbach.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 43cd013bb70e..2fe0e843627f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2973,8 +2973,6 @@ static int macb_open(struct net_device *dev)
 	if (err)
 		goto phy_off;
 
-	netif_tx_start_all_queues(dev);
-
 	if (bp->ptp_info)
 		bp->ptp_info->ptp_init(dev);
 
@@ -5607,6 +5605,7 @@ static int macb_probe(struct platform_device *pdev)
 	if (err)
 		goto err_out_phy_exit;
 
+	netif_tx_stop_all_queues(dev);
 	netif_carrier_off(dev);
 
 	err = register_netdev(dev);
-- 
2.52.0


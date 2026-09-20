Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980B72E7387;
	Sun, 20 Sep 2026 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789898368; cv=none; b=pYJK7n6z2d9alPxSVdHVWHNcmaDjHb5LhdWRlG+Sn2iyO/+ecX1pMkjDAvLZiGOLtz7YD3LYgXqkgDBUQp7LwkJdm6pGyHX1TsBlBBiQ5okicm/l2TVf86gxmwq0Nz9VfnhSKwag0JcjIk4P1NiONZMlMaD/HxFyx4xmk2Z5IMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789898368; c=relaxed/simple;
	bh=3mZygXS8hcdF9UOcYnhziL96HcLNndS5lt7/g0olpI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IkMFqHJ/nQT0bqb3uoJ4P9ntgsMq47eKBlb3jOOuT4eacQD6uRPu1xZXYbpqj48s+usGeULdlJz6WHzq7dtYUzSi83kQvUHfGhcCUyRpL7YWzpFkH1uKaZ3KnUJUBkB+9A/+R9srZJezOkVUNvK347SDlMcULM1e8hY7pSl1zAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WDhsEfd5; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WDhsEfd5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=U0
	N8AvroK2i84JfujNVPvJ5wQkAktO+RLbUeaiRFkgs=; b=WDhsEfd51tjACogpnd
	GYqp+Pcvrsv6GxPg0jwQKlaV1yauJ2/ijSiac9pniweHfsLcLA3hGughz1O5OG9r
	R4FogOcFwS6pOzvrKT0YLLw+IqchvMubPW5qBL8Op1zMwt3BLsQx4ut5Fa960JrW
	WhhyCz9g1souo1gCPRkHnTaEY=
Received: from lx2.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3D0herq9qUuHOBw--.53419S2;
	Sun, 20 Sep 2026 17:58:55 +0800 (CST)
From: Zijin Tao <taozj888@163.com>
To: maintainer@kernel.org
Cc: linux-kernel@vger.kernel.org,
	theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	Zijin Tao <taozj888@163.com>
Subject: [PATCH] net: macb: rate limit netdev error info print in the data path
Date: Sun, 20 Sep 2026 17:58:39 +0800
Message-Id: <20260920095839.62852-1-taozj888@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3D0herq9qUuHOBw--.53419S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFWrAry3tw4kuFy5JrWxXrb_yoW5Aw4Upa
	yUCa95Ww4kGr47Cas7trWkAr1rAr95KryrW3ykGw13Xwn8Ar98WFyIkryYkFW8GFW3Aw1S
	kr1UZa9rCan5ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_xhldUUUUU=
X-CM-SenderInfo: hwdr6yqyyyqiywtou0bp/xtbC+h9JEWqvrl+NcQAA31

Now the MACB ethernet driver print the netdev error information
directly by netdev_err(), which would lead to a large number of
error information print if there was a significant number of
error or just jumbo packets received when booting.
For example, it would print a large number of:

macb PHYT0036:00 eth0: not whole frame pointed by descriptor
macb PHYT0036:00 eth0: not whole frame pointed by descriptor
...

in gem_rx() by received a large number of packets without
RX_SOF or RX_EOF flag set.

The unlimited print here would greatly bother and delay
the system booting process unless the source stop sending
packets.

So rate limit the netdev error information print in the receive
and transmit data path.

Signed-off-by: Zijin Tao <taozj888@163.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b8234ac4b602..c32d48d03008 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1617,16 +1617,16 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		count++;
 
 		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
-			netdev_err(bp->netdev,
-				   "not whole frame pointed by descriptor\n");
+			if (net_ratelimit())
+				netdev_err(bp->netdev, "not whole frame pointed by descriptor\n");
 			bp->netdev->stats.rx_dropped++;
 			queue->stats.rx_dropped++;
 			break;
 		}
 		skb = queue->rx_skbuff[entry];
 		if (unlikely(!skb)) {
-			netdev_err(bp->netdev,
-				   "inconsistent Rx descriptor chain\n");
+			if (net_ratelimit())
+				netdev_err(bp->netdev, "inconsistent Rx descriptor chain\n");
 			bp->netdev->stats.rx_dropped++;
 			queue->stats.rx_dropped++;
 			break;
@@ -1829,7 +1829,8 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 		unsigned long flags;
 		u32 ctrl;
 
-		netdev_err(bp->netdev, "RX queue corruption: reset it\n");
+		if (net_ratelimit())
+			netdev_err(bp->netdev, "RX queue corruption: reset it\n");
 
 		spin_lock_irqsave(&bp->lock, flags);
 
@@ -2102,7 +2103,8 @@ static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
 
 	if (status & MACB_BIT(HRESP)) {
 		queue_work(system_bh_wq, &bp->hresp_err_bh_work);
-		netdev_err(netdev, "DMA bus error: HRESP not OK\n");
+		if (net_ratelimit())
+			netdev_err(netdev, "DMA bus error: HRESP not OK\n");
 		macb_queue_isr_clear(bp, queue, MACB_BIT(HRESP));
 	}
 
@@ -2511,7 +2513,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 		else
 			hdrlen = skb_tcp_all_headers(skb);
 		if (skb_headlen(skb) < hdrlen) {
-			netdev_err(bp->netdev, "Error - LSO headers fragmented!!!\n");
+			if (net_ratelimit())
+				netdev_err(bp->netdev, "Error - LSO headers fragmented!!!\n");
 			/* if this is required, would need to copy to single buffer */
 			return NETDEV_TX_BUSY;
 		}
-- 
2.34.1


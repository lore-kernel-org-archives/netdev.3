Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7961332EDE
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788471946; cv=none; b=A/OVFy3sxjE6FZKvQcYq1RRWVcCJp7bx034OKugvthUavaj9Ya6X9O8+fJiffFyfs5t6W5zLYaMg0Kgz5XlCNM47VMPZJ2ZQHp1fPKHir8K8Px1CYGZoycQDXbaT/mXtG6AelISMfAwDgppCDu6tc67bFMO3rg8o0DkfoFufoWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788471946; c=relaxed/simple;
	bh=5mP6QiBZteZjAva7vOxjI3D8EFVRqrs9bfSCxitGvhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dUQ1DRxPB4WZwlstLwplt6TT1QuU7PxQaAVsV8na/wAdy2Y1HcV+kSdW1lE9Te/bFvNfa4iUAj+I8jNkq3DGe+YA1LsaFVEFIIux5eYI7nQu7C3uUNdhWZab83CxaK89aVg8g4o0JjGIPL5qsXiJbbd+NPvVFED5VOwnsav9W1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9dI6X5g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9dI6X5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E631F000E9;
	Thu,  3 Sep 2026 21:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788471945;
	bh=zoyTPvdjnUrEV+u/WyaurusFHQ3o2kL2AizErk75450=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=c9dI6X5ggNtOgc+VMzmlb63dkw8ZDN7eldkuNKEHRGDRnBBoFnPeFV+X066OYo0Xj
	 NnW66Sn3gxczI7r6YF33O5AZoIq/Oe0/WAwQaI+J0/hy3H6CIZHx1ew2IpUGZzz/5m
	 FnR8Lsje6fTta8mzX8+L+bVvNyU2WOHFP3zCuuvNV1fRDg6KYR061xLXTETSsV0mOz
	 rTZW/eNyPgcTUImrmbjVH0Epi4Xcp2PCbaLVcwtOIRorqpBEwgccbwlV1DB0UqApNw
	 areJF5IYlZ10OxggwzeZa+cIHTHQDI5h60wLrtqqzMubHc0nwy4zYMz6h78U/iVXHF
	 xHUWZ0ALA2CQg==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 03 Sep 2026 23:45:32 +0200
Subject: [PATCH v2 4/5] net: ethernet: cortina: Count RX drops once per
 frame
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-gemini-ethernet-fixes-v2-4-2bbbd598ca6e@kernel.org>
References: <20260903-gemini-ethernet-fixes-v2-0-2bbbd598ca6e@kernel.org>
In-Reply-To: <20260903-gemini-ethernet-fixes-v2-0-2bbbd598ca6e@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Joe Damato <joe@dama.to>
X-Mailer: b4 0.16.0

The absence of a partial skb means either that the driver is not
assembling a frame or that the current frame was already dropped.
Consequently, repeated descriptor errors can increment rx_dropped more
than once, while an orphaned descriptor chain can reach EOF without being
counted at all.

Track the dropping state across NAPI polls. Clear it at frame boundaries
and route mapping failures and orphaned continuations through the common
drop path so each discarded frame is counted exactly once.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Reported-by: Joe Damato <joe@dama.to>
Closes: https://lore.kernel.org/netdev/apdK5aMmvYssz35F@devvm20253.cco0.facebook.com/
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 41 ++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 33e9763b32fe..9ba8524fa371 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -124,6 +124,7 @@ struct gemini_ethernet_port {
 	unsigned int		rx_coalesce_nsecs;
 	struct sk_buff		*rx_skb;
 	unsigned int		rx_frag_nr;
+	bool			rx_dropping;
 
 	unsigned int		freeq_refill;
 	struct gmac_txq		txq[TX_QUEUE_NUM];
@@ -1451,6 +1452,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	struct gmac_rxdesc *rx = NULL;
 	struct gmac_queue_page *gpage;
 	unsigned int received = 0;
+	bool dropping = port->rx_dropping;
 	union gmac_rxdesc_0 word0;
 	union gmac_rxdesc_1 word1;
 	union gmac_rxdesc_3 word3;
@@ -1472,6 +1474,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	w = rw.bits.wptr;
 
 	while (budget && w != r) {
+		page = NULL;
 		rx = port->rxq_ring + r;
 		word0 = rx->word0;
 		word1 = rx->word1;
@@ -1485,6 +1488,16 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 		frame_len = word1.bits.byte_count;
 		page_offs = mapping & ~PAGE_MASK;
 
+		if (word3.bits32 & SOF_BIT) {
+			if (skb) {
+				napi_free_frags(&port->napi);
+				port->stats.rx_dropped++;
+				skb = NULL;
+				frag_nr = 0;
+			}
+			dropping = false;
+		}
+
 		if (!mapping) {
 			netdev_err(netdev,
 				   "rxq[%u]: HW BUG: zero DMA desc\n", r);
@@ -1495,24 +1508,11 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 		gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
 		if (!gpage) {
 			dev_err(geth->dev, "could not find mapping\n");
-			port->stats.rx_dropped++;
-			if (skb) {
-				napi_free_frags(&port->napi);
-				skb = NULL;
-				frag_nr = 0;
-			}
-			goto next_desc;
+			goto err_drop;
 		}
 		page = gpage->page;
 
 		if (word3.bits32 & SOF_BIT) {
-			if (skb) {
-				napi_free_frags(&port->napi);
-				port->stats.rx_dropped++;
-				skb = NULL;
-				frag_nr = 0;
-			}
-
 			skb = gmac_skb_if_good_frame(port, word0, frame_len);
 			if (!skb)
 				goto err_drop;
@@ -1522,8 +1522,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 			frag_nr = 0;
 
 		} else if (!skb) {
-			put_page(page);
-			goto next_desc;
+			goto err_drop;
 		}
 
 		if (word3.bits32 & EOF_BIT)
@@ -1556,21 +1555,26 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 			frag_nr = 0;
 		}
 
-		if (mapping)
+		if (page)
 			put_page(page);
 
-		port->stats.rx_dropped++;
+		if (!dropping) {
+			port->stats.rx_dropped++;
+			dropping = true;
+		}
 
 next_desc:
 		/* Final or single-descriptor fragment, advance things */
 		if (word3.bits32 & EOF_BIT) {
 			budget--;
 			received++;
+			dropping = false;
 		}
 	}
 
 	port->rx_skb = skb;
 	port->rx_frag_nr = frag_nr;
+	port->rx_dropping = dropping;
 	writew(r, ptr_reg);
 	return received;
 }
@@ -1900,6 +1904,7 @@ static int gmac_stop(struct net_device *netdev)
 	napi_disable(&port->napi);
 	port->rx_skb = NULL;
 	port->rx_frag_nr = 0;
+	port->rx_dropping = false;
 
 	gmac_enable_irq(netdev, 0);
 	gmac_cleanup_rxq(netdev);

-- 
2.55.0


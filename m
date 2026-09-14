Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE43042122C
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789421224; cv=none; b=SqBLsZ0xlxaOuZ6e3Ppw9LT8bf7as4of4OD/8GUrnovASAtqWTrxAs4UH4wDcbf0i8YuWofDGW2I4R3VUznThlJKaxQDf5vofrO47FGyNB2J1L6WjSxFZGFq8rOUPWzfFRf5I7bcmglJgBlr/ycRZcMCS2H8Mr0E1GOwJir7T5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789421224; c=relaxed/simple;
	bh=B0XaxOdn4PWALc1mAT3WvUWBd8R9okZKNICPgttUqDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IJoO7gilHC/7BTd7gXtuO04sMT2EY0ToluO4Ecvfivh9yDeSoBsA6GwsqT7bPji1Dk0IAyo2G4Kmq7YnxPTZYYT2lRP69oe/CS/1NrM+3+mkYYxalePGllsx7XufsNJxeSIW4m6N7ZyqwLcIFHk+ggG5OO+L4dv1gX2h4smzIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6zTUWu6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6zTUWu6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D274E1F000FF;
	Mon, 14 Sep 2026 21:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789421220;
	bh=YNXdJX06zgA3cDGkjCt/Rt7YOsqmtMEfBp4zPw22s9Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m6zTUWu6VcLXJdiqi5gP0zvB+FunJjdmPHe7z1Ze4hDcoprJUWTMvKJgVNmaLx+Yu
	 8HoArJoEx7oXk1noAefKxRN+sbcMeNvnquK+OJaZnhegcuw6dZTlZ58PXS5x0j/1m+
	 oxjPMUeAggAfGD5hki1up/JH5r55pPEr9y8A139YKXD2EuV4Kv58uoKQU9ZZv0gUK2
	 9lNtwuGtfqc8j1xFUUbBsrBNhX/ZDavBu3UfKavO/OnaUSKePyx/3PEW4YFPD77ANR
	 cCBRVjmmTlwF6Q8l3noFGivBlmi/dNO7L9KTMk1xicHXABKACzBZgYGjV6lotSae4A
	 EWXmnanDRg1sg==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 23:26:42 +0200
Subject: [PATCH net-next v2 2/2] net: ethernet: cortina: Bound RX
 descriptor processing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-b4-gemini-ethernet-fixes-2-v2-2-5ab39a047b90@kernel.org>
References: <20260914-b4-gemini-ethernet-fixes-2-v2-0-5ab39a047b90@kernel.org>
In-Reply-To: <20260914-b4-gemini-ethernet-fixes-2-v2-0-5ab39a047b90@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

NAPI budgets received packets, so gmac_rx() only consumes budget when an
EOF descriptor completes a frame. A malformed descriptor stream without
EOF can consequently make one poll consume the entire snapshotted RX ring,
which may contain up to 32768 descriptors. The error paths can also flood
the kernel log while doing so.

Keep the packet budget EOF-based, but impose a separate descriptor limit
which allows MAX_SKB_FRAGS descriptors for every packet in the budget. If
the limit is reached with descriptors still pending, return the full NAPI
budget to retain ownership and continue in another poll. Ratelimit errors
reported from malformed descriptor paths.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 2dd2fa801829..2fe7fd0202d2 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/net.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -736,7 +737,8 @@ gmac_get_queue_page(struct gemini_ethernet *geth,
 	mapping = addr & PAGE_MASK;
 
 	if (!geth->freeq_pages) {
-		dev_err(geth->dev, "try to get page with no page list\n");
+		dev_err_ratelimited(geth->dev,
+				    "try to get page with no page list\n");
 		return NULL;
 	}
 
@@ -1441,7 +1443,7 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
 }
 
 static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
-			    unsigned int *freeq_consumed)
+			    unsigned int *freeq_consumed, bool *reschedule)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	unsigned short m = (1 << port->rxq_order) - 1;
@@ -1449,6 +1451,8 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 	void __iomem *ptr_reg = port->rxq_rwptr;
 	unsigned int frag_nr = port->rx_frag_nr;
 	struct sk_buff *skb = port->rx_skb;
+	/* Bound malformed chains while allowing maximum fragments per frame. */
+	unsigned int desc_limit = budget * MAX_SKB_FRAGS;
 	unsigned int consumed = 0;
 	unsigned int frame_len, frag_len;
 	struct gmac_rxdesc *rx = NULL;
@@ -1475,7 +1479,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 	r = rw.bits.rptr;
 	w = rw.bits.wptr;
 
-	while (budget && w != r) {
+	while (budget && consumed < desc_limit && w != r) {
 		page = NULL;
 		rx = port->rxq_ring + r;
 		word0 = rx->word0;
@@ -1502,15 +1506,18 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 		}
 
 		if (!mapping) {
-			netdev_err(netdev,
-				   "rxq[%u]: HW BUG: zero DMA desc\n", r);
+			if (net_ratelimit())
+				netdev_err(netdev,
+					   "rxq[%u]: HW BUG: zero DMA desc\n",
+					   r);
 			goto err_drop;
 		}
 
 		/* Freeq pointers are one page off */
 		gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
 		if (!gpage) {
-			dev_err(geth->dev, "could not find mapping\n");
+			dev_err_ratelimited(geth->dev,
+					    "could not find mapping\n");
 			goto err_drop;
 		}
 		page = gpage->page;
@@ -1535,7 +1542,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 		if (frag_nr == MAX_SKB_FRAGS)
 			goto err_drop;
 
-		if (frag_len == 0)
+		if (frag_len == 0 && net_ratelimit())
 			netdev_err(netdev, "Received fragment with len = 0\n");
 
 		skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);
@@ -1579,6 +1586,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 	port->rx_frag_nr = frag_nr;
 	port->rx_dropping = dropping;
 	*freeq_consumed = consumed;
+	*reschedule = budget && w != r;
 	writew(r, ptr_reg);
 	return received;
 }
@@ -1590,12 +1598,13 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
 	unsigned int freeq_threshold;
 	unsigned int freeq_consumed;
 	unsigned int received;
+	bool reschedule;
 
 	freeq_threshold = 1 << (geth->freeq_order - 1);
 	u64_stats_update_begin(&port->rx_stats_syncp);
 
-	received = gmac_rx(napi->dev, budget, &freeq_consumed);
-	if (received < budget)
+	received = gmac_rx(napi->dev, budget, &freeq_consumed, &reschedule);
+	if (!reschedule && received < budget)
 		++port->rx_napi_exits;
 
 	u64_stats_update_end(&port->rx_stats_syncp);
@@ -1606,10 +1615,11 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
 		geth_fill_freeq(geth, true);
 	}
 
-	if (received < budget && napi_complete_done(napi, received))
+	if (!reschedule && received < budget &&
+	    napi_complete_done(napi, received))
 		gmac_enable_rx_irq(napi->dev, 1);
 
-	return received;
+	return reschedule ? budget : received;
 }
 
 static void gmac_dump_dma_state(struct net_device *netdev)

-- 
2.55.0


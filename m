Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA243BADA3
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282305; cv=none; b=DzMdlkODzoxh4/+wZ2wrBj6f/fXKNHuWqmPljrflnkxAUqmwhMSp+LY6pxpehba+i7RgSIsbKqGNxHnwcviQmU+WYsPbL+cuoc0Sb4RiKw08OCh5zx28whjyWoEFFzxicteAvw9Y+IObDxPOTHZLoLE8MJSCvwTiv7w6cGCbIoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282305; c=relaxed/simple;
	bh=/CU0TNqptAsUpKroICkXuv7dDSHYW34vdXjxIQg8w60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o1Sv2HHSW5FGY3wJmSvHxbAGCqodIGJJxTk2pkTmkCvrXrNcSQ+mIBfjr53ztZZfy/Oj52jjjsOo7CdUd/L+QNprxNrNwYNeVArhjJwy+X4nSYHlTqAr2d+QkB7wl2uYpZPCRv0oOQSZoEjJhdDL8+L0cnDWTulf9uw9gEXQh9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZyBGilT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZyBGilT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017591F000E9;
	Tue,  1 Sep 2026 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282304;
	bh=U4SGRgh9Gi1vrAPv/KDlxtWQubQWHpl4PurKXpM6V08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iZyBGilTCNqjlpTiWxv9PvylkwN5hwNos9XrmJ756rLG2ckcuwjZv6th2rLtHa8cH
	 1G5pp1P7j2kadNgElQFAjsRQpWkjtKQZTj8zSwCFw5OtHi6bVT8iEPjuCAEE8iz5Nj
	 Bv3vygwk672RxJkaN0rgEimAgIKKMNDTxGOFO1/pjct2jja3c6MHtzb1xMO52roQTL
	 mOrLaLaRWA02DBOpS1SajWwpVmZxasjzYNN7aXoTnegaRbBpKT4xGMmcqXqWSWmTPZ
	 tnJztquZuXNRmS9DQsW4dFEQcGZCE7yDsS1WS6kYUchwUZiPtrM81Ggwta1px7fVAp
	 QaNEJ8hvFRj0A==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 01 Sep 2026 19:04:56 +0200
Subject: [PATCH 2/3] net: ethernet: cortina: Count dropped frames as NAPI
 work
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-gemini-ethernet-fixes-v1-2-ee6b09675876@kernel.org>
References: <20260901-gemini-ethernet-fixes-v1-0-ee6b09675876@kernel.org>
In-Reply-To: <20260901-gemini-ethernet-fixes-v1-0-ee6b09675876@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The RX loop only consumes budget when it successfully delivers a frame.
Error paths keep consuming descriptors without reducing the budget, so a
stream of bad frames can process the entire receive ring in one poll.

Move the budget accounting to a common end-of-frame path. This counts
each completed frame as NAPI work whether it was delivered or dropped,
matching the behavior of the vendor driver.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 1d9824d1716c..699354604b93 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1450,7 +1450,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	unsigned int frame_len, frag_len;
 	struct gmac_rxdesc *rx = NULL;
 	struct gmac_queue_page *gpage;
-	unsigned int received = 0;
+	unsigned int work_done = 0;
 	union gmac_rxdesc_0 word0;
 	union gmac_rxdesc_1 word1;
 	union gmac_rxdesc_3 word3;
@@ -1501,7 +1501,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 				skb = NULL;
 				frag_nr = 0;
 			}
-			continue;
+			goto next_desc;
 		}
 		page = gpage->page;
 
@@ -1523,7 +1523,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 
 		} else if (!skb) {
 			put_page(page);
-			continue;
+			goto next_desc;
 		}
 
 		if (word3.bits32 & EOF_BIT)
@@ -1546,10 +1546,8 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 			napi_gro_frags(&port->napi);
 			skb = NULL;
 			frag_nr = 0;
-			budget--;
-			received++;
 		}
-		continue;
+		goto next_desc;
 
 err_drop:
 		if (skb) {
@@ -1562,12 +1560,18 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 			put_page(page);
 
 		port->stats.rx_dropped++;
+
+next_desc:
+		if (word3.bits32 & EOF_BIT) {
+			budget--;
+			work_done++;
+		}
 	}
 
 	port->rx_skb = skb;
 	port->rx_frag_nr = frag_nr;
 	writew(r, ptr_reg);
-	return received;
+	return work_done;
 }
 
 static int gmac_napi_poll(struct napi_struct *napi, int budget)
@@ -1575,27 +1579,27 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
 	struct gemini_ethernet_port *port = netdev_priv(napi->dev);
 	struct gemini_ethernet *geth = port->geth;
 	unsigned int freeq_threshold;
-	unsigned int received;
+	unsigned int work_done;
 
 	freeq_threshold = 1 << (geth->freeq_order - 1);
 	u64_stats_update_begin(&port->rx_stats_syncp);
 
-	received = gmac_rx(napi->dev, budget);
-	if (received < budget) {
+	work_done = gmac_rx(napi->dev, budget);
+	if (work_done < budget) {
 		napi_gro_flush(napi, false);
-		napi_complete_done(napi, received);
+		napi_complete_done(napi, work_done);
 		gmac_enable_rx_irq(napi->dev, 1);
 		++port->rx_napi_exits;
 	}
 
-	port->freeq_refill += received;
+	port->freeq_refill += work_done;
 	if (port->freeq_refill > freeq_threshold) {
 		port->freeq_refill -= freeq_threshold;
 		geth_fill_freeq(geth, true);
 	}
 
 	u64_stats_update_end(&port->rx_stats_syncp);
-	return received;
+	return work_done;
 }
 
 static void gmac_dump_dma_state(struct net_device *netdev)

-- 
2.55.0


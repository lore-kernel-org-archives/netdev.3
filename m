Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99113317145
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788471949; cv=none; b=L/PfzyF/nIulK9Joid9GwH0A0T/f4OJfeJXX9Wpyk+7SL6VaO6L7UPhTwyaaSXMYcQYs82ssNqQ5jmeRnzcTUcWVP++aukEB3tfTNlFwvYsI0B/G1+eRUXummXotFr+vjztSCuU+Kp7YQuLHfTqnvRp/bkoq39E6ZmnkLO7rx5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788471949; c=relaxed/simple;
	bh=XM5tchnEvp0UbDQ4nryqFRACGgUsN0er99FP5l+Ou28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AAiX4mDhztSd+j9FVJK+TSvC3dw09LqO6CAg18Yfz91mIU0lAm09zdToG4bl+9ucPKaJqKigO6DvvVpLWZx0mLakwEbUqa/4mio5OaRh3SFS7/FyaX/CyNB0OSoD4ReYL1tMGUz3OK2rcctYx77Ajf28FURpQNSRXg7revW/0/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdE4ndfU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdE4ndfU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE84B1F00A3D;
	Thu,  3 Sep 2026 21:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788471948;
	bh=SMerT6DU1GKb4cA6ubL44qhf3GuIA/SVIZXqVr/J7M8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TdE4ndfUQe2z9iniPNaRchaRSa7qwdZDKLPg4zEUn2naURjrobWL6G3DB2Xb38Q4c
	 N+SLfpTHqk6Xhixb2Vy53DYPP2B4Mv1btVeBjqCYceDiPnpFDSfngfav7T8OG9obe8
	 cGJ3S3hqLxWRQYahYysY5a478M5eJNyVq2ndEAiiVWxFn93LFiV5OhQFERX8Q1xR0Z
	 BUdhWK+deaFa8ii9UaWPz4hsvtmKpzEXVbzmBRDajCg1iMsXoP8pbqR9M8V0Psp7Sp
	 qrfHhZv4tmIVNrFdAOqf/sYbWAg4eLgBmINnBqnUGcUCdjYKNZp7znP7l968q9SCRx
	 kBicKjO/NXePA==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 03 Sep 2026 23:45:33 +0200
Subject: [PATCH v2 5/5] net: ethernet: cortina: Count RX descriptors for
 freeq refill
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-gemini-ethernet-fixes-v2-5-2bbbd598ca6e@kernel.org>
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

The software free queue provides one buffer fragment for every descriptor
moved to an RX queue. The refill heuristic instead advances by NAPI work,
which counts frames. A fragmented or discarded frame can consume several
queue entries while adding only one to the refill count.

Count the RX descriptors as they are consumed and report that separately
from NAPI work. Use the descriptor count to drive free queue refills.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Assisted-by: LLM
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 9ba8524fa371..f08de623e6f7 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1440,7 +1440,8 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
 	return skb;
 }
 
-static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
+static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
+			    unsigned int *freeq_consumed)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	unsigned short m = (1 << port->rxq_order) - 1;
@@ -1448,6 +1449,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	void __iomem *ptr_reg = port->rxq_rwptr;
 	unsigned int frag_nr = port->rx_frag_nr;
 	struct sk_buff *skb = port->rx_skb;
+	unsigned int consumed = 0;
 	unsigned int frame_len, frag_len;
 	struct gmac_rxdesc *rx = NULL;
 	struct gmac_queue_page *gpage;
@@ -1483,6 +1485,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 
 		r++;
 		r &= m;
+		consumed++;
 
 		frag_len = word0.bits.buffer_size;
 		frame_len = word1.bits.byte_count;
@@ -1575,6 +1578,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	port->rx_skb = skb;
 	port->rx_frag_nr = frag_nr;
 	port->rx_dropping = dropping;
+	*freeq_consumed = consumed;
 	writew(r, ptr_reg);
 	return received;
 }
@@ -1584,18 +1588,19 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
 	struct gemini_ethernet_port *port = netdev_priv(napi->dev);
 	struct gemini_ethernet *geth = port->geth;
 	unsigned int freeq_threshold;
+	unsigned int freeq_consumed;
 	unsigned int received;
 
 	freeq_threshold = 1 << (geth->freeq_order - 1);
 	u64_stats_update_begin(&port->rx_stats_syncp);
 
-	received = gmac_rx(napi->dev, budget);
+	received = gmac_rx(napi->dev, budget, &freeq_consumed);
 	if (received < budget)
 		++port->rx_napi_exits;
 
 	u64_stats_update_end(&port->rx_stats_syncp);
 
-	port->freeq_refill += received;
+	port->freeq_refill += freeq_consumed;
 	if (port->freeq_refill > freeq_threshold) {
 		port->freeq_refill -= freeq_threshold;
 		geth_fill_freeq(geth, true);

-- 
2.55.0


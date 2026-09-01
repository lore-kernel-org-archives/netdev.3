Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96E4854E7
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282308; cv=none; b=tYrpbEXdaFSanz0pVpOQUn3GotwwBpl98b6Dg/dy/v14SCgEKiWmYWl6tLu5GyiAnvcyrz8lP21ki7Jn4fDztXLRWbAInbnn3gSuWt/xIaLROXjxkUcI3ACotsju6JIthes8e0EhEz+Zi6vffeSsfh/XDo2NzAZ22a5Mg7hnqIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282308; c=relaxed/simple;
	bh=Sg55xPLPqWp0Vh0BV0X/eLFHRzOSnXvLEeiLnJNS9ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cifSaF67f1PbUjM8Z1FSF69zIMmEPZh1xC0b8OYanoJBLyRtkPZY/mEBvbZ8yyVAXH+zY5cPz/jCHGSiKkF1k8TyvW44jGAZB5Y57UpYDuP+0T6s0w4OwzVnkVyPCpVAX07UO1Sup8ZMNHPnPsWrlTtL+zsQbcD6ZXXpOHkv+Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9R5UHhl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9R5UHhl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0D91F00A3A;
	Tue,  1 Sep 2026 17:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282306;
	bh=DFDfNuhw/2X/LONs1HgPlOeB8WqNySvt7S2H6ApyEp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=U9R5UHhlJplPrQAvhWvzrGrkeC4sOJd+Mb2SOipVMJ0wt9nCJtAppB8x0l7JrZ8HX
	 hlISTRqxIJ27nvtKldwQlpQkhUuEjTSlHfuQT2kwsEq58qQkGjmePIfW268pT4OWvU
	 yT5YWEYBFZIcOmxo4MzRfXLy7sphnUzFqXCauDnNULhFOnh06pLLFVajbNqDiZsHmK
	 2z3haJ1zvo5rtBETPV7pQLRcvLBP40CuPvWHaW6YTdfIBclYhU4/eTaOTHDxMvRpl5
	 rrTGW5NDlGvj3Zp6LHx0QuhF3qxf50VugJIhZNTrfy8WtYGN2jVyXr9uh/d++kGdUq
	 2mJoxHkC9FT/A==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 01 Sep 2026 19:04:57 +0200
Subject: [PATCH 3/3] net: ethernet: cortina: Count RX descriptors for freeq
 refill
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-gemini-ethernet-fixes-v1-3-ee6b09675876@kernel.org>
References: <20260901-gemini-ethernet-fixes-v1-0-ee6b09675876@kernel.org>
In-Reply-To: <20260901-gemini-ethernet-fixes-v1-0-ee6b09675876@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The software free queue provides one buffer fragment for every descriptor
moved to an RX queue. The refill heuristic instead advances by NAPI work,
which counts frames. A fragmented or discarded frame can consume several
queue entries while adding only one to the refill count.

Count the RX descriptors as they are consumed and report that separately
from NAPI work. Use the descriptor count to drive free queue refills.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 699354604b93..c17b06159f55 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1439,7 +1439,8 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
 	return skb;
 }
 
-static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
+static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
+			    unsigned int *freeq_consumed)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	unsigned short m = (1 << port->rxq_order) - 1;
@@ -1447,6 +1448,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	void __iomem *ptr_reg = port->rxq_rwptr;
 	unsigned int frag_nr = port->rx_frag_nr;
 	struct sk_buff *skb = port->rx_skb;
+	unsigned int consumed = 0;
 	unsigned int frame_len, frag_len;
 	struct gmac_rxdesc *rx = NULL;
 	struct gmac_queue_page *gpage;
@@ -1480,6 +1482,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 
 		r++;
 		r &= m;
+		consumed++;
 
 		frag_len = word0.bits.buffer_size;
 		frame_len = word1.bits.byte_count;
@@ -1570,6 +1573,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 
 	port->rx_skb = skb;
 	port->rx_frag_nr = frag_nr;
+	*freeq_consumed = consumed;
 	writew(r, ptr_reg);
 	return work_done;
 }
@@ -1579,12 +1583,13 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
 	struct gemini_ethernet_port *port = netdev_priv(napi->dev);
 	struct gemini_ethernet *geth = port->geth;
 	unsigned int freeq_threshold;
+	unsigned int freeq_consumed;
 	unsigned int work_done;
 
 	freeq_threshold = 1 << (geth->freeq_order - 1);
 	u64_stats_update_begin(&port->rx_stats_syncp);
 
-	work_done = gmac_rx(napi->dev, budget);
+	work_done = gmac_rx(napi->dev, budget, &freeq_consumed);
 	if (work_done < budget) {
 		napi_gro_flush(napi, false);
 		napi_complete_done(napi, work_done);
@@ -1592,7 +1597,7 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
 		++port->rx_napi_exits;
 	}
 
-	port->freeq_refill += work_done;
+	port->freeq_refill += freeq_consumed;
 	if (port->freeq_refill > freeq_threshold) {
 		port->freeq_refill -= freeq_threshold;
 		geth_fill_freeq(geth, true);

-- 
2.55.0


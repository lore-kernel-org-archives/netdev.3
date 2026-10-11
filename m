Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A153130C37C
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742023; cv=none; b=QHmyLfoMk1PooYUcLA2v0XuNdWtU3nYGIHrd6ciFOhfN1qEptPqW+/h8XI4gqtaetOAG0q5q2X0ijy6HVxkE8CNE7kt1mfZf1kjtAqNXcjga7eINkHIDKvuXmxks0h5YCUYn5aynYKPn4qkWL5DQtqri2vfAg1+Ykai9uokP1qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742023; c=relaxed/simple;
	bh=iNBu1AMN2/xiq2NG9Dg+Zik2Nvek1vM0L1+SJwKA4G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b+RASuQYzGOcLslno08z/+kZjJNihYhLiTBw564Z7zEHgmuH6jD9o8xRO71l18zRP+8cC3HT7G4Ky99TUNrlqLThkaaHleHaGfFaglgh1wYaq65Ix/bK4Cmj35vS+doUcvmzN6D83M9TSZaJ8Nz9P8qZq1/Dwjkdf/D6ZpnReg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9IOjd9Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9IOjd9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DF81F0089C;
	Sun, 11 Oct 2026 18:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791742022;
	bh=g2xPhcThbaHXjkiqreODmVi5aT2iHUD13lvyufbJxj0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=V9IOjd9Z+bIIX9tJUOfoTYVNn4FSSSS6aixswtdXgP3t6VuJ2DVAO6tVpOn+HdddN
	 t1/rqoamuZZ0N4pSIWahpZqdof2x4M58Azv8bEDDxQvZpNt1frs4Wk9kD0uaPSwvU7
	 6oS/+87oPFFt7Nr2rRoNsG6PgEWZgR4N1kvNbmesb57+C5zVA2MiNaiBBku3BLCm+3
	 MiAAVv/qbqY1iYxh+ciZL9sgvKhuox/2lHeRK5tBb3u1Vnh6vNcOaRsYW/Kw2bkXaU
	 XUqoZZlS8kTjnQeXuAaWYxcg9YhjJIenXtixNw1bxTJV94gvW60zK3pvoLerw/L337
	 nhQqlzxT4K58w==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 11 Oct 2026 20:06:28 +0200
Subject: [PATCH net-next v4 15/15] net: ethernet: cortina: Scope RX
 statistics updates
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-gemini-ethernet-fixes-3-v4-15-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

On 32-bit systems u64_stats_update_begin() disables preemption. The RX
poll currently holds that writer section across gmac_rx(), which takes
spinlock_t locks and calls into GRO and fragment handling. On PREEMPT_RT,
spinlock_t can sleep and must not be acquired with preemption disabled.

Keep the writer sections around the counter updates only. NAPI ownership
continues to serialize normal RX writers, while the stop path updates its
counter after napi_disable(). This preserves the existing accounting
without covering potentially sleeping operations.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index a61bace61ea4..9f7946876d58 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1712,12 +1712,12 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
 	unsigned int rx_status = word0.bits.status;
 	struct sk_buff *skb = NULL;
 
-	port->rx_stats[rx_status]++;
-	port->rx_csum_stats[rx_csum]++;
-
 	if (word0.bits.derr || word0.bits.perr ||
 	    rx_status || frame_len < ETH_ZLEN ||
 	    rx_csum >= RX_CHKSUM_IP_ERR_UNKNOWN) {
+		u64_stats_update_begin(&port->rx_stats_syncp);
+		port->rx_stats[rx_status]++;
+		port->rx_csum_stats[rx_csum]++;
 		port->stats.rx_errors++;
 
 		if (frame_len < ETH_ZLEN || RX_ERROR_LENGTH(rx_status))
@@ -1728,6 +1728,7 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
 			port->stats.rx_crc_errors++;
 		if (RX_ERROR_FRAME(rx_status))
 			port->stats.rx_frame_errors++;
+		u64_stats_update_end(&port->rx_stats_syncp);
 		return NULL;
 	}
 
@@ -1739,8 +1740,12 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 update_exit:
+	u64_stats_update_begin(&port->rx_stats_syncp);
+	port->rx_stats[rx_status]++;
+	port->rx_csum_stats[rx_csum]++;
 	port->stats.rx_bytes += frame_len;
 	port->stats.rx_packets++;
+	u64_stats_update_end(&port->rx_stats_syncp);
 	return skb;
 }
 
@@ -1798,7 +1803,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 		if (word3.bits32 & SOF_BIT) {
 			if (skb) {
 				napi_free_frags(&port->napi);
+				u64_stats_update_begin(&port->rx_stats_syncp);
 				port->stats.rx_dropped++;
+				u64_stats_update_end(&port->rx_stats_syncp);
 				skb = NULL;
 				frag_nr = 0;
 			}
@@ -1883,7 +1890,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			put_page(page);
 
 		if (!dropping) {
+			u64_stats_update_begin(&port->rx_stats_syncp);
 			port->stats.rx_dropped++;
+			u64_stats_update_end(&port->rx_stats_syncp);
 			dropping = true;
 		}
 
@@ -1915,13 +1924,13 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
 	bool reschedule;
 
 	freeq_threshold = 1 << (geth->freeq_order - 1);
-	u64_stats_update_begin(&port->rx_stats_syncp);
 
 	received = gmac_rx(napi->dev, budget, &freeq_consumed, &reschedule);
-	if (!reschedule && received < budget)
+	if (!reschedule && received < budget) {
+		u64_stats_update_begin(&port->rx_stats_syncp);
 		++port->rx_napi_exits;
-
-	u64_stats_update_end(&port->rx_stats_syncp);
+		u64_stats_update_end(&port->rx_stats_syncp);
+	}
 
 	port->freeq_refill += freeq_consumed;
 	if (port->freeq_refill > freeq_threshold) {

-- 
2.56.0


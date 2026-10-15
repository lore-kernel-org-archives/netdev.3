Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92935437FC
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077891; cv=none; b=naUzdOnzYdybXIDJ5kgXc5Fv+2KwjuCj8JtAiuw+gt+22A3npqsRCNqVDSqs6zFS/UA7w6wNgOXXRs1Ik0Kb8GxcszeYp7dJKcIdUJ3+osQtfGx9KVMHrUyF99Oe+yevduukOrk2DiZoljb2YBwV3JYsjq2LDNwGNbgaAjptxhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077891; c=relaxed/simple;
	bh=W0KwablKEbwj8N9DFVZf3NLcO3HfonJ6T24gtbrxmAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GooIeZrGo8cv5G8jYxdZopIMdZH8Mw1Htko7N+HHQ8j/GDJfkogQFZDZcwBmrZSaE4PJ10syVxn1GwGsCH+RgSlA0DXU6fA24ahX+DEMYx4x/Z+bWSYWBPRYYfEfORMpQdSwCwQbq/tIzi62UhfUs2vhtw0diB884pI4upbGylE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cizVzwzh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cizVzwzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679E01F000C6;
	Thu, 15 Oct 2026 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077886;
	bh=5ZcM7EBP44PpXaf/zgXyTQUveyarTAsiLlGuIb1FWZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cizVzwzhCqMrfeIU4ozBC5pvLKIIIXk3W+XSWRIVTI3195I76sFwGrImohC9MSKcM
	 dK9LcoCMtIBCJIM/tRxcs7LuUKmJUa4uHdIyLij81Sh7IvThid2bqDlgbtTnRqQxTY
	 uTwgjdgFLbcUPvT0pqRvZtP1ym7iv0rFk36qrCc6AFGp0XTscQ6nsfOkVXvUINuUC1
	 Vwgu/BP+K9SW62qQ4oC6AYmmowm//X/Yju52xfUahOSl+BJuRo3NYUQlrIM6KwGHj2
	 TBKfdaw+7YphuWMs7IqW/TXTmWIXnonLTgp0sPje6Bx3U7kgj3G9G+xVmMdhL7jtiW
	 i86TFd/WRIrNQ==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 15 Oct 2026 17:24:14 +0200
Subject: [PATCH net-next v5 14/14] net: ethernet: cortina: Scope RX
 statistics updates
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-gemini-ethernet-fixes-3-v5-14-b5c9e2f7b8a3@kernel.org>
References: <20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3@kernel.org>
In-Reply-To: <20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

On 32-bit PREEMPT_RT systems u64_stats_update_begin() disables
preemption. The RX poll currently holds that writer section across
gmac_rx(), which takes spinlock_t locks and calls into GRO and fragment
handling. spinlock_t can sleep on PREEMPT_RT and must not be acquired
with preemption disabled.

Keep the writer sections around the counter updates only. NAPI ownership
continues to serialize normal RX writers, while the stop path updates its
counter after napi_disable(). This preserves the existing accounting
without covering potentially sleeping operations.

The issue was found by inspecting the u64_stats_sync writer scope. The
series was tested on a D-Link DIR-685 with media playback and ksmbd
transfers under ping load. PREEMPT_RT was not runtime-tested.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 0c6c7c938b2e..7ecc8db9b7d3 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1720,12 +1720,12 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
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
@@ -1736,6 +1736,7 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
 			port->stats.rx_crc_errors++;
 		if (RX_ERROR_FRAME(rx_status))
 			port->stats.rx_frame_errors++;
+		u64_stats_update_end(&port->rx_stats_syncp);
 		return NULL;
 	}
 
@@ -1747,8 +1748,12 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
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
 
@@ -1806,7 +1811,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 		if (word3.bits32 & SOF_BIT) {
 			if (skb) {
 				napi_free_frags(&port->napi);
+				u64_stats_update_begin(&port->rx_stats_syncp);
 				port->stats.rx_dropped++;
+				u64_stats_update_end(&port->rx_stats_syncp);
 				skb = NULL;
 				frag_nr = 0;
 			}
@@ -1898,7 +1905,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			put_page(page);
 
 		if (!dropping) {
+			u64_stats_update_begin(&port->rx_stats_syncp);
 			port->stats.rx_dropped++;
+			u64_stats_update_end(&port->rx_stats_syncp);
 			dropping = true;
 		}
 
@@ -1930,13 +1939,13 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
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

